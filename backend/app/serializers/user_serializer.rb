class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :cart_id, :order_id

  has_one :cart
  has_many :orders
end
