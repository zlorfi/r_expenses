module Api
  module V1
    class Expenses
      class << self
        def calculate_in_out(given_month, current_organization)
          intake = Expense.intake_with_date(given_month, current_organization).sum(:amount)
          outgoings = Expense.outgoings_with_date(given_month, current_organization).sum(:amount)
          difference = intake - outgoings
          {
            intake: number_to_eur(intake),
            outgoings: number_to_eur(outgoings),
            difference: number_to_eur(difference),
            negative: difference.negative? ? true : false
          }
        end

        def calculate_years_difference
          query = ''
          query << 'SELECT EXTRACT(YEAR FROM purchased_on)::integer AS year'
          query << ' , SUM(CASE WHEN intake = true THEN amount WHEN intake = false THEN - amount ELSE 0 END)'
          query << ' FROM expenses GROUP BY year ORDER BY year'
          result = ActiveRecord::Base.connection.exec_query(query)
          {
            data: result.rows
          }
        end

        private

        def number_to_eur(number)
          ActionController::Base.helpers.number_to_currency(number, localte: :de)
        end
      end
    end
  end
end
