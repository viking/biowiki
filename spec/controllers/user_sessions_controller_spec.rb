require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do

  describe "GET 'new'" do
    before(:each) do
      @user_session = mock('user session')
      UserSession.stub!(:new).and_return(@user_session)
    end

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should expose a new user session" do
      UserSession.should_receive(:new).and_return(@user_session)
      get 'new'
      assigns[:user_session].should == @user_session
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @user_session = mock('user session', :save => true)
      UserSession.stub!(:new).and_return(@user_session)
    end

    def do_post
      post :create, :user_session => { :login => "huge", :password => "leetsauce" }
    end

    it "should make a new user session" do
      UserSession.should_receive(:new).with('login' => 'huge', 'password' => 'leetsauce').and_return(@user_session)
      do_post
      assigns[:user_session].should == @user_session
    end

    describe "with valid params" do
      before(:each) do
        @user_session.stub!(:save).and_return(true)
      end

      it "should redirect back or default" do
        controller.should_receive(:redirect_back_or_default) do |arg|
          arg.should == root_url
        end
        do_post
        flash[:notice].should == "Login successful!"
      end
    end

    describe "with invalid params" do
      before(:each) do
        @user_session.stub!(:save).and_return(false)
      end

      it "should render new" do
        do_post
        response.should render_template('new')
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @user_session = mock('user session', :destroy => nil)
      UserSession.stub!(:find).and_return(@user_session)
    end

    it "should destroy the current session" do
      @user_session.should_receive(:destroy)
      delete :destroy
    end

    it "should redirect back" do
      controller.should_receive(:redirect_back_or_default) do |arg|
        arg.should == root_url
      end
      delete :destroy
      flash[:notice].should == "Logout successful!"
    end

    it "should not fail if there is no session" do
      UserSession.stub!(:find).and_return(nil)
      delete :destroy
    end
  end
end
