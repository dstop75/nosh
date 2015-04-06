require 'rails_helper'
require 'database_cleaner'
require 'pry'

DatabaseCleaner.strategy = :truncation

RSpec.describe "Users Requests" do
  before(:all) do
    DatabaseCleaner.clean
    @user = FactoryGirl.build(:user)
  end

  describe "#create" do
    it "should create a new user" do
      post "/users",
      { user:
        { email: @user.email,
          first_name: @user.first_name,
          last_name: @user.last_name,
          password: @user.password
        }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      token = JSON.parse(response.body)
      expect(token['token'].length).to be(32)
    end
  end
end
