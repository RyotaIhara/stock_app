class SessionsController < ApplicationController
    def new
    end

    def create
        logger.debug("作成処理に入りました")
        @user = User.find_by(name: params[:name])
        if @user && @user.authenticate(params[:password])
            logger.debug("パスワードが一致しました")
            session[:user_id] = @user.id
            redirect_to controller: 'stocks', action: 'index'
        else
            logger.debug("エラーです")
            flash.alert = "名前とパスワードが一致しません"
            render :new
        end
        logger.debug("最終処理にきました")
    end

    def destroy
        session.delete(:user_id)
        redirect_to :root
    end

    def logout
        session[:user_id] = nil
        redirect_to :root
    end
end
