class RangeTag < Liquid::Tag

  class InRangeTag < RangeTag

    def render(context)
      return "in the range " + super(context)
    end

    Liquid::Template.register_tag "in_range", self
  end

  class Unit < RangeTag

    def initialize(tagName, content, tokens)
      super(tagName, "0,1", tokens)
    end

    Liquid::Template.register_tag "range_unit", self
  end

  class InUnit < InRangeTag

    def initialize(tagName, content, tokens)
      super(tagName, "0,1", tokens)
    end

    Liquid::Template.register_tag "in_unit", self
  end

  def initialize(tagName, content, tokens)
    super
    content = content.strip.split(",")
    @min = content[0].strip
    @max = content[1].strip
    @open = "["
    @close = "]"
    if !content[2].nil?
      brackets = content[2]
      if brackets.include?('(')
        @open = '('
      end
      if brackets.include?(')')
        @close= ')'
      end
    end
  end

  def render(context)
    return "<code class=\"language-plaintext highlighter-rouge range\">" + @open + "<span class=\"mi\">" + @min + "</span>, <span class=\"mi\">" + @max + "</span>" + @close + "</code>"
  end

  Liquid::Template.register_tag "range", self
end