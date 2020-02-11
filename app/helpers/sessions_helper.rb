module SessionsHelper
    def current_user #ログインしたユーザのIDを取得する
        @current_user ||= User.find_by(id: session[:user_id])
    end 
    
    def logged_in? #ログインしているか確認する
        !!current_user
    end
end
