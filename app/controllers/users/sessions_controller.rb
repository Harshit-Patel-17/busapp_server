class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  respond_to :json

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    respond_to do |format|
      format.html {
        if(current_user.role == "conductor")
          sign_out current_user
          redirect_to new_user_session_path, alert: "Conductor cannot access this portal"
        end
      }
      format.json {}
    end
  end

  # DELETE /resource/sign_out
  def destroy
    current_user.authentication_token = nil
    current_user.save!
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #  devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
