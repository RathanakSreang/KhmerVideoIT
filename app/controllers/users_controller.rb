class UsersController < ApplicationController  
  
  def show
    @user = User.find params[:id]
    @comments = @user.comments.order("created_at DESC")
                            .paginate page: params[:page], per_page: 7
  end
end
