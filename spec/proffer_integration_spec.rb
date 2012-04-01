require 'spec_helper_rails'

class ApplicationController < ActionController::Base
  include Proffer
end

class ProfferTestController < ApplicationController
  self.view_paths = [File.expand_path('../fixtures', __FILE__)]

  def index
    @foo = "Not passed through"
    proffer :my_nice_variable => "Woooo"
  end

  def inline
    proffer :foo => "bar"
    render :inline => "My name is <%= foo %>"
  end
end

TestApplication.routes.draw do
  match "/foo" => "proffer_test#index"
  match "/inline" => "proffer_test#inline"
end

describe ProfferTestController, :type => :controller do
  render_views

  describe "#proffer" do
    it "is not an available action" do
      controller.available_action?("proffer").should be_false
    end
  end

  describe "#proffered" do
    it "is not an available action" do
      controller.available_action?("proffered").should be_false
    end
  end

  describe "#index" do
    describe "as html" do
      it "won't pass instance variables to the view by default" do
        get :index
        response.body.should_not =~ /Not passed through/
      end

      it "doesn't set assigns" do
        get :index
        assigns(:foo).should be_nil
      end

      it "will pass proffered variables to the view" do
        get :index
        response.body.should =~ /Woooo/
      end
    end

    describe "as xml" do
      it "won't pass instance variables to the view by default" do
        get :index, :format => :xml
        response.body.should_not =~ /Not passed through/
      end

      it "will pass proffered variables to the view" do
        get :index, :format => :xml
        response.body.should =~ /Woooo/
      end
    end
  end

  describe "#inline" do
    it "works with inline rendering" do
      get :inline
      response.body.should =~ /My name is bar/
    end
  end
end

