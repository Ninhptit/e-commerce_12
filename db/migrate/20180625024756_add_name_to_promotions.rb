class AddNameToPromotions < ActiveRecord::Migration[5.1]
  def change
    add_column :promotions, :name, :string
  end
end
