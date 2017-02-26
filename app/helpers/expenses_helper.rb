module ExpensesHelper
  def mark_amount(expense)
    intake = expense.intake? ? 'text-success' : 'text-danger'
    content_tag(:div, class: intake) do
      number_to_currency(expense.amount, locale: :de)
    end
  end
end
