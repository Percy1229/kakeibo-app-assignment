class ToppagesController < ApplicationController
  def index
    if logged_in?
      @expense = current_user.lists.all
      @total = @expense.sum(:expense)
      @lists = current_user.lists.order(id: :desc).page(params[:page])
      
    end
  end
end
