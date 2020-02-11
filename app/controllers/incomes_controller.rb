class IncomesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :update]
  require "date"
  
   #収入のCRUD
  
  def checker #収入が103万円を超えているかを確認できるようにする
    if logged_in?
      
      @order = current_user.incomes.order(id: :desc).page(params[:page])
      
      @d = Date.today #今年のみ取得する
      @incomes = current_user.incomes.all
      
      #これまで稼いだお金の合計
      @all_money = current_user.incomes.all.sum(:income)
      @result_with_period = @all_money.to_s(:delimited) #カンマを入れる -> 100,000
      
      #これから稼ぎそうなお金　ボタン押すと計算してオーバーするか教えてくれる(追加予定？)
      
      #103万円 - 稼いだお金(今年) = reseult
      @total = 0;
      @incomes.each do |income|
        if @d.year == income.date.year && income.source != "others" #今年と登録された年が同じ && 収入源がおこづかいなどではない
          @total += income.income #合計値を計算する
        end
      end
      @result = 1030000 - @total 
      
      #結果に応じてメッセージを表示させる
      if @result <= 0  
        @comment = 'Sorry, your income has already been over.'
      elsif @result <= 100000
        @comment = 'Your income almost reaches to 1,030,000. You should arrange your job.'
      else 
        @comment = 'Your income is safe. Good job.'
      end
      
    end
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
      flash.now[:danger] = 'Failed to add'
      render :new
    end
  end
  
  def edit
    if logged_in?
      @income = current_user.incomes.find(params[:id])
    end
  end

  def update
    @income = income.find(params[:id])
    if @income.update(income_params)
      flash[:success] = 'updated successfully'
      redirect_to root_url
    else
      flash.now[:danger] = 'failed to update'
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
