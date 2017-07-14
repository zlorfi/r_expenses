module BarChart
  extend ActiveSupport::Concern

  module ClassMethods
    def generate_barchart(organization_id)
      return nil unless Organization.exists?(id: organization_id)
      bar_chart = {}
      overview = generate_barchart_from_sql_query(organization_id)
      bar_chart[overview.columns.first.to_sym] = overview.columns.drop(1)
      overview.rows.each do |row|
        bar_chart[row.first.eql?(1) ? I18n.t('expense.intake') : I18n.t('expense.outgoings')] = row.drop(1).map(&:to_f)
      end
      bar_chart
    end

    private

    def generate_barchart_from_sql_query(organization_id)
      return nil unless Organization.exists?(id: organization_id)
      query = ''
      query << 'SELECT intake AS IntakeType'
      date_list.each do |date|
        query << ", SUM(IF(EXTRACT(YEAR_MONTH FROM purchased_on) = #{date}, amount, 0)) AS '#{Date.strptime(date, '%Y%m')}'"
      end
      query << ' FROM expenses INNER JOIN users ON users.id = expenses.user_id'
      query << " WHERE users.organization_id = #{organization_id}"
      query << ' GROUP BY intake'
      ActiveRecord::Base.connection.exec_query(query)
    end
  end
end
