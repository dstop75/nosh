require 'pry'
require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe User, type: :model do
  before(:all) do
    DatabaseCleaner.clean
    @admin = FactoryGirl.build(:user, admin: true)
    @user = FactoryGirl.build(:user)
  end

  describe '.create' do
    it 'creates a new user' do
      expect(User.create()).to be_a User
    end

    it 'is invalid without an email' do
      expect(User.create(first_name: @user.first_name, last_name: @user.last_name, password: @user.password)).not_to be_valid
    end

    it 'is invalid without a unique email' do
      @taken = FactoryGirl.create(:user)
      expect(User.create(email: @taken.email, first_name: @user.first_name, last_name: @user.last_name, password: @user.password)).not_to be_valid
    end

    it 'is invalid without a first name' do
      expect(User.create(email: @user.email, last_name: @user.last_name, password: @user.password)).not_to be_valid
    end

    it 'is invalid without a last name' do
      expect(User.create(email: @user.email, first_name: @user.first_name, password: @user.password)).not_to be_valid
    end

    it 'is invalid without a password' do
      expect(User.create(email: @user.email, first_name: @user.first_name, last_name: @user.last_name)).not_to be_valid
    end

    it 'is valid with all required attributes' do
      expect(User.create(email: @user.email, first_name: @user.first_name, last_name: @user.last_name, password: @user.password)).to be_valid
    end

  end
end
