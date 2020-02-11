class ToppagesController < ApplicationController
  
  #最初の画面
  
  def index
    if logged_in?
      @total = current_user.lists.sum(:expense)
      @lists = current_user.lists.order(id: :desc).page(params[:page])
      
    end
  end
end
