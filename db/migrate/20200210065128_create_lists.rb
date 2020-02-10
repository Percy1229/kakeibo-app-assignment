class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.integer :expense
      t.string :place
      t.string :item_name
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
