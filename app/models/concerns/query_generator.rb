module QueryGenerator
  extend ActiveSupport::Concern

  module ClassMethods
    def chart_from_sql_query(
      year:,
      organization_id:,
      field:,
      sql_alias:
    )
      query = ''
      query << "SELECT #{field} AS #{sql_alias}"
      date_list(year).sort.each do |date|
        query << ", SUM(CASE WHEN TO_CHAR(purchased_on, 'YYYYMM') = '#{date}' THEN amount ELSE 0 END)"
        query << " AS \"#{Date.strptime(date, '%Y%m')}\""
      end
      query << ' FROM expenses INNER JOIN users ON users.id = expenses.user_id'
      query << " WHERE users.organization_id = #{organization_id} GROUP BY #{field}"
      ActiveRecord::Base.connection.exec_query(query)
    end
  end
end
