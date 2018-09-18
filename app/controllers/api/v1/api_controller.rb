module Api
  module V1
    class ApiController < ActionController::Base
      include Auth
      include ExceptionHandler

      private

      def current_organization
        current_user.organization_id
      end

      def given_month
        params[:given_date] || Date.today.strftime('%Y%m')
      end

      def given_year
        params[:given_date] || Date.today.year
      end
    end
  end
end
