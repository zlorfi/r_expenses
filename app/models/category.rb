class Category < ApplicationRecord
  has_many :expenses

  default_scope { order(id: :asc) }

  def category_name
    self.send("short_name_#{I18n.locale}") ||
    self.send("long_name_#{I18n.locale}")
  rescue
    "No name for category ##{self.id} set for locale: #{I18n.locale}."
  end

end
