# Public: Stops an Action Controller from automatically passing all instance
# variables to the view. Instead, variables must be explicitly defined by
# using proffer.
#
# Examples
#
#   class PostsController < ApplicationController
#     include Proffer
#
#     # This will make a new Post object available as post in the view but
#     # @heading will be nil.
#     def new
#       @heading = "New Post"
#       proffer :post => Post.new
#     end
#   end
module Proffer

  # Public: Make the given values available to the view as local variables.
  #
  # variables - The Hash of values keyed by the local variable name to be used
  #             in the view.
  #
  # Examples
  #
  #   proffer :model => Model.new
  #   # => render ..., :locals => { :model => Model.new }
  #
  # Returns nothing.
  def proffer(variables)
    proffered.merge!(variables)
  end

  # Public: All proffered values and their given keys.
  #
  # Examples
  #
  #   proffered
  #   # => {}
  #
  #   proffer :foo => "bar"
  #   proffered
  #   # => { :foo => "bar" }
  #
  # Returns a Hash of proffered keys and values.
  def proffered
    @_proffered_variables ||= {}
  end

  # Internal: Override Action Controller's render method to convert proffered
  # variables to locals.
  def render(*args, &blk)
    unless proffered.empty?
      options = args.extract_options!
      options[:locals] ||= {}
      options[:locals] = proffered.merge(options[:locals])
      args << options
    end

    super(*args, &blk)
  end

  # Internal: Override Action Controller's view_assigns to no longer copy
  # instance variables into the view.
  def view_assigns
    {}
  end
end

