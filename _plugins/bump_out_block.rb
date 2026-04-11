
class BumpOutBlock < Liquid::Block

  def initialize(tag_name, markup, options)
    super
    @type = markup.nil? || markup.empty? ? "p" : markup.strip
  end
  
  def render(context)
    text = super(context)
    "<#{@type} class=\"bump-out\">#{Liquid::Template.parse(text).render(context)}</#{@type}>"
  end

  class BumpOutLine < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      content = text.split("|")
      @type = content.length > 1 ? content[0].strip : "span"
      @text = content[content.length > 1 ? 1 : 0].strip
    end

    def render(context)
      "<#{@type} class=\"bump-out\">#{Liquid::Template.parse(@text).render(context)}</#{@type}>"
    end

    Liquid::Template.register_tag "bump", self
  end

  Liquid::Template.register_tag "bump_out", self
end