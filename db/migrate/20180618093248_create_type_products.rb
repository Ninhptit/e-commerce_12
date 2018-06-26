class CreateTypeProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :type_products do |t|
      t.string :color
      t.integer :quantity
      t.string :size
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
