class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit]
  before_action :correct_user, only: [:update]
  
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
        render :edit
      else 
        flash.now[:danger] = 'failed to update'
        render :edit 
      end
  end
  
  private 
  
  def user_params 
    params.require(:user).permit(
      :name, :email, :goal, :password, :password_confirmation)
  end
  
  def correct_user 
    @list = current_user.lists.find_by(id: params[:id]) 
    redirect_to root_url unless @list
  end
end
