
require 'rouge'

$LOAD_PATH << File.dirname(__FILE__)

require 'kube_lang'

module Rouge
  module Lexers
    class MCCommand < Rouge::RegexLexer
      title "MC Command"
      desc "Dumb as rocks 'language' that changes the color with each space"

      tag "command"
      filenames "*.mc_command"

      def initialize(arg)
        super
        @color_index = 0
        @should_increment_color = true
        @colors = [
          Name::Other,
          Name::Other,
          Keyword::Variable,
          Name::Function,
          Str::Single,
          Keyword,
          Name::Builtin,
          Operator,
          Rouge::Token::Enum,
          Comment::Single
        ]
      end

      def next_color()
        if @should_increment_color
          if @color_index < @colors.count() - 1
            @color_index = @color_index + 1
          else
            @color_index = 2
          end          
        end
      end

      def color()
        @colors[@color_index]
      end

      def whitespace()
        next_color()
        Text
      end

      state :root do

        rule /\s+\u200C/ do
          token whitespace()
          @should_increment_color = false
        end

        rule /\u200C/ do
          token whitespace()
          @should_increment_color = true
        end

        rule /\s+/ do
          token whitespace()
        end

        rule /^(\/\w+)(\s)/ do
          groups color(), whitespace()
        end

        rule /[^\s\u200C]+/ do
          token color()
        end

      end
    end
  end
end