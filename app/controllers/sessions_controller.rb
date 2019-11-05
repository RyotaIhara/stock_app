class SessionsController < ApplicationController
    def new
    end

    def create
        logger.debug("作成処理に入りました")
        @member = Member.find_by(name: params[:name])
        if @member && @member.authenticate(params[:password])
            logger.debug("パスワードが一致しました")
            session[:member_id] = @member.id
            redirect_to :root
        else
            logger.debug("エラーです")
            flash.alert = "名前とパスワードが一致しません"
            render :new
        end
        logger.debug("最終処理にきました")
    end

    def destroy
        session.delete(:member_id)
        redirect_to :root
    end
end
