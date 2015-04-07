require 'pry'
require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Products', :type => :request do

  before(:all) do
    DatabaseCleaner.clean
    @user = FactoryGirl.create(:user, admin: true)
    @products = FactoryGirl.create_list(:product, 10)
    @product = @products.first
  end

  describe 'GET /products' do
    it 'should get all the products' do
      get '/products'
      expect(response).to be_success
      products_json  = JSON.parse(response.body)
      expect(products_json.length).to eq 10
    end
  end

  describe 'GET /products/id' do
    it 'should retrieve a single task by id and return json' do
      get "/products/#{@product.id}"
      expect(response).to be_success
      product_json = JSON.parse(response.body)
      expect(product_json['name']).to eq @product.name
      expect(product_json['description']).to eq @product.description
      expect(product_json['price']).to eq @product.price.to_s
      expect(product_json['image_url']).to eq @product.image_url
    end
  end

  describe 'POST /products' do
    it 'should create a new product when submitted by admin user' do
      @product = FactoryGirl.build(:product)
      post '/admin/products', {
        product: {
          name: @product.name,
          description: @product.description,
          price: @product.price,
          image_url: @product.image_url
        }
      }.to_json,
      {
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s,
        'authorization' => "Token token=#{@user.token}"
      }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      product_json = JSON.parse(response.body)
      expect(product_json['name']).to eq @product.name
      expect(product_json['description']). to eq @product.description
      expect(product_json['price']). to eq @product.price.to_s
      expect(product_json['image_url']). to eq @product.image_url
    end
  end

  describe 'PATCH /products/id' do
    it 'should update a product when submitted by admin user' do
      patch "/admin/products/#{@product.id}",
      {
        product: {
          name: 'new product name'
        }
      }.to_json,
      {
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s,
        'authorization' => "Token token=#{@user.token}"
      }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      product_json = JSON.parse(response.body)
      expect(product_json['name']). to eq 'new product name'
      expect(product_json['description']). to eq @product.description
      expect(product_json['price']). to eq @product.price.to_s
      expect(product_json['image_url']). to eq @product.image_url
    end
  end

  describe 'DELETE /products/id' do
    it 'should destroy a product when submitted by admin user' do
      delete "/admin/products/#{@product.id}",
      nil,
      {
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s,
        'authorization' => "Token token=#{@user.token}"
      }
      expect(response.status).to eq 204
      expect(Product.all.length).to eq 9
    end
  end
end
