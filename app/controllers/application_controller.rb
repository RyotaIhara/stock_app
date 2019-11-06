class ApplicationController < ActionController::Base

    def hello
        render html: "hello,world!"
    end

    private def current_user
        User.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def login_required
        unless User.find_by_id(session[:user_id])
          redirect_to :new_session, notice: "ログインして下さい。"
        end
    end

    def administrator_required
        logger.debug("エラーメソッドを通りました")
        unless User.find_by_id(session[:user_id])
            redirect_to :new_session, notice: "ログインして下さい。"
        else
            @user = User.find_by_id(session[:user_id])
            unless @user.administrator
                logger.debug("false処理を通りました")
                redirect_to :users, notice: "管理者以外実行できません。"
            end
        end
    end
end