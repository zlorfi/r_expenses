module ExpensesHelper
  def mark_amount(expense)
    intake = expense.intake? ? 'text-success' : 'text-danger'
    content_tag(:div, class: intake) do
      number_to_currency(expense.amount, locale: :de)
    end
  end

  def set_button_text
    if controller_name.eql?('expenses') && action_name.eql?('edit')
      t('expense.update')
    else
      t('expense.create')
    end
  end

  def category_long_name(category)
    category.send("long_name_#{I18n.locale}") unless category.nil?
  end

  def category_short_name(category)
    category.send("short_name_#{I18n.locale}") unless category.nil?
  end

  def given_month
    params[:month] || Date.today.month
  end

  def given_year
    params[:year] || Date.today.year
  end
end
