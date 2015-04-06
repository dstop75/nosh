require 'rails_helper'
require 'database_cleaner'
require 'pry'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Users Requests' do
  before(:all) do
    DatabaseCleaner.clean
  end

  describe '#index' do
    it 'should return a list of users when requested by an admin' do
      @users = FactoryGirl.create_list(:user, 4)
      admin = FactoryGirl.create(:user, admin: true)

      get '/admin/users',
      nil,
      {
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s,
        'authorization' => "Token token=#{admin.token}"
      }
      expect(response).to be_success
      users_json = JSON.parse(response.body)
      expect(users_json.length).to eq 5
    end
  end

  describe '#create' do
    it 'should create a new user' do
      @user = FactoryGirl.build(:user)
      post '/users',
      {
        user: {
          email: @user.email,
          first_name: @user.first_name,
          last_name: @user.last_name,
          password: @user.password
        }
      }.to_json,
      {
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s
      }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      token = JSON.parse(response.body)
      expect(token['token'].length).to be(32)
    end
  end

  describe '#sign_in' do
    it 'should authenticate a user and return their token and id' do
      @user = FactoryGirl.create(:user)
      post '/users/sign_in',
      {
        email: @user.email,
        password: @user.password
      }
      expect(response).to be_success
      credentials = JSON.parse(response.body)
      expect(credentials['token']).to eq @user.token
      expect(credentials['id']).to eq @user.id
    end
  end
end
