require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class LeetsauceController < ApplicationController
  def store
    store_location
  end

  def back
    redirect_back_or_default(:action => 'index')
  end

  def index
  end
end

describe LeetsauceController do
  describe "#store_location" do
    it "should save the current request URI in the session" do
      get :store
      session[:return_to].should == "/leetsauce/store"
    end
  end

  describe "#redirect_back_or_default" do
    it "should redirect to default if nothing stored" do
      get :back
      response.should redirect_to('leetsauce')
    end

    it "should redirect back when url is stored" do
      session[:return_to] = "/leetsauce/store"
      get :back
      response.should redirect_to('leetsauce/store')
    end

    it "should unset session[:return_to]" do
      session[:return_to] = "/leetsauce/store"
      get :back
      session[:return_to].should be_nil
    end
  end

  describe "#current_user_session" do
    before(:each) do
      @user_session = mock('user session')
      UserSession.stub!(:find).and_return(@user_session)
    end

    it "should find the current session" do
      UserSession.should_receive(:find).and_return(@user_session)
      controller.current_user_session.should == @user_session
    end
  end
end
