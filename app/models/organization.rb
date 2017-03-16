class Organization < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :users
  has_many :expenses, through: :users
end
