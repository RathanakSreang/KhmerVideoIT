class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :load_question, only: [:show, :edit, :update]
  layout "admin/application"

  def show
  end

  def index
    if params[:search]
      @questions = Question.search(params[:search])
            .order("created_at DESC").paginate page: params[:page], per_page: 7
    else
      @questions = Question.order("created_at DESC")
            .paginate page: params[:page], per_page: 7
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "flash.success_update"
      track_activity @question
      redirect_to [:admin, @question]
    else
      flash.now[:danger] = t "flash.fail_update"
      render "edit"
    end
  end

  def destroy
    @question = Question.friendly.find params[:id]
    track_activity @question
    @question.destroy
    flash[:success] = t "flash.success_delete"
    redirect_to admin_questions_path
  end

  private
  def load_question
    @question = Question.friendly.find params[:id]
  end

  def question_params
    params.require(:question).permit :id, :title, :content, tag_ids:[]
  end

  def admin_user
    redirect_to root_url unless current_user.admin? || current_user.super?
  end
end
