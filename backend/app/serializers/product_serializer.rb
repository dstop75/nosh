class ProductSerializer < ActiveModel::Serializer
  attributes :name, :description, :price, :image_url
end
