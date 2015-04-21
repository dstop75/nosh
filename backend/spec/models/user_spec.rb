require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.create' do
    it 'creates a new user' do
      expect(User.create()).to be_a User
    end
  end
end
