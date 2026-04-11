
class MapBlock < Liquid::Capture

  def initialize(tagName, markup, options)
    super
    @values = {}
  end

  def render_to_output_buffer(context, output)
    render(context)
  end

  # Using old Jekyll/Liquid...
  def render(context)
    context.scopes.last[@to] = @values
    ""
  end

  def unknown_tag(tag_name, params, tokens)
    stripped = params.strip
    if stripped.empty?
      super
    else
      @values[tag_name] = params.strip
    end
  end

  Liquid::Template.register_tag "map", self
end
