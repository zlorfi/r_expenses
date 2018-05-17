module Devise
  module Strategies
    class JsonWebToken < Base
      def valid?
        bearer_header.present?
      end

      def authenticate!
        return if no_claims_or_no_claimed_user_id
        success! User.find_by_id claims['user_id']
      end

      def store?
        false
      end

      protected

      def bearer_header
        request.headers['Authorization']&.to_s
      end

      def no_claims_or_no_claimed_user_id
        !claims || !claims.key?('user_id')
      end

      private

      def claims
        strategy, token = bearer_header.split(' ')
        return nil unless (strategy || '').casecmp('bearer').zero?
        JWTWrapper.decode(token)
      end
    end
  end
end
