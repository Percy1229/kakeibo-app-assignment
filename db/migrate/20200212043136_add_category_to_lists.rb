class AddCategoryToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :category, :string
  end
end
