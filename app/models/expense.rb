class Expense < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :category, optional: true
  has_one :organization, through: :user

  validates :title, :amount, :purchased_on, presence: true
  validates :category, presence: true, unless: :intake?
  validates :amount, numericality: true

  # column no longer nedded, after migrating from constant to a separate model
  self.ignored_columns = %w(category)

  scope :given_organization, ->(organization_id) { joins(:user).where('users.organization_id': organization_id) }
  scope :given_mysql_date, lambda { |date, organization_id|
    where('EXTRACT(YEAR_MONTH FROM purchased_on) = ?', date).given_organization(organization_id)
  }
  scope :category, ->(category) { where(category: category) }
  scope :in_between, lambda { |start_date, end_date|
    if start_date.present? && end_date.present?
      where(purchased_on: start_date..end_date)
    end
  }
  scope :date_list_array, lambda {
    pluck(:purchased_on).map { |item_date| calculate_date_list_as_array(item_date) }.uniq.reverse
  }
  scope :date_list, lambda {
    pluck(:purchased_on).map { |item_date| item_date.strftime('%Y%m') }.uniq
  }

  def self.given_date_for_organization_with_intake(organization_id,
                                                   date = Date.today.strftime('%Y%m'),
                                                   include_intake = false)
    given_mysql_date(date, organization_id).where(intake: include_intake)
  end

  def self.calculate_date_list_as_array(date)
    ["#{I18n.l(date, format: '%B')} #{date.year}", date.strftime('%Y%m')]
  end

  def self.generate_linechart_from_sql_query(organization_id)
    return nil unless Organization.exists?(id: organization_id)
    query = ''
    query << 'SELECT category_id AS Category'
    date_list.each do |date|
      query << ", SUM(IF(EXTRACT(YEAR_MONTH FROM purchased_on) = #{date}, amount, 0)) AS '#{Date.strptime(date.to_s, '%Y%m').to_s}'"
    end
    query << ' FROM expenses INNER JOIN users ON users.id = expenses.user_id'
    query << " WHERE users.organization_id = #{organization_id}"
    query << ' GROUP BY category_id'
    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.generate_linechart(organization_id)
    return nil unless Organization.exists?(id: organization_id)
    line_chart = []
    annual_overview = generate_linechart_from_sql_query(organization_id)
    line_chart << annual_overview.columns
    annual_overview.rows.each do |row|
      next if row.first.nil?
      line_chart << row.map do |data|
        data.is_a?(BigDecimal) ? data.to_f : Category.where(id: data).try(:first).try(:short_name_de)
      end
    end
    line_chart
  end

  def self.generate_barchart_from_sql_query(organization_id)
    return nil unless Organization.exists?(id: organization_id)
    query = ''
    query << 'SELECT intake AS IntakeType'
    date_list.each do |date|
      query << ", SUM(IF(EXTRACT(YEAR_MONTH FROM purchased_on) = #{date}, amount, 0)) AS '#{Date.strptime(date.to_s, '%Y%m').to_s}'"
    end
    query << ' FROM expenses INNER JOIN users ON users.id = expenses.user_id'
    query << " WHERE users.organization_id = #{organization_id}"
    query << ' GROUP BY intake'
    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.generate_barchart(organization_id)
    return nil unless Organization.exists?(id: organization_id)
    bar_chart = []
    overview = generate_barchart_from_sql_query(organization_id)
    bar_chart << overview.columns
    overview.rows.each do |row|
      bar_chart << row.map do |data|
        data.is_a?(BigDecimal) ? data.to_f : data.eql?(1) ? I18n.t('expense.intake') : I18n.t('expense.outgoings')
      end
    end
    bar_chart
  end
end
