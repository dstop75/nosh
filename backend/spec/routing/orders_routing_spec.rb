require 'rails_helper'

RSpec.describe OrdersController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/orders').to route_to('orders#index')
    end

  end
end
