class ProductSerializer < ActiveModel::Serializer
  attributes :name, :description, :price
end
