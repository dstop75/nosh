require 'pry'
require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do

    it 'routes to #sign_in' do
      expect(post: 'users/sign_in').to route_to('users#sign_in')
    end

    it 'routes to #sign_out' do
      expect(get: 'users/sign_out').to route_to('users#sign_out')
    end

    it 'routes to #index' do
      expect(get: 'admin/users').to route_to('admin/users#index')
    end

    it 'routes to #show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users').to route_to('users#create')
    end

    it 'routes to #update' do
      expect(put: '/users/1').to route_to('users#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/1').to route_to('users#destroy', id: '1')
    end

  end
end
