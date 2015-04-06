class CreateJoinTableOrderProduct < ActiveRecord::Migration
  def change
    create_join_table :orders, :products do |t|
      t.index [:order_id, :product_id]
      t.index [:product_id, :order_id]
    end
  end
end
