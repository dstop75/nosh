require 'pry'
require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Products', type: :request do

  before(:all) do
    DatabaseCleaner.clean
    @num = 10
    @admin_user = FactoryGirl.create(:user, admin: true)
    @non_admin_user = FactoryGirl.create(:user)
    @products = FactoryGirl.create_list(:product, @num)
    @product = @products.first
  end

  describe 'GET /products' do
    it 'should get all the products' do
      get '/products'
      expect(response).to be_success
      products_json  = JSON.parse(response.body)
      expect(products_json.length).to eq @num
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

    before(:all) do
      @product = FactoryGirl.build(:product)
    end

    it 'should create a new product when submitted by admin user' do
      post '/admin/products', {
        product: {
          name: @product.name,
          description: @product.description,
          price: @product.price,
          image_url: @product.image_url
        }
      }.to_json,
      {
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s,
        'authorization': "Token token=#{@admin_user.token}"
      }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      product_json = JSON.parse(response.body)
      expect(product_json['name']).to eq @product.name
      expect(product_json['description']). to eq @product.description
      expect(product_json['price']). to eq @product.price.to_s
      expect(product_json['image_url']). to eq @product.image_url
      expect(Product.all.length).to eq @num + 1
    end

    it 'should reject the submission when submitted by a non-admin user' do
      post '/admin/products', {
        product: {
          name: @product.name,
          description: @product.description,
          price: @product.price,
          image_url: @product.image_url
        }
      }.to_json,
      {
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s,
        'authorization': "Token token=#{@non_admin_user.token}"
      }
      expect(response).not_to be_success
      expect(Product.all.length).to eq @num
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
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s,
        'authorization': "Token token=#{@admin_user.token}"
      }
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON
      product_json = JSON.parse(response.body)
      expect(product_json['name']). to eq 'new product name'
      expect(product_json['description']). to eq @product.description
      expect(product_json['price']). to eq @product.price.to_s
      expect(product_json['image_url']). to eq @product.image_url
    end

    it 'should reject the update when submitted by a non-admin user' do
      patch "/admin/products/#{@product.id}",
      {
        product: {
          name: 'new product name'
        }
      }.to_json,
      {
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s,
        'authorization': "Token token=#{@non_admin_user.token}"
      }
      expect(response).not_to be_success
    end
  end

  describe 'DELETE /products/id' do
    it 'should destroy a product when submitted by admin user' do
      delete "/admin/products/#{@product.id}",
      nil,
      {
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s,
        'authorization': "Token token=#{@admin_user.token}"
      }
      expect(response.status).to eq 204
      expect(Product.all.length).to eq @num - 1
    end

    it 'should reject the deletion when submitted by a non-admin user' do
      delete "/admin/products/#{@product.id}",
      nil,
      {
        'Accept': Mime::JSON,
        'Content-Type': Mime::JSON.to_s,
        'authorization': "Token token=#{@non_admin_user.token}"
      }
      expect(response).not_to be_success
      expect(Product.all.length).to eq @num
    end
  end
end
