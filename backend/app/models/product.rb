class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_and_belongs_to_many :carts
  has_and_belongs_to_many :orders
end
