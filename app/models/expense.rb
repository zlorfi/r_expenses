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

  scope :given_group, ->(group_id) { includes(:user).where('users.group_id': group_id) }
  scope :given_year, ->(year) { where("YEAR(purchesed_on) = ?", year) }
  scope :given_month, ->(month, year, group_id) { given_year(year).where("MONTH(purchesed_on) = ?", month).given_group(group_id) }
  scope :category, ->(category) { where(category: category, intake: false) }

  def self.given_month_for_group_with_intake(group_id, month=Date.today.month, year=Date.today.year, include_intake=false)
    given_month(month, year, group_id).where(intake: include_intake)
  end
end
