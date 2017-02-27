class Expense < ApplicationRecord
  include Filterable

  CATEGORIES = { living: 'Wohnen',
                 foods: 'Lebensmittel',
                 supplements: 'Genußmittel',
                 hygiene: 'Körperpflege',
                 entertainment: 'Unterhaltung/Bildung/Hobby',
                 ride_costs: 'Fahrtkosten (Auto, RMV)',
                 maintenance: 'Anschaffung/Instandhaltung',
                 various: 'Verschiedenes' }

  belongs_to :user

  validates :title, :amount, :purchesed_on, presence: true
  validates :category, presence: true, unless: 'intake?'
  validates :amount, numericality: true
  validates :category, inclusion: { in: CATEGORIES.collect {|k,v| k.to_s } }, unless: 'intake?'

  scope :current_month, -> { where("MONTH(purchesed_on) = ?", Date.today.month) }
  scope :current_year, -> { where("YEAR(purchesed_on) = ?", Date.today.year) }

  scope :given_month, ->(month, year) { where("MONTH(purchesed_on) = ? AND YEAR(purchesed_on) = ?", month, year) }
  scope :given_year, ->(year) { where("YEAR(purchesed_on) = ?", year) }

  scope :category, ->(category) { where(category: category, intake: false) }

  def self.current_month_sum_with_intake(include_intake=false)
    current_month.where(intake: include_intake).sum(:amount)
  end

  def self.current_month_sum_for_category(category, include_intake=false)
    current_month.where(category: category, intake: include_intake).sum(:amount)
  end

  def self.current_year_sum_with_intake(include_intake=false)
    current_year.where(intake: include_intake).sum(:amount)
  end

  def self.current_year_sum_for_category(category, include_intake=false)
    current_year.where(category: category, intake: include_intake).sum(:amount)
  end

  def self.given_month_sum(month, year, include_intake=false)
    given_month(month, year).where(intake: include_intake).sum(:amount)
  end

  def self.given_month_sum_for_category(month, year, category, include_intake=false)
    given_month(month, year).where(category: category, intake: include_intake).sum(:amount)
  end

  def self.given_year_sum(year, include_intake=false)
    given_year(year).where(intake: include_intake).sum(:amount)
  end

  def self.given_year_sum_for_category(year, category, include_intake=false)
    given_year(year).where(category: category, intake: include_intake).sum(:amount)
  end
end
