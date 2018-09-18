module Users
  class SessionsController < Devise::SessionsController
    # POST /users/sign_in
    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_to do |format|
        format.html { redirect_to after_sign_in_path_for(resource) }
        format.json { render json: { token: JWTWrapper.encode(user_id: resource.id) } }
      end
    end
  end
end
