class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, precision: 8, scale: 2
      t.string :image_url

      t.timestamps null: false
    end
  end
end
