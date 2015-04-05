class CartSerializer < ActiveModel::Serializer
  attributes :id, :created_at

  has_and_belongs_to_many :products

  def created_at
    object.created_at.strftime('%m-%d-%Y')
  end
end
