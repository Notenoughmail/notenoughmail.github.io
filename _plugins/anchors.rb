
module Jekyll
  class Anchors
    
    class << self

      def callout_regexs
        @callout_regexs ||= make_callout_regexs
      end

      def language_identifiers
        @language_identifiers ||= "(?:(?:js|javascript|kube)(?:-(?:18|20|21))?)"
      end

      def code_regexs
        @code_regexs ||= [
          /\<code\sclass="language-#{language_identifiers}\shighlighter-rouge"\sid="(.+?)"\>.+?\<\/code\>/,
          /(\<code\sclass="language-#{language_identifiers}\shighlighter-rouge"\sid=".+?"\>.+?\<\/code\>)/
        ]
      end

      # Multiline for the rare occasion that a full code block is inside a callout
      def make_callout_regexs
        c = Jekyll.sites[0].config['callouts'].keys.map{ |k| k.to_s }.join("|")
        return [
          /\<(p|blockquote)\sclass="(?:#{c})"\sid="(.+?)"\>.*?\<\/\1\>/m.freeze,
          /(\<(p|blockquote)\sclass="(?:#{c})"\sid=".+?"\>.*?\<\/\2\>)/m.freeze
        ]
      end

      def make_anchor(text, id, clazz)
        anchor = Liquid::Template.parse("{% include anchor.html id='#{id}' clazz='#{clazz}' text='#{text}' %}")
        anchor.registers[:site] = Jekyll.sites[0]
        return anchor.render()
      end

      def code(str)
        if str.match?(code_regexs[0])
          str.match(code_regexs[0]) { |m|
            begin
              return make_anchor(str, m[1], 'm-link')
            rescue => e
              puts "Did you include single quotes in a inline code block?"
              raise e
            end
          }
        end
        return str
      end

      def callout(str)
        if str.eql?("p") || str.eql?("blockquote")
          return "" # Due to the second capture group for matching the closing tag, p and blockquote strings are part of the split array
        end
        if str.match?(callout_regexs[0])
          str.match(callout_regexs[0]) { |m|
            begin
              return make_anchor(str, m[2], 'callout')
            rescue => e
              puts "Did you include single quotes in a callout?"
              raise e
            end
          }
        end
        return str
      end

      def wrap_identified_callouts_and_code_blocks(page)
        content = page.output
        if content.match?(code_regexs[1])
          content = content.gsub(code_regexs[1]) { |str| code(str) }
        end

        if content.match?(callout_regexs[1])
          content = content.gsub(callout_regexs[1]) { |str| callout(str) }
        end

        page.output = content
      end
    end
  end
end

# If for some reason posts need to be processed, add :documents to the array also note that their class is Jekyll::Document, not Jekyll::Page
Jekyll::Hooks.register [:pages], :post_render do |page|
  Jekyll::Anchors.wrap_identified_callouts_and_code_blocks(page) if page.path.to_s.end_with?(".md")
end
