class RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    #super
    if update_resource current_user, params
      flash[:success] = "Successful Updated"
      redirect_to current_user
    else
      flash.now[:danger] = "Updated Fail"
      render "edit"
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def update_resource resource, params
    var_param = user_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      var_param = user_params_without_pass
    end
    resource.update_attributes var_param
  end

  private
  def user_params
    params.require(:user).permit :id, :name, :email,
     :password, :password_confirmation, :avatar, :avatar_cache
  end

  def user_params_without_pass
    params.require(:user).permit :id, :name, :role, :avatar, :avatar_cache,
                                  :email
  end
end
