class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.integer :income
      t.string :source
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
