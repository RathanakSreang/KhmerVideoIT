class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  before_action :configure_permitted_parameters, if: :devise_controller?
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :avatar_cache
  end

  def track_activity trackable, action = params[:action]
    current_user.activities.create! action: action, trackable: trackable
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end  
end
