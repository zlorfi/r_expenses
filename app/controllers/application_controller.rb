class ApplicationController < ActionController::Base
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  protect_from_forgery prepend: true

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  private

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user = user_email && User.find_by(email: user_email)

    return unless user && Devise.secure_compare(user.authentication_token, params[:user_token])
    sign_in user, store: false
  end
end
