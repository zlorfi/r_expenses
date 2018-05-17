module Api
  module V1
    class ChartsController < ApiController
      # GET /api/v1/charts/by_month.json
      def by_month
        date_selected = params[:given_date] || Date.today.strftime('%Y%m')
        render json: Expense.by_month(date_selected, current_user.organization_id)
      end

      # GET /api/v1/charts/linechart_by_year.json
      def linechart_by_year
        year_selected = params[:given_date] || Date.today.year
        render json: Expense.generate_linechart(year_selected, current_user.organization_id)
      end

      # GET /api/v1/charts/barchart_by_year.json
      def barchart_by_year
        year_selected = params[:given_date] || Date.today.year
        render json: Expense.generate_barchart(year_selected, current_user.organization_id)
      end
    end
  end
end
