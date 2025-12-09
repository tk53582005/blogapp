class AccountsController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]
  
  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to profile_path
    end
  end
  
  def follow
    user = User.find(params[:id])
    current_user.follow!(user)
    redirect_to account_path(user)
  end
  
  def unfollow
    user = User.find(params[:id])
    current_user.unfollow!(user)
    redirect_to account_path(user)
  end
end