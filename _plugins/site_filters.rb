
require 'liquid'

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
          raise "'#{item['title']}' is incompatible with '#{property}' property" if item[property].nil?

          item[property].include?(target_value)
        end
      end
      ary
    end

    def multi_sort(input, properties)
      ary = Liquid::StandardFilters::InputIterator.new(input)

      return [] if ary.empty?
      raise "Cannot sort input #{input}, must be able to handle :[]" unless ary.all? { |e| e.respond_to?(:[]) }

      begin
        ary.sort do |a, b|
          r = 0
          i = 0
          loop do
            r = compare(a[properties[i]], b[properties[i]])
            i += 1
            break if r != 0 || i >= properties.length
          end
          r
        end
      rescue => e
        puts "Error sorting #{input}"
        puts e
        raise e
      end
    end

    def replace_inline(input, map)
      map.each do |match, replacement|
        input = input.gsub(
          /\[\[\s*?#{match}\s*?\]\]/,
          render_replacement(replacement)
        )
      end
      input
    end

    def replace_in_fragments(input, map, print = false)
      out = []
      m = {}
      map.each do |k, v|
        m[k] = render_replacement(v)
      end
      Liquid::StandardFilters::InputIterator.new(input).each do |f|
        f = dup(f)
        content = get_content(f, print)
        puts content if print
        m.each do |match, replacement|
          content = content.gsub(/\[\[\s*?#{match}\s*?\]\]/, replacement)
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
      ""
    end

    def len(input)
      input.length
    end

    def map_console(input, property)
      puts(Liquid::StandardFilters::InputIterator.new(input).map { |e| e[property] })
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

    def compare(a, b)
      r = a <=> b

      if r
        r
      elsif a.nil?
        1
      elsif b.nil?
        -1
      else
        raise Liquid::ArgumentError, 'cannot sort values of incompatible types'
      end
    end

    def dup(doc_drop)
      if doc_drop['copy']
        doc_drop
      else
        doc = doc_drop.doc
        dup = Jekyll::Document.new(doc.path, :site => doc.site, :collection => doc.collection)
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

    def render_replacement(r)
      render_markdown(
        render_liquid(
          r.to_s.strip
           .gsub('{{{', '{%')
           .gsub('}}}', '%}')
        )
      )
    end

    private(:compare, :dup, :get_content, :render_replacement)
  end
end

module Jekyll
  module Drops
    class DocumentDrop
      def doc
        @obj
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::SiteFilters)
