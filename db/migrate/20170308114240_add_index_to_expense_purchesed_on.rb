class AddIndexToExpensePurchesedOn < ActiveRecord::Migration[5.0]
  def change
    add_index(:expenses, :purchesed_on)
  end
end
