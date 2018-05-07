module Api
  module V1
    class ApiController < ActionController::Base
      include Auth
    end
  end
end
