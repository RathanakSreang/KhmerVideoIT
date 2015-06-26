class Admin::TutorialsController < ApplicationController
  before_action :set_tutorial, only: [:show, :edit, :update]
  layout "admin/application"

  def show
    @videos = @tutorial.videos.paginate page: params[:page], per_page: 10
  end

  def index    
    if params[:search]
      @tutorials = Tutorial.search(params[:search]).order("created_at DESC").paginate page: params[:page], per_page: 7
    else
      @tutorials = Tutorial.order("created_at DESC").paginate page: params[:page], per_page: 7
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new tutorial_params
    if @tutorial.save
      flash[:success] = "Successful create"
      redirect_to [:admin, @tutorial]  
    else
      flash.now[:danger] = "Fail Create"
      render "new"
    end
  end

  def edit
  end

  def update
    if @tutorial.update_attributes tutorial_params
      flash[:success] = "Successful update"
      redirect_to [:admin, @tutorial]  
    else
      flash.now[:danger] = "Fail update"
      render "edit"
    end
  end

  def destroy
    @tutorial = Tutorial.find params[:id]
    @tutorial.destroy
    flash[:success] = "Successful delete"
    redirect_to admin_tutorials_path
  end

  private
  def tutorial_params
    params.require(:tutorial).permit :id, :title, :language_id, :description
  end

  def set_tutorial
    @tutorial = Tutorial.find params[:id]
  end
end
