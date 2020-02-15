class IncomesController < ApplicationController
  before_action :require_user_logged_in, only: [:search, :checker, :new, :edit]
  before_action :correct_user, only: [:destroy, :update]
  require "date"
  
   #収入のCRUD
   def search
      @income = current_user.incomes
      
      #dateカラムで検索する(::textはPostgreSQLのdate型からstring型に変更)
      @incomes = @income.where('date::text LIKE ?', "%#{params[:date]}%").order("date DESC").page(params[:page]).per(10)

      @income_total = 0
      
      #結果のトータル収入
      @incomes.each do |income|
        @income_total += income.income unless @incomes.count == 0
      end
   
      #date型をグループ化
      @date = @income.group(:date).pluck(:date)
   end
  
  def checker #収入が103万円を超えているかを確認できるようにする
    if logged_in?
      
      @user = current_user.name
      @order = current_user.incomes.order(id: :desc).page(params[:page])
      @d = Date.today #今年のみ取得する
      @incomes = current_user.incomes.all
      
      #これまで稼いだお金の合計
      @all_money = current_user.incomes.all.sum(:income)
      @all_money_with_period = @all_money.to_s(:delimited) #カンマを入れる -> 100,000
      
      #今年に登録された収入 && 収入源がおこづかいなどではない場合は、トータル換算する
      @total = 0;
      @incomes.each do |income|
        if @d.year == income.date.year && income.source != "others" 
          @total += income.income #合計値を計算する
        end
      end
      
      @total_str = @total.to_s(:delimited)
      
      #103万円 - 稼いだお金(今年) = reseult
      @result = 1030000 - @total #残りの稼げるお金
      @result_with_period = @result.to_s(:delimited)
      
      #結果に応じてメッセージを表示
      if @result <= 0  
        @message = 'Sorry, your income has already been over.'
      elsif @result <= 100000
        @message = 'Your income almost reaches to 1,030,000. You should arrange your job.'
      else 
        @message = 'Your income is safe. Good job.'
      end
      
      #130万円の場合
      @result_130 = 1300000 - @total #残りの稼げるお金
      @result_130_with_period = @result_130.to_s(:delimited)
      
      #結果に応じてメッセージを表示
      if @result_130 <= 0  
        @message_130 = 'Sorry, your income has already been over.'
      elsif @result_130 <= 100000
        @message_130 = 'Your income almost reaches to 1,300,000. You should arrange your job.'
      else 
        @message_130 = 'Your income is safe. Good job.'
      end
    
    end
  end
  
  def new
    if logged_in?
      @income = current_user.incomes.build #収入の登録
    end
  end

  def create
    #収入の登録
    @income = current_user.incomes.build(income_params)
    if @income.save
      flash[:success] = 'added successfully'
      redirect_to toppages_income_path
    else
      flash.now[:danger] = 'Failed to add'
      render :new
    end
  end
  
  def edit
    if logged_in?
      @income = current_user.incomes.find(params[:id]) #収入の編集
    end
  end

  def update
    #収入の編集
    @income = current_user.incomes.find(params[:id])
    if @income.update(income_params)
      flash[:success] = 'updated successfully'
      redirect_to toppages_income_path
    else
      flash.now[:danger] = 'failed to update'
      render :edit
    end
  end
  
  def destroy
    #収入の削除
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
