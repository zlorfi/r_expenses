module ExpensesHelper
  def mark_amount(expense)
    intake = expense.intake? ? 'text-success' : 'text-danger'
    content_tag(:div, class: intake) do
      number_to_currency(expense.amount)
    end
  end

  def category_long_name(category)
    category.send("long_name_#{I18n.locale || 'de'}") unless category.nil?
  end

  def category_short_name(category)
    category.send("short_name_#{I18n.locale || 'de'}") unless category.nil?
  end

  def given_month
    params[:given_date] || Date.today.strftime('%Y%m')
  end

  def given_year
    params[:given_date] || Date.today.year
  end
end
