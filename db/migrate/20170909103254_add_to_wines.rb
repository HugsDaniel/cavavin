class AddToWines < ActiveRecord::Migration[5.0]
  def change
    add_column :wines, :wine, :string
    add_column :wines, :region, :string
    add_column :wines, :grape, :string
    add_column :wines, :figaro_note, :string
    add_column :wines, :food, :string, array: true, default: []
  end
end
