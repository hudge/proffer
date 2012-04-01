require 'spec_helper'

class FakeController < BaseController
  include Proffer

  def index
    proffer :foo => "bar", :baz => "quux"
    render :index
  end

  def no_proffering
    render :no_proffering
  end

  def proffering_with_locals(locals)
    proffer :foo => "bar"
    render :proffering, :locals => locals
  end

  def multiple_proffer
    proffer :foo => "bar"
    proffer :baz => "quux"
    render :multiple_proffer
  end

  def render_with_no_args
    proffer :foo => "bar"
    render
  end
end

describe Proffer do
  let(:controller) { FakeController.new }

  it "sets view_assigns to an empty hash" do
    controller.view_assigns.should == {}
  end

  describe "#proffer" do
    it "assigns the proffered variables to the view as locals" do
      controller.index
      controller.args_for_render.should == [:index, { :locals => { :foo => "bar", :baz => "quux" } }]
    end

    it "doesn't add a locals option to the view if nothing is proffered" do
      controller.no_proffering
      controller.args_for_render.should == [:no_proffering]
    end

    it "doesn't override explicitly provided locals" do
      controller.proffering_with_locals(:baz => "quux")
      controller.args_for_render.should == [:proffering, { :locals => { :baz => "quux", :foo => "bar" } }]
    end

    it "prefers the explicit locals over the proffered variables if they have the same name" do
      controller.proffering_with_locals(:foo => "new value")
      controller.args_for_render.should == [:proffering, { :locals => { :foo => "new value" } }]
    end

    it "allows multiple calls to proffer" do
      controller.multiple_proffer
      controller.args_for_render.should == [:multiple_proffer, { :locals => { :foo => "bar", :baz => "quux" } }]
    end

    it "supports implicit rendering with no arguments" do
      controller.render_with_no_args
      controller.args_for_render.should == [{ :locals => { :foo => "bar" } }]
    end
  end
end

