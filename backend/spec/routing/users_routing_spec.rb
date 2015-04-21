require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it 'routes to #sign_in' do
      expect(post: 'users/sign_in').to route_to('users#sign_in')
    end

  end
end
