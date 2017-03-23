raise 'only in DEV!' unless Rails.env.development?

Expense.destroy_all
User.destroy_all
Organization.destroy_all
Category.destroy_all

organization = Organization.create(name: 'Michi Crew')

user = User.create(username: 'Michi',
            email: 'me@me.com',
            password: 'me@me.com',
            password_confirmation: 'me@me.com',
            organization: organization)

%w(Wohnen Lebensmittel Hobby Genußmittel Körperpflege Anschaffung Verschiedenes).each do |category|
  Category.create(long_name_de: category)
end

500.times do
  intake = Faker::Boolean.boolean(0.1)
  Expense.create(
    title: Faker::Commerce.product_name,
    amount: Faker::Commerce.price,
    purchesed_on: Faker::Date.between(3.months.ago, Date.today),
    intake: intake,
    user_id: user.id,
    category_id: (intake ? nil : Category.all.sample.id)
  )
end
