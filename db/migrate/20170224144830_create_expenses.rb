class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.string :category
      t.decimal :amount, precision: 16, scale: 2
      t.date :purchesed_on
      t.boolean :intake, default: false
      t.references :user
      t.timestamps
    end
  end
end
