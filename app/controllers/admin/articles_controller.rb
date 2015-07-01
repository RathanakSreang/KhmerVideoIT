class Admin::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :load_article, only: [:show, :edit, :update]
  layout "admin/application"

  def show    
  end

  def index    
    if params[:search]
      @articles = Article.search(params[:search]).order("created_at DESC").paginate page: params[:page], per_page: 7
    else
      @articles = Article.order("created_at DESC").paginate page: params[:page], per_page: 7
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      track_activity @article
      flash[:success] = "Successful create"
      redirect_to [:admin, @article]
    else
      flash.now[:danger] = "Fail create"
      render "new"
    end    
  end

  def edit    
  end

  def update
    if @article.update_attributes article_params
      track_activity @article
      flash[:success] = "Successful update"
      redirect_to [:admin, @article]
    else
      flash.now[:danger] = "Fail update"
      render "edit"
    end
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy
    track_activity @article
    flash[:success] = "Successful delete"
    redirect_to admin_articles_path
  end

  private
  def article_params
    params.require(:article).permit :id, :content, :title, :description, tag_ids:[]
  end

  def load_article
    @article = Article.find params[:id]
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
