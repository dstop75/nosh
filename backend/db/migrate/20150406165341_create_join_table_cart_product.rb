class CreateJoinTableCartProduct < ActiveRecord::Migration
  def change
    create_join_table :carts, :products do |t|
      t.index [:cart_id, :product_id]
      t.index [:product_id, :cart_id]
    end
  end
end
