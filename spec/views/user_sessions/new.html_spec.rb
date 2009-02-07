require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/user_sessions/new" do
  before(:each) do
    assigns[:user_session] = mock('user session', {
      :login => nil, :password => nil
    })
    render 'user_sessions/new'
  end

  it "should have a login form" do
    response.should have_tag('form[action=?]', user_session_url) do
      with_tag('input[name=?]', 'user_session[login]')
      with_tag('input[name=?][type=password]', 'user_session[password]')
    end
  end
end
