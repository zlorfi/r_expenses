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

  def self.generate_linechart_from_sql_query(organization_id)
    return nil unless Organization.exists?(id: organization_id)
    query = ''
    query << 'SELECT EXTRACT(YEAR_MONTH FROM purchased_on) AS PurchasedOn'
    Category.all.each do |category|
      query << ", SUM(IF(category_id = #{category.id}, amount, 0)) AS #{category.short_name_de}"
    end
    query << ' FROM expenses INNER JOIN users ON users.id = expenses.user_id'
    query << " WHERE users.organization_id = #{organization_id}"
    query << ' GROUP BY EXTRACT(YEAR_MONTH FROM purchased_on)'
    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.generate_linechart(organization_id)
    return nil unless Organization.exists?(id: organization_id)
    line_chart = []
    annual_overview = generate_linechart_from_sql_query(organization_id)
    line_chart << annual_overview.columns
    annual_overview.rows.each do |row|
      line_chart << row.map do |data|
        data.is_a?(BigDecimal) ? data.to_f : I18n.l(Date.strptime(data.to_s, '%Y%m'), format: '%B %Y')
      end
    end
    line_chart
  end

  def self.generate_barchart_from_sql_query(organization_id)
    return nil unless Organization.exists?(id: organization_id)
    query = ''
    query << 'SELECT EXTRACT(YEAR_MONTH FROM purchased_on) AS PurchasedOn'
    query << ", SUM(IF(intake = 1, amount, 0)) AS #{I18n.t('expense.intake')}"
    query << ", SUM(IF(intake = 0, amount, 0)) AS #{I18n.t('expense.outgoings')}"
    query << ' FROM expenses INNER JOIN users ON users.id = expenses.user_id'
    query << " WHERE users.organization_id = #{organization_id}"
    query << ' GROUP BY EXTRACT(YEAR_MONTH FROM purchased_on)'
    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.generate_barchart(organization_id)
    return nil unless Organization.exists?(id: organization_id)
    bar_chart = []
    overview = generate_barchart_from_sql_query(organization_id)
    bar_chart << overview.columns
    overview.rows.each do |row|
      bar_chart << row.map do |data|
        data.is_a?(BigDecimal) ? data.to_f : I18n.l(Date.strptime(data.to_s, '%Y%m'), format: '%B %Y')
      end
    end
    bar_chart
  end
end
