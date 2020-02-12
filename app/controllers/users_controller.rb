class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit]
  
  # ユーザの登録

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'signed up'
      redirect_to root_url
    else 
      flash.now[:danger] = 'failed to sign up'
      render :new
    end
  end
  
  def edit
      @user = User.find(params[:id])
  end
  
  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = 'updated successfully'
  
      else 
        flash.now[:danger] = 'failed to update'
        :edit 
      end
  end
  
  private 
  
  def user_params 
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation)
  end
end
