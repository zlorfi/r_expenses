class ApplicationController < ActionController::Base
  include Auth
  include ExceptionHandler
  protect_from_forgery prepend: true
end
