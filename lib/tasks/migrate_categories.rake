namespace :migrate do
  desc 'Migrate categories from a constant to a model'
  task :create_categories do
    Category.delete_all
    Category.create(short_name_de: 'Wohnen', long_name_de: 'Wohnen', long_name_en: 'living')
    Category.create(short_name_de: 'Essen', long_name_de: 'Lebensmittel', long_name_en: 'foods')
    Category.create(short_name_de: 'Genießen', long_name_de: 'Genußmittel/Ausgehen', long_name_en: 'supplements')
    Category.create(short_name_de: 'Körper', long_name_de: 'Körperpflege', long_name_en: 'hygiene')
    Category.create(short_name_de: 'Hobby', long_name_de: 'Unterhaltung/Bildung/Hobby', long_name_en: 'entertainment')
    Category.create(short_name_de: 'Fahren', long_name_de: 'Fahrtkosten (Auto, RMV)', long_name_en: 'ride costs')
    Category.create(short_name_de: 'Anschaffung', long_name_de: 'Anschaffung/Instandhaltung', long_name_en: 'maintenance')
    Category.create(short_name_de: 'Apotheke', long_name_de: 'Apotheke/Gesundheit', long_name_en: 'pharma')
    Category.create(short_name_de: 'Andere', long_name_de: 'Verschiedenes', long_name_en: 'various')
  end

  desc 'Add new category_id to existing entries'
  task :modify_existing_entries do
    Expense.find_each do |expense|
      next if expense.read_attribute(:category).blank?
      category_id = Category.find_by(long_name_en: expense.read_attribute(:category).tr('_', ' ')).try(:id)
      expense.update_attributes(category_id: category_id)
    end
  end

  task default: [:create_categories, :modify_existing_entries]
end
