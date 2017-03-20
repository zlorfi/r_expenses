class AddCategoryRefToExpense < ActiveRecord::Migration[5.0]
  def up
    add_reference :expenses, :category, foreign_key: true

    say_with_time 'Running rake task to migrate data.' do
      Rake::Task['migrate:default'].invoke
    end
  end

  def down
    remove_reference :expenses, :category, foreign_key: true
  end
end
