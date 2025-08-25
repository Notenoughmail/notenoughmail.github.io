# A 'Kube' language parser, actually Rouge's default JavaScript parser
# as of 2023-02-07, which is several version later than the one used
# by GitHub Pages, and some tweaks for my site (like param color and special keywords)

# Rouge is MIT

require 'rouge'

Rouge::Token.token("Enum", 'enum')

module Rouge
    module Lexers
        class Kube < Rouge::RegexLexer
            title "Kube"
            desc "JavaScript, but decent. Called Kube because that's what its used for here"

            tag 'kube'
            aliases 'kube', 'js', 'javascript' # This overrides Rouge's inbuilt js parser, meaning js can be used for code blocks without losing editor highlighting while having the highlighting of the kube 'language'
            filenames '*.kube', '*.js',
            mimetypes('application/javascript', 'text/javascript')

            state :multiline_comment do
                rule %r([*]/), Comment::Multiline, :pop!
                rule %r([^*/]+), Comment::Multiline
                rule %r([*/]), Comment::Multiline
            end

            state :comments_and_whitespace do
                rule %r/\s+/, Text
                rule %r/<!--/, Comment
                rule %r(//.*?$), Comment::Single
                rule %r(/[*]), Comment::Multiline, :multiline_comment
            end

            state :expr_start do
                mixin :comments_and_whitespace

                rule %r(/) do
                    token Str::Regex
                    goto :regex
                end

                rule %r/[{]/ do
                    token Punctuation
                    goto :object
                end

                mixin :variables

                rule %r//, Text, :pop!
            end

            state :regex do
                rule %r(/) do
                    token Str::Regex
                    goto :regex_end
                end

                rule %r([^/]\n), Error, :pop!

                rule %r/\n/, Error, :pop!
                rule %r/\[\^/, Str::Escape, :regex_group
                rule %r/\[/, Str::Escape, :regex_group
                rule %r/\\./, Str::Escape
                rule %r{[(][?][:=<!]}, Str::Escape
                rule %r/[{][\d,]+[}]/, Str::Escape
                rule %r/[()?]/, Str::Escape
                rule %r/./, Str::Regex
            end

            state :regex_end do
                rule %r/[gimuy]+/, Str::Regex, :pop!
                rule(//) { pop! }
            end

            state :regex_group do
                # specially highlight / in a group to indicate that it doesn't
                # close the regex
                rule %r(/), Str::Escape

                rule %r([^/]\n) do
                    token Error
                    pop! 2
                end

                rule %r/\]/, Str::Escape, :pop!
                rule %r/\\./, Str::Escape
                rule %r/./. Str::Regex
            end

            state :bad_regex do
                rule %r/[^\n]+/, Error, :pop!
            end

            def self.keywords
                @keywords ||= Set.new %w(
                    as async await break case catch continue debugger default default delete
                    do else export finally from for if import in instanceof new of
                    return super switch this throw try typeof void while yield
                    number boolean int float long double integer console
                )
            end

            def self.declarations
                @declarations ||= Set.new %w(
                    var let const with function class declare
                    extends constructor get set static
                )
            end

            def self.reserved
                @reserved ||= Set.new %w(
                    enum implements interface
                    package private protected public
                )
            end

            def self.constants
                @constants ||= Set.new %w(true false null NaN Infinty undefined)
            end

            def self.builtins
                @builtins ||= Set.new %w(
                    Array Boolean Date Error Math netscape
                    Number Object Packages RegExp String sun decodeURI
                    decodeURIComponent encodeURI encodeURIComponent
                    eval isFinite isNaN parseFloat parseInt
                    documentwindow navigator self global
                    Promise Set Map WeakSet WeakMap Symbol Proxy Reflect
                    Int8Array Uint8Array Uint8ClampedArray
                    Int16Array Uint16Array Uint16ClampedArray
                    Int32Array Uint32Array Uint32ClampedArray
                    Float32Array Float64Array DataView ArrayBuffer
                )
            end

            # An important regarding inner classes: The aprt before and after the $ will be treated as different 'words'
            # thus they will not be parsed & colored as a single string, so only the part after the $ should be included
            # the $ will be included with the second string and is safe to include here
            def self.enums
                @enums ||= Set.new %w(
                    Month $Type $Types ForestType ProspectResult
                    Punishment Direction AqueductModelPart SpikeModelPart LampModelType
                    Lifecycle GrassModelPart DeadModelVariant NutrientType GearBoxModelType
                    ClutchModelType PshReaction OffsetType NoteBlockInstrument ItemDisplayContext
                    GlassOperation Size Weight PlanterType ChiselMode ForgeRule DyeColor Heat
                    InteractionResult Type Enum GroundType
                )
            end

            def self.functional_interfaces
                @functional_interfaces ||= Set.new %w(
                    Consumer BiConsumer TriConsumer BiFunction TriFunction QuadFunction
                    RockFunction OnItemUseAction Supplier RocksGetter MossGrowingCallback
                    Predicate Noise2D $StateArgumentPredicate $StatePredicate
                    TemperatureCallback Function
                )
            end

            # TODO: Maybe adjust this to be able to handle Blah$Blah as a single word
            def self.id_regex
                /[\p{L}\p{Nl}$_][\p{Word}]*/io
            end

            id = self.id_regex

            state :root do
                rule %r/\A\s*#!.*?\n/m, Comment::Preproc, :statement
                rule %r((?<=\n)(?=\s|/|<!--)), Text, :expr_start
                mixin :comments_and_whitespace
                rule %r(\+\+ | -- | ~ | \?\?=? | && | \|\| | \\(?=\n) | << | >>>? | ===
                        | !== )x,
                    Operator, :expr_start
                rule %r([-<>+*%&|\^/!=]=?), Operator, :expr_start
                rule %r/[(\[,]/, Punctuation, :expr_start
                rule %r/;/, Punctuation, :statement
                rule %r/[)\].]/, Punctuation

                rule %r/`/ do
                    token Str::Double
                    push :template_string
                end

                # special case for the safe navigator ?.
                # so that we don't start detecting a ternary operator
                rule %r/[?][.]/, Punctuation

                rule %r/[?]/ do
                    token Punctuation
                    push :ternary
                    push :expr_start
                end

                rule %r/(\@)(\w+)?/ do
                    groups Punctuation, Name::Decorator
                    push :expr_start
                end

                rule %r/(class)((?:\s|\\\s)+)/ do
                    groups Keyword::Declaration, Text
                    push :classname
                end

                rule %r/([\p{Nl}$_]*\p{Lu}[\p{Word}]*)[ \t]*(?=(\(.*\)))/m, Name::Class

                rule %r/(function)((?:\s|\\\s)+)(#{id})/ do
                    groups Keyword::Declaration, Text, Name::Function
                end

                rule %r/function(?=(\(.*\)))/, Keyword::Declaration # For anonymous functions

                # See https://github.com/rouge-ruby/rouge/pull/1938
                rule %r/(#{id})[ \t]*(?=(\(.*\)))/m do |m|
                    if self.class.keywords.include?(m[1])
                        token Keyword
                    else
                        token Name::Function
                    end
                end

                rule %r/[{}]/, Punctuation, :statement

                # By this point labels & object declarations have been checked
                rule %r/(#{id})(\s*)(\??:)/ do |m|
                    if m[1].eql?('return') # Special case for descriptions of callback return values
                        groups Keyword, Text, Punctuation
                    else
                        groups Keyword::Variable, Text, Punctuation
                    end
                end

                rule id do |m|
                    if self.class.keywords.include? m[0]
                        token Keyword
                        push :expr_start
                    elsif self.class.declarations.include? m[0]
                        token Keyword::Declaration
                        push :expr_start
                    elsif self.class.reserved.include? m[0]
                        token Keyword::Reserved
                    elsif self.class.constants.include? m[0]
                        token Keyword::Constant
                    elsif self.class.builtins.include? m[0]
                        token Name::Builtin
                    elsif self.class.functional_interfaces.include? m[0]
                        token Name::Function::Magic
                    elsif self.class.enums.include? m[0]
                        token Rouge::Token::Enum
                    else
                        token Name::Other
                    end
                end

                rule %r/[0-9][0-9]*\.[0-9]+([eE][0-9]+)?[fd]?/, Num::Float
                rule %r/0x[0-9a-fA-F]+/i, Num::Hex
                rule %r/0o[0-7][0-7_]*/i, Num::Oct
                rule %r/0b[01][01_]*/i, Num::Bin
                rule %r/[0-9]+/, Num::Integer

                rule %r/"/, Str::Delimiter, :dq
                rule %r/'/, Str::Delimiter, :sq
                rule %r/:/, Punctuation
            end

            state :dq do
                rule %r/\\[\\nrt"]?/, Str::Escape
                rule %r/[^\\"]+/, Str::Double
                rule %r/"/, Str::Delimiter, :pop!
            end

            state :sq do
                rule %r/\\[\\nrt']?/, Str::Escape
                rule %r/[^\\']+/, Str::Single
                rule %r/'/, Str::Delimiter, :pop!
            end

            state :classname do
                rule %r/(#{id})((?:\s|\\\s)+)(extends)((?:\s|\\\s)+)/ do
                    groups Name::Class, Text, Keyword::Declaration, Text
                end

                rule id, Name::Class, :pop!
            end

            state :statement do
                rule %r/case\b/ do
                    token Keyword
                    goto :expr_start
                end

                rule %r/(#{id})(\s*)(:)$/ do
                    groups Name::Label, Text, Punctuation
                end

                mixin :expr_start
            end

            # object literals
            state :object do
                mixin :comments_and_whitespace

                rule %r/[{]/ do
                    token Punctuation
                    push
                end

                rule %r/[}]/ do
                    token Punctuation
                    goto :statement
                end

                rule %r/(#{id})(\s*)(:)/ do
                    groups Name::Attribute, Text, Punctuation
                    push :expr_start
                end

                rule %r/:/, Punctuation
                mixin :root
            end

            # ternary expressions, where <id>: is not a label!
            state :ternary do
                rule %r/:/ do
                    token Punctuation
                    goto :expr_start
                end

                mixin :root
            end

            # template strings
            state :template_string do
                rule %r/[$]{/, Punctuation, :template_string_expr
                rule %r/`/, Str::Double, :pop!
                rule %r/\\[$`\\]/, Str::Escape
                rule %r/[^$`\\]+/, Str::Double
                rule %r/[\\$]/, Str::Double
            end

            state :template_string_expr do
                rule %r/}/, Punctuation, :pop!
                mixin :root
            end

            state :variables do
                rule %r/(#{id})(\s*)(\??:)/ do |m|
                    # Realistically, variable declarations should not happen within an object declaration
                    # Unless the declaration is for a map...
                    # TODO: Currently this deals with the one situation of variables in an object declaration, but pushing & shpoping a varibles state would generalize much better
                    if m[3].eql?(":") && in_state?(:object)
                        groups Name::Attribute, Text, Punctuation
                        goto :expr_start 
                    else
                        groups Keyword::Variable, Text, Punctuation
                    end
                end
            end
        end
    end
end
