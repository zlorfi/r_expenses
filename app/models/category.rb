class Category < ApplicationRecord
  has_many :expenses

  default_scope { order(id: :asc) }
end
