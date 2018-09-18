module Api
  module V1
    class ChartsController < ApiController
      # GET /api/v1/charts/by_month.json
      def by_month
        render json: Expense.by_month(given_month, current_organization)
      end

      # GET /api/v1/charts/linechart_by_year.json
      def linechart_by_year
        render json: Expense.generate_linechart(given_year, current_organization)
      end

      # GET /api/v1/charts/barchart_by_year.json
      def barchart_by_year
        render json: Expense.generate_barchart(given_year, current_organization)
      end
    end
  end
end
