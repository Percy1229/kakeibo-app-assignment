class UsersController < ApplicationController
  def index
  end

  def show
     @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'signed up'
      redirect_to root_url
    else 
      flash.now[:danger] = 'Failed to sign up'
      render :new
    end
  end
  
  private 
  
  def user_params 
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation)
  end
end
