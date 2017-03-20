json.set! :id, expense.id
json.set! :title, expense.title
json.set! :category, category_long_name(expense.category)
json.set! :amount, number_to_currency(expense.amount, locale: :de)
json.set! :purchesed_on, expense.purchesed_on
json.set! :intake, expense.intake
json.set! :created_at, expense.created_at
json.set! :updated_at, expense.updated_at
json.set! :url, expense_url(expense, format: :json)
