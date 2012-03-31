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
end

TestApplication.routes.draw do
  match "/foo" => "proffer_test#index"
end

describe ProfferTestController, :type => :controller do
  render_views

  describe "#index" do
    describe "as html" do
      it "won't pass instance variables to the view by default" do
        get :index
        response.body.should_not =~ /Not passed through/
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
end
