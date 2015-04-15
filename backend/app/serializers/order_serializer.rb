class OrderSerializer < ActiveModel::Serializer
  attributes :id, :cart_id, :created_at

  has_one :cart
  # has_and_belongs_to_many :products

  def created_at
    object.created_at.strftime('%m-%d-%Y')
  end
end
