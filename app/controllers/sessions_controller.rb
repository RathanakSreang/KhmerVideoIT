class SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
  before_action :check_user, only: :create

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  def check_user
    user = User.find_by_email params[:user][:email]
     unless user && user.provider.blank?
      flash[:danger] = "Wrong email address"
      redirect_to new_user_session_path
     end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
