module Auth
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'application/json' }
        format.html { redirect_to root_url, alert: exception.message }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end
  end
end
