class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'show'
    end
  end

  def destroy

  end

  private 

  def user_params 
    params.require(:user).permit(:admin, :staff)
  end
end
