module LineChart
  extend ActiveSupport::Concern

  module ClassMethods
    def generate_linechart(year, organization_id)
      return nil unless Organization.exists?(id: organization_id)
      line_chart = {}
      overview = generate_linechart_from_sql_query(year, organization_id)
      line_chart[overview.columns.first.to_sym] = overview.columns.drop(1)
      overview.rows.each do |row|
        next if row.first.nil?
        line_chart[Category.where(id: row).try(:first).try(:short_name_de).to_sym] = row.drop(1).map(&:to_f)
      end
      line_chart
    end

    private

    def generate_linechart_from_sql_query(year, organization_id)
      return nil unless Organization.exists?(id: organization_id)
      query = ''
      query << 'SELECT category_id AS Category'
      date_list(year).each do |date|
        query << ", SUM(IF(EXTRACT(YEAR_MONTH FROM purchased_on) = #{date}, amount, 0))"
        query << " AS '#{Date.strptime(date, '%Y%m')}'"
      end
      query << ' FROM expenses INNER JOIN users ON users.id = expenses.user_id'
      query << " WHERE users.organization_id = #{organization_id} GROUP BY category_id"
      ActiveRecord::Base.connection.exec_query(query)
    end
  end
end
