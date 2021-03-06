module SessionsHelper
    # helper methods aren't available in tests
    def log_in(user)
        session[:user_id] = user.id
    end

    # 返回当前登录的用户(如果有的话)
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end