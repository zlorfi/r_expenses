module QueryGenerator
  extend ActiveSupport::Concern

  module ClassMethods
    def chart_from_sql_query(year, organization_id, field, sql_alias)
      return nil unless Organization.exists?(id: organization_id)
      query = ''
      query << "SELECT #{field} AS #{sql_alias}"
      date_list(year).each do |date|
        query << ", SUM(IF(EXTRACT(YEAR_MONTH FROM purchased_on) = #{date}, amount, 0))"
        query << " AS '#{Date.strptime(date, '%Y%m')}'"
      end
      query << ' FROM expenses INNER JOIN users ON users.id = expenses.user_id'
      query << " WHERE users.organization_id = #{organization_id} GROUP BY #{field}"
      ActiveRecord::Base.connection.exec_query(query)
    end
  end
end
