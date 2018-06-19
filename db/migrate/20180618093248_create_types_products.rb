class CreateTypesProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :types_products do |t|
      t.string :color
      t.integer :quatity
      t.string :size
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
