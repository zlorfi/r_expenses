module LineChart
  extend ActiveSupport::Concern
  include QueryGenerator

  module ClassMethods
    def generate_linechart(year, organization_id)
      return nil unless Organization.exists?(id: organization_id)

      chart = {}
      overview = chart_from_sql_query(
        year: year,
        organization_id: organization_id,
        field: 'category_id',
        sql_alias: 'months_line'
      )
      chart[overview.columns.first.to_sym] = overview.columns.drop(1)
      overview.rows.each do |row|
        next if row.first.nil?

        chart[Category.find_by(id: row.first).try(:short_name_de).to_sym] = row.drop(1).map(&:to_f)
      end
      chart
    end
  end
end
