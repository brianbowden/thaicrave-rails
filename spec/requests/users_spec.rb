require 'spec_helper'

# I realize these are horribly-worded

describe "Users" do

  before :each do
    @user = User.new
    @user.first_name = "Brian"
    @user.last_name = "Bowden"
    @user.email = "brian@bowdenworks.net"
    @user.password = "test1234"
    @user.password_confirmation = "test1234"
  end

  it "creating a valid user" do
    post "/api/users", @user.attributes.merge(:password => @user.password_confirmation), :format => :json
    parsed_body = JSON.parse(response.body)

    parsed_body['first_name'].should eq @user.first_name
    parsed_body['last_name'].should eq @user.last_name
    parsed_body['email'].should eq @user.email
  end

  it "creating an invalid user" do
    post "/api/users", @user.attributes.merge(:password => "invalid"), :format => :json
    parsed_body = JSON.parse(response.body)

    parsed_body['message'].should_not eq nil
  end

end