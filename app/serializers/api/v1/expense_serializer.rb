module Api
  module V1
    class ExpenseSerializer < ApplicationSerializer
      attribute :id
      attribute :title
      attribute :amount
      attribute :purchased_on
      attribute :intake
      attribute :user_id
      attribute :category_id
    end
  end
end
