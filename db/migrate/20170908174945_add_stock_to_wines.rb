class AddStockToWines < ActiveRecord::Migration[5.0]
  def change
    add_column :wines, :stock, :integer
  end
end
