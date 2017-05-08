class RenamePurchesedOnToPurchasedOn < ActiveRecord::Migration[5.1]
  def change
    rename_column :expenses, :purchesed_on, :purchased_on
  end
end
