# frozen_string_literal: true

class StackOverflowBlock < Liquid::Block

  # https://gist.github.com/jbgo/4493822
  def render(context)
    enable_tracing = false
    trace_out = open('trace.txt', 'w')

    set_trace_func proc { |event, file, line, id, _binding, classname|
      if enable_tracing && event == 'call'
        trace_out.puts "#{file}:#{line} #{classname}##{id}"
      end
    }

    enable_tracing = true
    begin
      super
    rescue SystemStackError => e
      puts "Overflow occurs in captured area"
      raise e
    ensure
      enable_tracing = false
    end
  end

  Liquid::Template.register_tag "_stack_overflow", self
end
