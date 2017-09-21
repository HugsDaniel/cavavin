class ChangeGrapeInWines < ActiveRecord::Migration[5.0]
  def change
    change_column :wines, :grape, :string, array: true, default: [], using: "(string_to_array(grape, ','))"
  end
end
