require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe "Products", :type => :request do

  before(:all) do
    DatabaseCleaner.clean
    @products = FactoryGirl.create_list(:product, 10)
  end
  describe "GET /products" do
    it "gets all the products" do
      get "/products"
      expect(response).to be_success
      products_json  = JSON.parse(response.body)
      expect(products_json.length).to eq 10
    end
  end
end
