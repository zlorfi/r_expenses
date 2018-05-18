module JWTWrapper
  module_function

  def encode(payload, expiration = nil)
    expiration ||= Rails.application.secrets.jwt_expiration_hours

    payload = payload.dup
    payload['exp'] = expiration.to_i.hours.from_now.to_i

    JWT.encode(payload, Rails.application.secrets.jwt_secret)
  end

  def decode(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.jwt_secret)
    decoded_token.first
  rescue JWT::DecodeError, JWT::ExpiredSignature
    raise ExceptionHandler::InvalidToken
  end
end
