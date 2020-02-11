class ToppagesController < ApplicationController
  
  #最初の画面
  def index
    if logged_in?
      @lists = current_user.lists.order("date DESC").page(params[:page]).per(5)
      @expense_total = current_user.lists.sum(:expense)
      @income_total = current_user.incomes.sum(:income)
      @result = @income_total - @expense_total
      @total = @result.to_s(:delimited) #カンマを入れる -> 100,000
    end
  end
  
  def income 
      @incomes = current_user.incomes.order("date DESC").page(params[:page]).per(5)
      @expense_total = current_user.lists.sum(:expense)
      @income_total = current_user.incomes.sum(:income)
      @result = @income_total - @expense_total
      @total = @result.to_s(:delimited) #カンマを入れる -> 100,000
      
  end 
  
  def expense
      @lists = current_user.lists.order("date DESC").page(params[:page]).per(5)
  end
  
end
