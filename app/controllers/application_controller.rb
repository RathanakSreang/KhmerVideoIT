class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  before_action :configure_permitted_parameters, if: :devise_controller?
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_side_menu

  before_filter :set_locale
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :avatar_cache
  end

  def track_activity trackable, action = params[:action]
    tracking = current_user.activities.new action: action, trackable: trackable
    if trackable.class.to_s == "Comment"
      if trackable.parent
        tracking.user_tracked_id = trackable.parent.user.id
      else
        tracking.user_tracked_id = trackable.commentable.user.id
      end    
    end
    tracking.save!
    # current_user.activities.create! action: action, trackable: trackable,
    # user_tracked_id: (trackable.class.to_s != "User" ? trackable.user.id : "")
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  def set_side_menu
    @page ||= Page.first
    @random_tags ||= Tag.order("created_at DESC")
                        .includes(:translations).limit(6)
    @latest_videos ||= Video.status_show.order("created_at DESC")
                    .includes(:translations).limit(6) unless "videos".include?(params[:controller])
    @latest_articles ||= Article.status_show.order("created_at DESC")
                    .includes(:translations).limit(6) unless "articles".include?(params[:controller])
    @latest_question ||= Question.order("created_at DESC")
                    .limit(6) unless "questions".include?(params[:controller])
  end
end
