class ExpensesController < ApplicationController
  load_and_authorize_resource param_method: :expense_params
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.includes(:category)
                       .given_organization(current_user.organization_id)
                       .paginate(page: params[:page], per_page: (params[:per_page] || 15))
                       .filter(params.slice(:category))
                       .in_between(params[:start_date], params[:end_date])
                       .order(:purchased_on, :id)
                       .reverse_order
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit; end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    respond_to do |format|
      if @expense.save
        format.html { redirect_to root_path, notice: I18n.t('expense.successfully_created') }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to root_path, notice: I18n.t('expense.successfully_updated') }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: I18n.t('expense.successfully_deleted') }
      format.json { head :no_content }
    end
  end

  # GET /expenses/month
  def month
    return unless params[:date_list]
    redirect_to monthly_expenses_path(given_date: params[:date_list])
  end

  # GET /expenses/year
  def year; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expense_params
    params.require(:expense).permit(:title, :amount, :category_id, :purchased_on, :intake)
  end
end
