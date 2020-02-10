class IncomesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy];
  
  def checker
    @incomes = current_user.incomes.order(id: :desc).page(params[:page])
  end
  
  def new
    if logged_in?
      @income = current_user.incomes.build
    end
  end

  def create
    @income = current_user.incomes.build(income_params)
    if @income.save
      flash[:success] = 'added successfully'
      redirect_to root_url
    else
      flash[:danger] = 'Failed to add'
      render :new
    end
  end
  
  def edit
    @income = current_user.incomes.find(params[:id])
  end

  def update
    @income = income.find(params[:id])
    if @income.update(income_params)
      flash[:success] = 'updated successfully'
      redirect_to root_url
    else
      flash[:danger] = 'failed to update'
      render :edit
    end
  end
  
  def destroy
    @income.destroy
    flash[:success] = 'deleted successfully'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def income_params
    params.require(:income).permit(:income, :source, :date)
  end
  
  def correct_user
    @income = current_user.incomes.find_by(id: params[:id])
    redirect_to root_url unless @income
  end
end
