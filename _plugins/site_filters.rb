
require 'liquid'
require 'natural_sort'

module Jekyll
  module SiteFilters

    $nil_compare_prioritized = false
    $print_debug = false

    def render_liquid(input)
      out = Liquid::Template.parse(input)
      out.registers[:site] = @context.registers[:site]
      out.render
    end

    def render_markdown(input)
      @context.registers[:site].find_converter_instance(
        Converters::Markdown
      ).convert(input.to_s.strip).strip[3...-4]
    end

    def render_full(input)
      render_markdown(render_liquid(input))
    end

    def with_debug(input, method, *args)
      $print_debug = true
      puts '==DEBUG PRINT ENABLED=='
      ret = @context.invoke(method, input, *args)
      puts '==DEBUG PRINT DISABLED=='
      $print_debug = false
      ret
    end

    def render_missed_footnotes(input, print = false)
      input.gsub(/\[\^.+?\]/) do |str|
        p(str, 'raw', print)
        p("<span markdown=\"1\" class=\"footnote-replacement-wrapper\">#{str}</span>", 'wrapped', print)
      end
    end

    def fragments(site, *target_values)
      clean_fragments(_fragments(site, target_values))
    end

    def fragments_replace(site, replacements, *target_values)
      clean_fragments(replace_in_fragments(_fragments(site, target_values), replacements))
    end

    def _fragments(site, *target_values)
      multi_where(site['fragments'], 'cat', target_values)
    end

    def absent(input, property)
      Liquid::StandardFilters::InputIterator.new(input).select do |item|
        item[property].nil?
      end
    end

    def multi_where(input, property, *target_values)
      ary = Liquid::StandardFilters::InputIterator.new(input)
      flatten_array(target_values).each do |target_value|
        ary = ary.select do |item|
          raise "'#{to_console(item)['title']}' is incompatible with '#{property}' property" if item[property].nil?

          item[property].include?(target_value)
        end
      end
      ary
    end

    def multi_sort(input, *properties)
      _multi_sort(input, flatten_array(properties), false)
    end

    def multi_sort_print(input, *properties)
      _multi_sort(input, flatten_array(properties), true)
    end

    def _multi_sort(input, properties, print)
      print = true.to_s.eql?(print.to_s)
      raise "Cannot use 'sort' value to sort objects, it causes *many* headaches" if properties.include?('sort')

      ary = Liquid::StandardFilters::InputIterator.new(input)

      return [] if ary.empty?
      raise "Cannot sort input #{input}, must be able to handle :[]" unless ary.all? { |e| e.respond_to?(:[]) }

      begin
        ary.sort { |a, b| multi_sort_comp(a, b, properties, print) }
      rescue => e
        puts "Error sorting #{input}: #{e}"
        raise e
      end
    end

    def multi_sort_comp(first, second, properties, print)
      r = i = 0
      while r.zero? && i < properties.length
        pa = first[properties[i]]
        pb = second[properties[i]]
        r = compare(pa, pb)
        puts "Comparison of #{pa} with #{pb} yielded #{r}" if print
        i += 1
      end
      r
    end

    def replace_inline(input, map, page = nil)
      debug('__ inline __', input)
      map.each do |match, replacement|
        rendered = render_replacement(replacement, page)
        debug("#{match} ==> #{rendered}")
        input = input.gsub(/\[\[\s*?#{match}\s*?\]\]/, rendered)
      end
      debug('__ V __', input)
      input
    end

    def replace_in_fragments(input, map, print = false)
      out = []
      if $print_debug
        m = {}
        map.each do |k, v|
          m[k] = render_replacement(v) # render w/out page context
        end
        debug('=====w/out page=====', map, '=====V=====', m, '---   ---')
      end
      Liquid::StandardFilters::InputIterator.new(input).each do |f|
        f = dup(f)
        content = get_content(f, print)
        debug('=====w/ page=====')
        content = replace_inline(content, map, f)
        debug('=====V=====', content, '---   ---')
        f['clean'] = content
        out.push(f)
      end
      out
    end

    def clean_fragments(input)
      out = []
      Liquid::StandardFilters::InputIterator.new(input).each do |f|
        f = dup(f)
        content = get_content(f)
        debug(content)
        anchor = f['anchor']

        content = content.gsub(%r{<h[2-6].+?</h[2-6]>}) do |str|
          # Hoist headings down a level, purely so the markdown linter stops complaining
          str.match(%r{<h([2-6])(.+?)</h[2-6]>}) do |m|
            size = (m[1].to_i + 1).to_s
            "<h#{size}#{m[2]}</h#{size}>"
          end
        end
        f['clean'] = content.gsub(/(?:id|href)="#?(?:fn|fnref):/) do |str|
          # Make footnotes unique per-fragment
          str.match(/(id|href)="(#?)(fn|fnref):/) do |m|
            "#{m[1]}=\"#{m[2]}#{anchor}-#{m[3]}:"
          end
        end
        out.push(f)
      end
      out
    end

    def get_or_default(input, get, default)
      g = input[get]
      g.nil? ? input[default] : g
    end

    def get_or_else(input, get, fallback)
      g = input[get]
      g.nil? ? fallback : g
    end

    def script_type(input)
      input.eql?('common') ? 'client_scripts` & `server_scripts' : "#{input}_scripts"
    end

    def to_console(input)
      puts "#{input} {#{input.class}}"
      input
    end

    def extract_from_context(name)
      @context[name]
    end

    def dump_from_context(input)
      puts @context[input].inspect
      ''
    end

    def len(input)
      input.length
    end

    def map_console(input, property, delim = false)
      puts(Liquid::StandardFilters::InputIterator.new(input).map { |e| e[property] })
      puts '=====' if delim
      input
    end

    def print_sort(input, property)
      input.map { |i| [i.data[property.to_s], i] }
           .sort! do |i1, i2|
             p1 = i1.first
             p2 = i2.first
             puts "#{p1} {#{p1.class}} from #{i1}"
             puts "#{p2} {#{p2.class}} from #{i2}"
             puts ''
             p1 <=> p2
           end
           .map!(&:last)
    end

    # https://gist.github.com/jbgo/4493822
    def do_with_stack(input, method, *args)
      puts "Inspecting stack of #{method}#{args}"
      $stack_tracing = false
      trace_out = open("#{method}_trace.txt", 'w')

      set_trace_func proc { |event, file, line, id, _binding, classname|
        trace_out.puts "#{file}:#{line} #{classname}##{id}" if $stack_tracing && event == 'call'
      }

      $stack_tracing = true
      begin
        @context.invoke(method, input, *args)
      rescue SystemStackError => e
        puts "Overflow occurred in #{method}!"
        raise e
      ensure
        $stack_tracing = false
      end
    end

    def with_indent(input, indent = 8)
      input.gsub("\n", "\n#{' ' * indent}")
    end

    def compare(first, second)
      a = first.nil?
      b = second.nil?
      if a && b
        0
      elsif a
        $nil_compare_prioritized ? -1 : 1
      elsif b
        $nil_compare_prioritized ? 1 : -1
      else
        NaturalSort::Engine.comparator(first.to_s, second.to_s)
      end
    end

    def prioritize_nil(input, method, *args)
      $nil_compare_prioritized = true
      ret = @context.invoke(method, input, *args)
      $nil_compare_prioritized = false
      ret
    end

    def dup(doc_drop)
      if doc_drop['copy']
        doc_drop
      else
        doc = doc_drop.instance_variable_get(:@obj)
        dup = Document.new(doc.path, :site => doc.site, :collection => doc.collection)
        dup.read
        site = Jekyll.sites[0]
        dup.output = Renderer.new(site, dup, site.site_payload).run
        l = dup.to_liquid
        l['copy'] = true
        l
      end
    end

    def get_content(doc_drop, print = false)
      if doc_drop['clean']
        puts "#{doc_drop['title']}: clean" if print || $print_debug
        doc_drop['clean']
      elsif doc_drop['output']
        puts "#{doc_drop['title']}: output" if print || $print_debug
        doc_drop['output']
      else
        puts "#{doc_drop['title']}: content (#{doc_drop['content']})" if print || $print_debug
        doc_drop['content']
      end
    end

    def render_replacement(replace, page = nil)
      debug("     (raw) ==> #{replace}")
      replaced = replace.to_s.strip.gsub('\#', '#').gsub(/\[\[\s*?(.+?)\s*?\]\]/) do |m|
        m = m.strip[2...-2].strip
        debug("==> #{m}")
        page.nil? ? 'nil' : page[m]
      end
      debug("(replaced) ==> #{replaced}")
      rendered = render_full(replaced)
      debug("(rendered) ==> #{rendered}")
      rendered
    end

    def flatten_array(arr)
      if arr.is_a?(Array)
        flattened = []
        arr.each { |e| flattened.push(*flatten_array(e)) }
        flattened
      else
        [arr]
      end
    end

    def p(val, desc, print)
      puts "#{desc}: (#{val.class}) #{val}" if print || $print_debug
      val
    end

    def debug(*any)
      return unless $print_debug

      flatten_array(any).each { |o| puts o }
    end

    private(:compare, :dup, :get_content, :render_replacement, :multi_sort_comp, :flatten_array, :p, :debug)
  end
end

Liquid::Template.register_filter(Jekyll::SiteFilters)
