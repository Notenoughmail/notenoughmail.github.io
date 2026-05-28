
class GridTag < Liquid::Tag

  Syntax = /\s*?(n=\d+?)?(?:\s(s=\d+?r?em))?\s*?/o.freeze

  def initialize(tag_name, markup, options)
    super

    if markup =~ Syntax
      n = $1
      s = $2

      @n = n ? extract_val(n) : '2'.freeze
      count = @n.to_i
      raise ArgumentError, "n must be >= 2, was #{count}" if count < 2

      @s = s ?
             extract_val(s) :
             auto_width(count)
    else
      raise SyntaxError, "Grid tag should be formed like '(n=\d+)? (s=\d+r?em)?', was #{markup}"
    end
  end

  def parse(_tokens) end

  def render(_context)
    "<div class=\"grid\" style=\"--n:#{@n};--s:#{@s};\" markdown=\"1\">"
  end

  def extract_val(val)
    val.split('=')[1]
  end

  # Default width of interior objects for column widths
  def auto_width(column_count)
    column_count == 2 ?
      '20rem'.freeze :
      '15rem'.freeze
  end

  Liquid::Template.register_tag 'grid', self
end
