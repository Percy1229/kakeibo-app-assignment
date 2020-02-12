class ListsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :edit]
  before_action :correct_user, only: [:update, :destroy]
  
 #支出を登録するCRUD
 
  def new
    if logged_in?
      @list = current_user.lists.build
    end
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:success] = 'added successfully'
      redirect_to root_url
    else
      flash.now[:danger] = 'Failed to add'
      render :new
    end
  end

  def edit
    @list = current_user.lists.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      flash[:success] = 'updated successfully'
      redirect_to root_path
    else
      flash.now[:danger] = 'failed to update'
      render :edit
    end
  end

  def destroy
    @list.destroy
    flash[:success] = 'deleted successfully'
    redirect_back(fallback_location: root_path)
  end
  
  private 
  def list_params
    params.require(:list).permit(:expense, :place, :item_name, :date, :category)
  end
  
  def correct_user 
    @list = current_user.lists.find_by(id: params[:id]) 
    redirect_to root_url unless @list
  end
end
