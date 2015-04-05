class Order < ActiveRecord::Base
  belongs_to :user
  has_one :cart
  has_and_belongs_to_many :products
end
