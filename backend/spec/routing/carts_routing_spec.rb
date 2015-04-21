require "rails_helper"

RSpec.describe CartsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/carts").to route_to("carts#index")
    end

    it "routes to #show" do
      expect(get: "/carts/1").to route_to("carts#show", id: "1")
    end

  end
end
