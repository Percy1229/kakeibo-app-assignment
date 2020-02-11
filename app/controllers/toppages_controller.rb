class ToppagesController < ApplicationController
  
  #最初の画面
  def index
    if logged_in?
      @lists = current_user.lists.order("date DESC").page(params[:page]).per(5)
      @incomes = current_user.incomes.order("date DESC").page(params[:page]).per(5)
      @income_total = current_user.incomes.sum(:income)
      @expense_total = current_user.lists.sum(:expense)
      @result = @income_total - @expense_total
      @total = @result.to_s(:delimited) #カンマを入れる -> 100,000
    end
  end
end
