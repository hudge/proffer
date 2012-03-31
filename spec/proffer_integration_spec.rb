require 'spec_helper_rails'

class ApplicationController < ActionController::Base
end

describe ApplicationController, :type => :controller do
  render_views

  controller do
    self.view_paths = [File.expand_path('../fixtures', __FILE__)]

    include Proffer

    def index
      @foo = "Not passed through"
      proffer :my_nice_variable => "Woooo"
    end
  end

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
