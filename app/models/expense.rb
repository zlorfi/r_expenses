class Expense < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :category
  has_one :organization, through: :user

  validates :title, :amount, :purchesed_on, presence: true
  validates :category, presence: true, unless: 'intake?'
  validates :amount, numericality: true

  # column no longer nedded, after migrating vom constant to model
  self.ignored_columns = %w(category)

  scope :given_organization, ->(organization_id) { joins(:user).where('users.organization_id': organization_id) }
  scope :given_year, ->(year) { where('YEAR(purchesed_on) = ?', year) }
  scope :given_month, ->(month, year, organization_id) {
    given_year(year).where('MONTH(purchesed_on) = ?', month).given_organization(organization_id)
  }
  scope :category, ->(category) { where(category: category) }

  def self.given_month_for_organization_with_intake(organization_id,
                                                    month = Date.today.month,
                                                    year = Date.today.year,
                                                    include_intake = false)
    given_month(month, year, organization_id).where(intake: include_intake)
  end
end
