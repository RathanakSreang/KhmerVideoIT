class Admin::StaticPagesController < ApplicationController
  before_action :authenticate_user!
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
    if @page.update_attributes about: params[:about]
      flash[:success] = "Successful update"
      redirect_to admin_about_path
    else
      flash[:success] = "Fails update"
      render "edit_about"
    end
  end

end
