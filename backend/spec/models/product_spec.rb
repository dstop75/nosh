require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:all) do
    DatabaseCleaner.clean
    @product = FactoryGirl.build(:product)
  end

  describe '.create' do
    it 'creates a new product' do
      expect(Product.create()).to be_a Product
    end

  end
end
