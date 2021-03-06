require 'pry'
require 'rails_helper'

RSpec.describe ProductsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/products').to route_to('products#index')
    end

    it 'routes to #show' do
      expect(get: '/products/1').to route_to('products#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: 'admin/products').to route_to('admin/products#create')
    end

    it 'routes to #update' do
      expect(put: 'admin/products/1').to route_to('admin/products#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/products/1').to route_to('admin/products#destroy', id: '1')
    end

  end
end
