require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/topics/show.html.erb" do
  include TopicsHelper
  
  before(:each) do
    assigns[:topic] = @topic = stub_model(Topic)
  end

  it "should render attributes in <p>" do
    render "/topics/show.html.erb"
  end
end

