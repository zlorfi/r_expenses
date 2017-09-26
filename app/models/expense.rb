class Expense < ApplicationRecord
  include Filterable
  include LineChart
  include BarChart

  belongs_to :user
  belongs_to :category, optional: true
  has_one :organization, through: :user

  validates :title, :amount, :purchased_on, presence: true
  validates :category, presence: true, unless: :intake?
  validates :amount, numericality: true

  # column no longer nedded, after migrating from constant to a separate model
  self.ignored_columns = %w[category]

  scope :given_organization, ->(organization_id) { joins(:user).where('users.organization_id': organization_id) }
  scope :given_mysql_date, lambda { |date|
    where('EXTRACT(YEAR_MONTH FROM purchased_on) = ?', date)
  }
  scope :category, ->(category) { where(category: category) }
  scope :in_between, lambda { |start_date, end_date|
    if start_date.present? && end_date.present?
      where(purchased_on: start_date..end_date)
    end
  }
  scope :month_list_as_array, lambda {
    pluck(:purchased_on).map { |item_date| calculate_date_list_as_array(item_date) }.uniq.reverse
  }
  scope :year_list_as_array, lambda {
    pluck(:purchased_on).map(&:year).uniq.reverse
  }
  scope :date_list, lambda {
    pluck(:purchased_on).map { |item_date| item_date.strftime('%Y%m') }.uniq
  }
  scope :intake_with_date, lambda { |date, organization_id|
    given_mysql_date(date).given_organization(organization_id).where(intake: true)
  }
  scope :outgoings_with_date, lambda { |date, organization_id|
    given_mysql_date(date).given_organization(organization_id).where(intake: false)
  }

  def self.calculate_date_list_as_array(date)
    ["#{I18n.l(date, format: '%B')} #{date.year}", date.strftime('%Y%m')]
  end
end
