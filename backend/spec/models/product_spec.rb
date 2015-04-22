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

    it 'is invalid without a name' do
      expect(Product.create(description: @product.description, price: @product.price)).not_to be_valid
    end

  end
end
