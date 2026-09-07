class RangeTag < Liquid::Tag

  class InRangeTag < RangeTag

    def render(context)
      "in the range #{super(context)}"
    end

    Liquid::Template.register_tag 'in_range', self
  end

  class Unit < RangeTag

    def initialize(tag_name, _content, tokens)
      super(tag_name, '0,1', tokens)
    end

    Liquid::Template.register_tag 'range_unit', self
  end

  class InUnit < InRangeTag

    def initialize(tag_name, _content, tokens)
      super(tag_name, '0,1', tokens)
    end

    Liquid::Template.register_tag 'in_unit', self
  end

  def initialize(tag_name, content, tokens)
    super
    content = content.strip.split(',')
    @min = content[0].strip
    @max = content[1].strip
    @open = '['
    @close = ']'
    return if content[2].nil?

    brackets = content[2]
    @open = '(' if brackets.include?('(')
    @close = ')' if brackets.include?(')')
  end

  def render(_context)
    "<code class=\"language-plaintext highlighter-rouge range\">#{@open}<span class=\"mi\">#{@min}</span>, <span class=\"mi\">#{@max}</span>#{@close}</code>"
  end

  Liquid::Template.register_tag 'range', self
end