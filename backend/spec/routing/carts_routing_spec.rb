require "rails_helper"

RSpec.describe CartsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/carts").to route_to("carts#index")
    end

  end
end
