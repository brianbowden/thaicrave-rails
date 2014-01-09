require 'spec_helper'
require 'pp'

describe "Token Authentication" do

  before :each do
    @user = User.create(
      first_name: "Brian",
      last_name: "Bowden",
      email: "brian@bowdenworks.net",
      password: "test1234",
      password_confirmation: "test1234")
  end

  it "gets a token" do
    post "/api/tokens.json", {:email => @user.email.to_s, :password => @user.password.to_s}, :format => :json
    body = JSON.parse(response.body)
    body.should include('token')
    body['token'].should_not be_empty
  end

  it "destroys a token" do
    @user.ensure_authentication_token
    @user.save
    
    delete "/api/tokens/" + @user.authentication_token.to_s, nil, :format => :json
    body = JSON.parse(response.body)
    body.should include('token')
    
    @user.reload
    @user.authentication_token.to_s.should_not eq body['token'].to_s
  end
end