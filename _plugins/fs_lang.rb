# A file system 'language' that specially highlights folder
# divisions (/) and file types while also allowing for <|>
# and * type 'templates'

require 'rouge'

module Rouge
  module Lexers
    class FS < Rouge::RegexLexer
      title "File Directory"
      desc "Specially highlights a file path"

      # These are all bullshit
      tag "fs"
      filenames '*.filedir'
      mimetypes('text/filedir')

      ext = /\.\w{1,10}$/ # Please don't have file extensions longer than 10 chars thx

      state :base do

        rule %r/\//, Keyword::Variable

        rule %r/\</, Name::Decorator, :template

        rule %r/\*/, Str::Double
      end

      state :root do

        rule %r/\/$/, Name::Function

        rule %r/\/#{ext}/, Comment::Single
        
        rule ext, Name::Builtin

        mixin :base

        rule %r/[^\/]+?/, Name::Other
      end

      state :template do

        rule %r/\|/, Name::Decorator

        mixin :base

        rule %r/[^\>]+?/, Str::Double

        rule %r/\>/, Name::Decorator, :pop!
      end

    end
  end
end