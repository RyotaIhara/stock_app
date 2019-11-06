class ApplicationController < ActionController::Base

    def hello
        render html: "hello,world!"
    end

    private def current_user
        User.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    private def getAdministrator
        @user = User.find_by(id: session[:user_id]) if session[:user_id]
        return @user.administrator
    end
    helper_method :getAdministrator

    def login_required
        unless User.find_by_id(session[:user_id])
          redirect_to :new_session, notice: "ログインして下さい。"
        end
    end

    def administrator_required
        unless User.find_by_id(session[:user_id])
            redirect_to :new_session, notice: "ログインして下さい。"
        else
            @user = User.find_by_id(session[:user_id])
            unless @user.administrator
                redirect_to :users, notice: "管理者以外実行できません。"
            end
        end
    end
end