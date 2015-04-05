class Product < ActiveRecord::Base
  has_and_belongs_to_many :carts
  has_and_belongs_to_many :orders
end
