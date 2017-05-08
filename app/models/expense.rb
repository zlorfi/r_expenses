class Expense < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :category
  has_one :organization, through: :user

  validates :title, :amount, :purchased_on, presence: true
  validates :category, presence: true, unless: :intake?
  validates :amount, numericality: true

  # column no longer nedded, after migrating vom constant to model
  self.ignored_columns = %w(category)

  scope :given_organization, ->(organization_id) { joins(:user).where('users.organization_id': organization_id) }
  scope :given_year, ->(year) { where('YEAR(purchased_on) = ?', year) }
  scope :given_month, lambda { |month, year, organization_id|
    given_year(year).where('MONTH(purchased_on) = ?', month).given_organization(organization_id)
  }
  scope :category, ->(category) { where(category: category) }
  scope :in_between, lambda { |start_date, end_date|
    if start_date.present? && end_date.present?
      where(purchased_on: start_date..end_date)
    end
  }
  scope :date_list, lambda {
    distinct.pluck(:purchased_on).map { |item| calculate_date_list(item.month, item.year) }.uniq.reverse
  }

  def self.given_month_for_organization_with_intake(organization_id,
                                                    month = Date.today.month,
                                                    year = Date.today.year,
                                                    include_intake = false)
    given_month(month, year, organization_id).where(intake: include_intake)
  end

  def self.calculate_date_list(month, year)
    ["#{I18n.l(DateTime.parse(Date::MONTHNAMES[month.to_i]), format: '%B')} #{year}", "#{year}_#{month}"]
  end
end
