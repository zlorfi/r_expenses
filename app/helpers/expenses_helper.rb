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

  def category_name(category)
    Expense::CATEGORIES.fetch(category.to_sym, '')
  end
end
