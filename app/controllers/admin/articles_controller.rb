class Admin::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :load_article, only: [:show, :edit, :update]
  layout "admin/application"

  def show    
  end

  def index    
    if params[:search]
      @articles = Article.search(params[:search])                  
                  .includes(:user, :translations)
                  .paginate page: params[:page], per_page: 7
    else
      @articles = Article.order("created_at DESC")
                  .includes(:user, :translations)
                  .paginate page: params[:page], per_page: 7
    end
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new article_params
    if @article.save
      track_activity @article
      flash[:success] = t "flash.success_create"
      redirect_to [:admin, @article]
    else
      flash.now[:danger] = t "flash.fail_create"
      render "new"
    end    
  end

  def edit    
  end

  def update
    if @article.update_attributes article_params
      track_activity @article
      flash[:success] = t "flash.success_update"
      redirect_to [:admin, @article]
    else
      flash.now[:danger] = t "flash.fail_update"
      render "edit"
    end
  end

  def destroy
    @article = Article.friendly.find params[:id]
    @article.destroy
    track_activity @article
    flash[:success] = t "flash.success_delete"
    redirect_to admin_articles_path
  end

  private
  def article_params
    params.require(:article).permit :id, :content, :title, :description, :status,
                                    :publish_date, tag_ids:[]
  end

  def load_article
    @article = Article.includes(:user, :translations, :tags => :translations)
                      .friendly.find params[:id]
  end

  def admin_user
    redirect_to root_url unless current_user.admin? || current_user.super?
  end
end
