class CreateWines < ActiveRecord::Migration[5.0]
  def change
    create_table :wines do |t|
      t.string :appelation
      t.string :domain
      t.integer :year
      t.string :color

      t.timestamps
    end
  end
end
