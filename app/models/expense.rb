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

  scope :given_year, ->(year) { where("YEAR(purchesed_on) = ?", year) }
  scope :given_month, ->(month, year) { given_year(year).where("MONTH(purchesed_on) = ?", month) }
  scope :category, ->(category) { where(category: category, intake: false) }

  def self.given_month_with_intake(month=Date.today.month, year=Date.today.year, include_intake=false)
    given_month(month, year).where(intake: include_intake)
  end
end
