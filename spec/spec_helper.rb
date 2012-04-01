require 'proffer'

# To avoid requiring Active Support during testing.
class Array
  def extract_options!
    if last.is_a?(Hash)
      pop
    else
      {}
    end
  end
end

class BaseController
  attr_reader :args_for_render

  def self.hide_action(*)
  end

  def render(*args)
    @args_for_render = args
  end

  def view_assigns
    {:stuff => :not_needed}
  end
end

