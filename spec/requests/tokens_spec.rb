require 'spec_helper'
require 'pp'

describe "Token Authentication" do

  before do
    @user = User.create(
      first_name: "Brian",
      last_name: "Bowden",
      email: "brian@bowdenworks.net",
      password: "test1234",
      password_confirmation: "test1234")
  end

  it "gets a token" do
    post "/api/tokens.json", {:email => "brian@bowdenworks.net", :password => "test1234"}, :format => :json
    body = JSON.parse(response.body)
    body.should include('token')
    body['token'].should_not be_empty
  end

  it "destroys a token" do
    delete "/api/tokens/" + put auth token here, nil, :format => :json
    body = JSON.parse(response.body)
    body.should include('token')
    body['token'].should be_empty
  end
end