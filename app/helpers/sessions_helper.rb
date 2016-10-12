module SessionsHelper
    # helper methods aren't available in tests
    def log_in(user)
        session[:user_id] = user.id
        # 在用户的浏览器中创建一个临时 session
    end

    # 在持久会话 cookie 中记住用户
    def remember(user)
        user.remember   # 把 remember_digest 保存到数据库
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # 返回 cookie 中记忆令牌对应的用户
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def logged_in?
        !current_user.nil?
    end

    # 退出当前用户
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
end