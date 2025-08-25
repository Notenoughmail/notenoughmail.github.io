class ColorTag < Liquid::Tag

  def initialize(tagName, content, tokens)
    super
    content = content.strip.split("|")
    @color = content[0].downcase
    @text = content[1].nil? ? "##{content[0].upcase}" : content[1]
  end

  def render(context)
    return "<span style=\"color:##{@color};\">#{@text}</span>"
  end

  Liquid::Template.register_tag "color", self
end