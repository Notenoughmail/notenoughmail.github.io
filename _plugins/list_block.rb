
class ListBlock < Liquid::Capture

  def initialize(tag_name, markup, options)
    super
    @values = []
  end

  def render_to_output_buffer(context, _output)
    render(context)
  end

  # Using old Jekyll/Liquid...
  def render(context)
    context.scopes.last[@to] = @values
    ''.freeze
  end

  def unknown_tag(tag_name, _params, _tokens) @values.push(tag_name.strip)
  end

  Liquid::Template.register_tag 'list', self
end
