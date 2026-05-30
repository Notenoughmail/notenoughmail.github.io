
require 'liquid'
require 'natural_sort'

module Jekyll
  module SiteFilters

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

    def multi_where(input, property, target_values)
      ary = Liquid::StandardFilters::InputIterator.new(input)
      target_values.each do |target_value|
        ary = ary.select do |item|
          raise "'#{to_console(item)['title']}' is incompatible with '#{property}' property" if item[property].nil?

          item[property].include?(target_value)
        end
      end
      ary
    end

    def multi_sort(input, properties, print = false)
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
      while r == 0 && i < properties.length
        pa = first[properties[i]]
        pb = second[properties[i]]
        r = compare(pa, pb)
        puts "Comparison of #{pa} with #{pb} yielded #{r}" if print
        i += 1
      end
      r
    end

    def replace_inline(input, map, print = false, page = nil)
      puts 'inline___' if print
      map.each do |match, replacement|
        rendered = render_replacement(replacement, print, page)
        puts "#{match} ==> #{rendered}" if print
        input = input.gsub(
          /\[\[\s*?#{match}\s*?\]\]/,
          rendered
        )
      end
      input
    end

    def replace_in_fragments(input, map, print = false)
      out = []
      if print
        m = {}
        map.each do |k, v|
          m[k] = render_replacement(v, true) # render w/out page context
        end
        puts '=====w/out page====='
        puts map
        puts '=====V====='
        puts m
        puts '---   ---'
      end
      Liquid::StandardFilters::InputIterator.new(input).each do |f|
        f = dup(f)
        content = get_content(f, print)
        if print
          puts '=====w/ page====='
          puts content
        end
        content = replace_inline(content, map, print, f)
        if print
          puts '=====V====='
          puts content
          puts '---   ---'
        end
        f['clean'] = content
        out.push(f)
      end
      out
    end

    def clean_fragments(input, print = false)
      out = []
      Liquid::StandardFilters::InputIterator.new(input).each do |f|
        f = dup(f)
        content = get_content(f)
        puts content if print
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
      if !g.nil?
        g
      else
        input[default]
      end
    end

    def get_or_else(input, get, fallback)
      g = input[get]
      if !g.nil?
        g
      else
        fallback
      end
    end

    def script_type(input)
      if input.eql?('common')
        'client_scripts` & `server_scripts'
      else
        "#{input}_scripts"
      end
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

    def map_console(input, property, delin = false)
      puts(Liquid::StandardFilters::InputIterator.new(input).map { |e| e[property] })
      puts "=====" if delin
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
        1
      elsif b
        -1
      else
        NaturalSort::Engine.comparator(first.to_s, second.to_s)
      end
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
        puts '===clean===' if print
        doc_drop['clean']
      elsif doc_drop['output']
        puts '===output===' if print
        doc_drop['output']
      else
        puts '===content===' if print
        doc_drop['content']
      end
    end

    def render_replacement(r, print = false, page = nil)
      replaced = r.to_s.strip
                  .gsub('\#', '#')
                  .gsub(%r{\[\[\s*?(.+?)\s*?\]\]}) do |m|
                    m = m.strip[2...-2].strip
                    puts "==> #{m}" if print
                    page.nil? ? 'nil' : page[m]
                  end
      puts "   (replaced) ==> #{replaced}" if print
      liquid = render_liquid(replaced)
      puts "     (liquid) ==> #{liquid}" if print
      md = render_markdown(liquid)
      puts "   (markdown) ==> #{md}" if print
      md
    end

    private(:compare, :dup, :get_content, :render_replacement, :multi_sort_comp)
  end
end

Liquid::Template.register_filter(Jekyll::SiteFilters)
