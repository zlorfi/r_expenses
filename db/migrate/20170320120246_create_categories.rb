class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :short_name_de
      t.string :long_name_de
      t.string :short_name_en
      t.string :long_name_en

      t.timestamps
    end
  end
end
