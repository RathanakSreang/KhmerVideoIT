class Admin::LanguagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_language, only: [:show, :edit, :update]

  layout "admin/application"

  def show
    @tutorials = @language.tutorials.paginate page: params[:page], per_page: 10
    @articles = @language.articles.paginate page: params[:page], per_page: 10
  end

  def index
    @languages = Language.all.paginate page: params[:page], per_page: 10
  end

  def new
    @language = Language.new
  end

  def create
    @language = Language.new language_params
    if @language.save
      flash[:success] = "Successful create"
      redirect_to [:admin, @language]
    else
      flash.now[:danger] = "Fail create"
      render "new"
    end    
  end

  def edit
  end

  def update
    if @language.update language_params
      flash[:success] = "Successful update"
      redirect_to [:admin, @language]
    else
      flash.now[:danger] = "Fail update"
      render "edit"
    end
  end

  def destroy
    @language = Language.find params[:id]
    @language.destroy
    flash[:success] = "Successful delete"
  end

  private
  def language_params
    params.require(:language).permit :id, :name
  end

  def load_language
    @language = Language.find params[:id]
  end
end
