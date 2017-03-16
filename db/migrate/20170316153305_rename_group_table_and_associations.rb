class RenameGroupTableAndAssociations < ActiveRecord::Migration[5.0]
  def change
    rename_table :groups, :organizations
    rename_column :users, :group_id, :organization_id
  end
end
