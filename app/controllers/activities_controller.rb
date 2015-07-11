class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find params[:user_id] 
    return @activities if user != current_user
    if current_user.notify.size >0
      current_user.finish_read_notify
    end
    @activities = current_user.all_notify.order("created_at DESC")
                  .paginate page: params[:page], per_page: 10

  end
end
