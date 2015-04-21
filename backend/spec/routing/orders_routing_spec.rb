require 'rails_helper'

RSpec.describe OrdersController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/orders').to route_to('orders#index')
    end

    it 'routes to #show' do
      expect(get: '/orders/1').to route_to('orders#show', id: '1')
    end

  end
end
