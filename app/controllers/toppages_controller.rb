class ToppagesController < ApplicationController
  def index
    if logged_in?
      @list = current_user.lists.build
      @lists = current_user.lists.order(id: :desc).page(params[:page])
    end
  end
end
