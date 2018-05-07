class ApplicationController < ActionController::Base
  include Auth
  protect_from_forgery prepend: true
end
