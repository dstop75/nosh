class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name
  # admin

  has_one :cart
  has_many :orders
end
