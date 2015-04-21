require 'rails_helper'
require 'database_cleaner'
require 'pry'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Users Requests' do
  before(:all) do
    DatabaseCleaner.clean
    @num = 4
    @users = FactoryGirl.create_list(:user, @num)
    @user = @users.first
    @admin = FactoryGirl.create(:user, admin: true)
  end

  describe '#index' do
    it 'should return a list of users when requested by an admin' do
      get '/admin/users',
      nil,
      {
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s,
        'authorization': "Token token=#{@admin.token}"
      }
      expect(response).to be_success
      users_json = JSON.parse(response.body)
      # @users + @admin
      expect(users_json.length).to eq @num + 1
    end

    it 'should fail when requested by a non-admin' do
      get '/admin/users',
      nil,
      {
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s,
        'authorization': "Token token=#{@user.token}"
      }
      expect(response).not_to be_success
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
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s
      }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      token = JSON.parse(response.body)
      expect(token['token'].length).to be(32)
      # @users + @admin + @user
      expect(User.all.length).to eq @num + 2
    end
  end

  describe '#sign_in' do
    it 'should authenticate a user and return their token, id, and admin status' do
      post '/users/sign_in',
      {
        email: @user.email,
        password: @user.password
      }
      expect(response).to be_success
      credentials = JSON.parse(response.body)
      expect(credentials['token']).to eq @user.token
      expect(credentials['id']).to eq @user.id
      expect(credentials['admin']).to eq @user.admin
      expect(credentials['admin']).to eq false
    end

    it 'should authenticate an admin user and return their token, id, and admin status' do
      post '/users/sign_in',
      {
        email: @admin.email,
        password: @admin.password
      }
      expect(response).to be_success
      credentials = JSON.parse(response.body)
      expect(credentials['token']).to eq @admin.token
      expect(credentials['id']).to eq @admin.id
      expect(credentials['admin']).to eq @admin.admin
      expect(credentials['admin']).to eq true
    end
  end
end
