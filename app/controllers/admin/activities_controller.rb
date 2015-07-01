class Admin::ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user  
  layout "admin/application"

  def index
    @activities = Activity.order("created_at desc")
                          .paginate page: params[:page], per_page: 12
  end

  def show
    
  end  

  private
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
