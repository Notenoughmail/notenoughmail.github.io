
require 'liquid'

module Jekyll
  module SiteFilters

    def render_liquid(input)
      out = Liquid::Template.parse(input)
      out.registers[:site] = @context.registers[:site]
      return out.render()
    end

    def multi_where(input, property, target_values)
      ary = Liquid::StandardFilters::InputIterator.new(input)
      for target_value in target_values do
        ary = ary.select { |item| item[property].include?(target_value) }
      end
      ary
    end

    def multi_sort(input, properties)
      ary = Liquid::StandardFilters::InputIterator.new(input)

      return [] if ary.empty?

      if ary.all? { |e| e.respond_to?(:[]) }
        begin
          ary.sort { |a, b|
            r = 0
            i = 0
            # I couldn't get the regular while loop to work for some reason
            loop do
              r = compare(a[properties[i]], b[properties[i]])
              i = i + 1
              if r != 0 || i >= properties.length
                break
              end
            end
            r
          }
        rescue => e
          puts "Error sorting %s:" % input
          puts e
          raise e
        end
      else
        raise "Cannot sort input %s, must be able to handle :[]" % [input]
      end
    end

    def clean_fragments(input)
      Liquid::StandardFilters::InputIterator.new(input).each { |f|
        content = f['output']
        anchor = f['anchor']

        f['clean'] = content.gsub(/\<h(?:[2-6]).+?\<\/h(?:[2-6])\>/) { |str|
          # Hoist headings down a level, purely so the markdown linter stops complaining
          str.match(/\<h([2-6])(.+?)\<\/h(?:[2-6])\>/) { |m|
            size = (m[1].to_i + 1).to_s
            '<h' + size + m[2] + '</h' + size + '>'
          }
        }.gsub(/(?:id|href)="#?(?:fn|fnref):/) { |str|
          # Make footnotes unique per-fragment
          str.match(/(id|href)="(#?)(fn|fnref):/) { |m|
            m[1] + '="' + + m[2] + anchor + "-" + m[3] + ':'
          }
        }
      }
      input
    end

    def get_or_default(input, get, default)
      g = input[get]
      if !g.nil?
        g
      else
        input[default]
      end
    end

    def to_console(input)
      puts input
      input
    end

    def map_console(input, property)
      puts Liquid::StandardFilters::InputIterator.new(input).map { |e| e[property] }
      input
    end

    private def compare(a, b)
      r = a <=> b

      if r
        r
      elsif a.nil?
        1
      elsif b.nil?
        -1
      else
        raise Liquid::ArgumentError, "cannpt sort values of incompatable types"
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::SiteFilters)