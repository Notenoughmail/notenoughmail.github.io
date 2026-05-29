
class MapBlock < Liquid::Capture

  def initialize(tag_name, markup, options)
    super
    @values = {}
    @print = false
  end

  def render_to_output_buffer(context, _output)
    render(context)
  end

  # Using old Jekyll/Liquid...
  def render(context)
    context.scopes.last[@to] = assemble_values(context)
    ''.freeze
  end

  def assemble_values(context)
    out = {}
    @values.each do |name, value|
      rendered = _assemble(value, context)
      puts "Rendered '#{name}': #{rendered}" if @print
      out[name] = rendered
    end
    out
  end

  def _assemble(value, context)
    if value.is_a?(String)
      value
    else
      value.render(context)
    end
  end

  def unknown_tag(tag_name, params, tokens)
    if tag_name.eql? 'print'
      @print = true
      return ''.freeze
    end
    stripped = params.strip
    @values[tag_name] = _pre_parse(stripped, tag_name, tokens)
    ''.freeze
  end

  def _pre_parse(stripped, tag_name, tokens)
    if stripped.empty?
      body = unknown_block(tag_name, tokens)
      puts "raw '#{tag_name}': #{body.nodelist}" if @print
      body
    else
      puts "raw '#{tag_name}': #{stripped}" if @print
      stripped
    end
  end

  def unknown_block(block_name, tokens)
    block_body = Liquid::BlockBody.new
    while parse_unknown_block(block_body, tokens, block_name)
    end
    block_body
  end

  def parse_unknown_block(block_body, tokens, block_name)
    end_tag = "end_#{block_name}" # Include _ to save sanity with spell check
    block_body.parse(tokens, @parse_context) do |end_tag_name, end_tag_params|
      return false if end_tag_name == end_tag
      unless end_tag_name
        raise SyntaxError.new(@parse_context[:locale].t("errors.syntax.tag_never_closed".freeze, block_name: block_name))
      end
      unknown_tag(end_tag_name, end_tag_params, tokens)
    end
  end

  Liquid::Template.register_tag 'map', self
end
