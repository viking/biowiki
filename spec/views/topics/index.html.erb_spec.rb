require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/topics/index.html.erb" do
  include TopicsHelper
  
  before(:each) do
    assigns[:topics] = [
      stub_model(Topic),
      stub_model(Topic)
    ]
  end

  it "should render list of topics" do
    render "/topics/index.html.erb"
  end
end

