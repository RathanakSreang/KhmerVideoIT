class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  layout "admin/application"

  def show
    @comment = Comment.find params[:id]
  end

  def index
    @comments = Comment.order(created_at: :desc).paginate page: params[:page], per_page: 7
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    track_activity @comment
    flash[:success] = t "flash.success_delete"
    redirect_to admin_comments_path
  end

  private
  def admin_user
    redirect_to root_url unless current_user.admin? || current_user.super?
  end
end
