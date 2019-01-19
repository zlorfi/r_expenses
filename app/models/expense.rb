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

  scope :given_organization, lambda { |organization_id|
    joins(:user).where('users.organization_id': organization_id)
  }
  scope :given_mysql_date, lambda { |date|
    where("TO_CHAR(purchased_on, 'YYYYMM') = ?", date)
  }
  scope :category, ->(category) { where(category: category) }
  scope :in_between, lambda { |start_date, end_date|
    where(purchased_on: start_date..end_date) if start_date.present? && end_date.present?
  }
  scope :month_list_as_array, lambda {
    pluck(:purchased_on)
      .map { |item_date| calculate_date_list_as_array(item_date) }
      .uniq
      .reverse
  }
  scope :year_list_as_array, lambda {
    pluck(:purchased_on)
      .map(&:year)
      .uniq
      .reverse
  }
  scope :date_list, lambda { |year|
    select("TO_CHAR(purchased_on, 'YYYYMM') AS formated_date")
      .distinct
      .where('EXTRACT(YEAR FROM purchased_on) = ?', year)
      .map(&:formated_date)
  }
  scope :intake_with_date, lambda { |date, organization_id|
    given_mysql_date(date)
      .given_organization(organization_id)
      .where(intake: true)
  }
  scope :outgoings_with_date, lambda { |date, organization_id|
    given_mysql_date(date)
      .given_organization(organization_id)
      .where(intake: false)
  }
  scope :last_five, lambda { |organization|
    given_organization(organization)
      .order(id: :asc)
      .reverse_order
      .limit(5)
  }

  scope :by_month, lambda { |month, organization_id|
    outgoings_with_date(month, organization_id)
      .group(:category_id)
      .group_by_month(:purchased_on, format: '%Y-%m-%d')
      .sum(:amount)
      .map { |category, sum| [Category.find(category.first).long_name_de, sum.to_f] }.to_h
  }

  def self.calculate_date_list_as_array(date)
    ["#{I18n.l(date, format: '%B')} #{date.year}", date.strftime('%Y%m')]
  end
end
