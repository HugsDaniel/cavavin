class ChangeRegionInWines < ActiveRecord::Migration[5.0]
  def change
    change_column :wines, :region, :string, array: true, default: [], using: "(string_to_array(region, ','))"
  end
end
