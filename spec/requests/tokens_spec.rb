require 'spec_helper'
require 'pp'

describe "Tokens" do

  before do
    User.create(
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
    pp response.body
  end
end