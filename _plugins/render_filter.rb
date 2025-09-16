
module Jekyll
  module RenderFilter
    def render_liquid(input)
      out = Liquid::Template.parse(input)
      out.registers[:site] = @context.registers[:site]
      return out.render()
    end
  end
end

Liquid::Template.register_filter(Jekyll::RenderFilter)