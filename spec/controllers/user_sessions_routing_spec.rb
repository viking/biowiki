require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  describe "route generation" do
    it "should map #new" do
      route_for(:controller => "user_sessions", :action => "new").should == "/user_session/new"
    end
  end

  describe "route recognition" do
    it "should generate params for #new" do
      params_from(:get, "/user_session/new").should == {:controller => "user_sessions", :action => "new"}
    end
  end
end
