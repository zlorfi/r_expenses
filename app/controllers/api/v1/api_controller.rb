module Api
  module V1
    class ApiController < ActionController::Base
      include Auth
      include ExceptionHandler
    end
  end
end
