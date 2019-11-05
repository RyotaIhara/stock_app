class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to :users, notice: "会員を新規登録しました"
        else
            render "new"
        end
    end

    def update
        @user = User.find(params[:id])
        @user.assign_attributes(user_params)
        if @user.save
            redirect_to @user, notice: "会員を更新しました"
        else
            render "edit"
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to :users, notice: "会員を削除しました。"
    end

    #ストロングパラメーター
    private def user_params
        params.require(:user).permit(
            :name,
            :email,
            :password,
            :administrator
        )
    end
end
