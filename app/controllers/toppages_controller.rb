class ToppagesController < ApplicationController
   before_action :require_user_logged_in, only: [:income] 
  
  #最初の画面
  #others = お小遣いやお年玉など
  def index
    if logged_in?
      
      #日付取得
      @d = Date.today

     
      
      #データ取得
      @user = current_user.name
      @goal = current_user.goal
      @incomes = current_user.incomes.all
      @expenses = current_user.lists.order("date DESC").page(params[:page]).per(5)
      
      #全ての合計支出
      @expense_total = current_user.lists.sum(:expense)
      
      #全ての合計収入(othersあり)
      @income_total_oth = current_user.incomes.sum(:income)
      @result = @income_total_oth - @expense_total
      
      #年月日の合計値
      @expense_day = 0
      @expense_month = 0
      @expense_year = 0
      @income_year = 0
      @expense_count_now = 0
      
      @expenses.each do |expense|
        
        #今年の登録数
        @expense_count_now += 1 if expense.date.year == @d.year
        
        #今日の合計支出
        @expense_day += expense.expense if expense.date == @d
          
        #今月の合計支出
        @expense_month += expense.expense if expense.date.month == @d.month && expense.date.year == @d.year
        
        #今年の合計支出
        @expense_year += expense.expense if expense.date.year == @d.year
          
      end
      
      #平均支出
      @expense_average_now = 0
      @expense_average_now = (@expense_year / @expense_count_now).to_s(:delimited) unless @expense_count_now == 0
      
      @income_total = 0
      @income_year = 0
      @income_year_oth = 0
      @income_count_oth = 0
      @income_count = 0
      
      @incomes.each do |income|
        
        #全ての合計収入(othersなし) <-> income_total_oth
        @income_total += income.income unless income.source == "others"
        
        #今年の合計収入(othersあり)
        @income_year_oth += income.income if income.date.year == @d.year
        
        #今年の合計収入(othersなし)
        @income_year += income.income if income.date.year == @d.year && income.source != "others"
        
        
        #登録数(othersあり)
        @income_count_oth += 1
      
        #登録数(othersなし)
        @income_count += 1 unless income.source == "others"
        
      end
      
      #今年の合計収支(othersあり)
      @result_now_oth = (@income_year_oth - @expense_year).to_s(:delimited)
      
      #今年の合計収支(othersなし)
      @result_now = (@income_year - @expense_year).to_s(:delimited)
      
      #費用全体の平均支出(小数点切り捨て)
      @expense_count = @expenses.count
      
      #unless文は割り算のエラー回避に使用
      #全平均支出
      @all_expense_average = 0
      @all_expense_average = (@expense_total / @expense_count).to_s(:delimited) unless @expense_count == 0
      
      #全平均収入(othersあり)
      @all_income_average_oth = 0
      @all_income_average_oth = (@income_total_oth / @income_count_oth).to_s(:delimited) unless @income_count_oth == 0
     
      #全平均収入(othersなし)
      @all_income_average = 0
      @all_income_average = (@income_total / @income_count).to_s(:delimited) unless @income_count == 0
      
      #カンマを入れる -> 100,000
      @expense_str = @expense_total.to_s(:delimited)
      @income_total_str = @income_total.to_s(:delimited)
      @income_total_oth_str = @income_total_oth.to_s(:delimited)
      @total = @result.to_s(:delimited) #カンマを入れる -> 100,000
      @income_year_oth_str = @income_year_oth.to_s(:delimited)
      @income_year_str = @income_year.to_s(:delimited)
      @expense_year_str = @expense_year.to_s(:delimited)
    end
  end
  
  def income 

      #日付取得
      @d = Date.today
    
      #データ取得
      @user = current_user.name
      @goal = current_user.goal
      @incomes = current_user.incomes.order("date DESC").page(params[:page]).per(5)
      @expenses = current_user.lists.all
      
      
      #全ての合計支出
      @expense_total = current_user.lists.sum(:expense)
      
      #全ての合計収入(othersあり)
      @income_total_oth = current_user.incomes.sum(:income)
      
      #合計収支(othersあり)
      @result = @income_total_oth - @expense_total
      
      #年月日の合計値
      @expense_day = 0
      @expense_month = 0
      @expense_year = 0
      @income_year = 0
      @expense_count_now = 0
      
      @expenses.each do |expense|
        
        #今年の登録数
        @expense_count_now += 1 if expense.date.year == @d.year
        
        #今日の合計支出
        @expense_day += expense.expense if expense.date == @d
          
        #今月の合計支出
        @expense_month += expense.expense if expense.date.month == @d.month && expense.date.year == @d.year
        
        #今年の合計支出
        @expense_year += expense.expense if expense.date.year == @d.year
          
      end
      
      #平均支出
      @expense_average_now = 0
      @expense_average_now = (@expense_year / @expense_count_now).to_s(:delimited) unless @expense_count_now == 0
      
      @income_total = 0
      @income_year = 0
      @income_year_oth = 0
      @income_count_oth = 0
      @income_count = 0
      @incomes.each do |income|
        
        #全ての合計収入(othersなし) <-> income_total_oth
        @income_total += income.income unless income.source == "others"
        
        #今年の合計収入(othersあり)
        @income_year_oth += income.income if income.date.year == @d.year
        
        #今年の合計収入(othersなし)
        @income_year += income.income if income.date.year == @d.year && income.source != "others"
        
        
        #登録数(othersあり)
        @income_count_oth += 1
      
        #登録数(othersなし)
        @income_count += 1 unless income.source == "others"
        
      end
      
      
      #今年の合計収支(othersあり)
      @result_now_oth = (@income_year_oth - @expense_year).to_s(:delimited)
      
      #今年の合計収支(othersなし)
      @result_now = (@income_year - @expense_year).to_s(:delimited)
      
      #費用全体の平均支出(小数点切り捨て)
      @expense_count = @expenses.count
      
      #unless文は割り算のエラー回避に使用
      #全平均支出
      @all_expense_average = 0
      @all_expense_average = (@expense_total / @expense_count).to_s(:delimited) unless @expense_count == 0
      
      #全平均収入(othersあり)
      @all_income_average_oth = 0
      @all_income_average_oth = (@income_total_oth / @income_count_oth).to_s(:delimited) unless @income_count_oth == 0
     
      #全平均収入(othersなし)
      @all_income_average = 0
      @all_income_average = (@income_total / @income_count).to_s(:delimited) unless @income_count == 0
      
      #カンマを入れる -> 100,000
      @expense_str = @expense_total.to_s(:delimited)
      @income_total_str = @income_total.to_s(:delimited)
      @income_total_oth_str = @income_total_oth.to_s(:delimited)
      @total = @result.to_s(:delimited) #カンマを入れる -> 100,000
      @income_year_oth_str = @income_year_oth.to_s(:delimited)
      @income_year_str = @income_year.to_s(:delimited)
      @expense_year_str = @expense_year.to_s(:delimited)
  end
  
end
