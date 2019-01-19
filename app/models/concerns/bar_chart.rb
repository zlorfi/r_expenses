module BarChart
  extend ActiveSupport::Concern
  include QueryGenerator

  module ClassMethods
    def generate_barchart(year, organization_id)
      return nil unless Organization.exists?(id: organization_id)
      chart = {}
      overview = chart_from_sql_query(year, organization_id, 'intake', 'months_bar')
      chart[overview.columns.first.to_sym] = overview.columns.drop(1)
      overview.rows.each do |row|
        chart[row.first.eql?(true) ? I18n.t('expense.intake') : I18n.t('expense.outgoings')] = row.drop(1).map(&:to_f)
      end
      chart
    end
  end
end
