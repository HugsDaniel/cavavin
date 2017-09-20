class AddLinkToScrapers < ActiveRecord::Migration[5.0]
  def change
    add_column :scrapers, :link, :string
  end
end
