class Admin::StaticPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  layout "admin/application"

  def dashboard
    
  end

  def about
    @page = Page.first
  end

  def edit_about
    @page = Page.first
    @page = Page.create unless @page
  end

  def update_about
    @page = Page.first
    if @page.update_attributes page_params
      flash[:success] = t "flash.success_update"
      redirect_to admin_about_path
    else
      flash[:success] = t "flash.fail_update"
      render "edit_about"
    end
  end

  private
  def page_params
    params.require(:page).permit :id, :about, :ff_link, :tw_link, :yt_link
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
