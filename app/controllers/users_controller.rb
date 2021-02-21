class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params[:user])
      redirect_to users_path
    else
      render 'show'
    end
  end

  def destroy

  end
end
