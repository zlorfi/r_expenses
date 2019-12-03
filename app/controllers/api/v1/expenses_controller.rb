module Api
  module V1
    class ExpensesController < ApiController
      # GET /api/v1/expenses/last_five.json
      def last_five
        render json: Expense.last_five(current_organization),
               each_serializer: Api::V1::ExpenseSerializer
      end

      # GET /api/v1/expenses/1.json
      def show
        render json: Expense.find(params[:id]),
               serializer: Api::V1::ExpenseSerializer
      end

      # GET /api/v1/expenses.json
      def index
        render json: Expense.includes(:category)
                            .given_organization(current_user.organization_id)
                            .paginate(page: params[:page], per_page: (params[:per_page] || 15))
                            .filter_from_params(params.slice(:category))
                            .in_between_dates(params[:start_date], params[:end_date])
                            .order(:purchased_on, :id)
                            .reverse_order,
               each_serializer: Api::V1::ExpenseSerializer
      end

      # GET /api/v1/expenses/in_out.json
      def in_out
        render json: Api::V1::Expenses.calculate_in_out(given_month, current_organization)
      end
    end
  end
end
