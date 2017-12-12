class ChartsController < ApplicationController
  # GET /charts/by_month.json
  def by_month
    date_selected = params[:given_date] || Date.today.strftime('%Y%m')
    render json: Expense.outgoings_with_date(date_selected, current_user.organization_id)
                        .group(:category_id)
                        .group_by_month(:purchased_on, format: '%Y-%m-%d')
                        .sum(:amount)
                        .map { |k, v| [Category.find(k.first).long_name_de, v] }.to_h
  end

  # GET /charts/linechart_by_year.json
  def linechart_by_year
    year_selected = params[:given_date] || Date.today.year
    render json: Expense.generate_linechart(year_selected, current_user.organization_id)
  end

  # GET /charts/barchart_by_year.json
  def barchart_by_year
    year_selected = params[:given_date] || Date.today.year
    render json: Expense.generate_barchart(year_selected, current_user.organization_id)
  end
end
