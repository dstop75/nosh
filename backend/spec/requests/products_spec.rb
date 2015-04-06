require 'pry'
require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe "Products", :type => :request do

  before(:all) do
    DatabaseCleaner.clean
    @products = FactoryGirl.create_list(:product, 10)
    @product = @products.first
  end

  describe "GET /products" do
    it "gets all the products" do
      get "/products"
      expect(response).to be_success
      products_json  = JSON.parse(response.body)
      expect(products_json.length).to eq 10
    end
  end

  describe 'GET /products/id' do
    it "should retrieve a single task by id and return json" do
      get "/products/#{@product.id}"
      expect(response).to be_success
      product_json = JSON.parse(response.body)
      expect(product_json['name']).to eq @product.name
      expect(product_json['description']).to eq @product.description
      expect(product_json['price']).to eq @product.price.to_s
      expect(product_json['image_url']).to eq @product.image_url
    end
  end
end
