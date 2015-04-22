require 'pry'
require 'rails_helper'

RSpec.describe CartsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/carts").to route_to("carts#index")
    end

    it "routes to #show" do
      expect(get: "/carts/1").to route_to("carts#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/carts").to route_to("carts#create")
    end

    it "routes to #update" do
      expect(put: "/carts/1").to route_to("carts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/carts/1").to route_to("carts#destroy", id: "1")
    end

  end
end
