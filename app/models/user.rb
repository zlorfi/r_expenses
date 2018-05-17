class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :organization, presence: true

  belongs_to :organization
  has_many :expenses
end
