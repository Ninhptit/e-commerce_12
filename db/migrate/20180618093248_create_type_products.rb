class CreateTypeProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :type_products do |t|
      t.references :product, foreign_key: true
      t.string :color
      t.integer :quantity
      t.string :size

    end
  end
end
