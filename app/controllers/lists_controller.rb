class ListsController < ApplicationController
  def new
    if logged_in?
      @list = current_user.lists.build
    end
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:success] = 'Expense added successfully'
      redirect_to root_url
    else
      flash[:danger] = 'Failed to add'
      render :new
    end
  end

  def edit
    @lists = current_user.lists.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      flash[:success] = 'updated successfully'
      redirect_to root_path
    else
      flash[:danger] = 'failed to update'
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
    @list = current_user.lists.find_by(id: params[:id])
    redirect_to signin_url unless @list
  end
end
