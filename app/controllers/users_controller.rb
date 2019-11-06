class UsersController < ApplicationController
    before_action :login_required, only: %i[index show]
    before_action :administrator_required, only: %i[edit update destroy]

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
            unless current_user
                session[:user_id] = @user.id
                redirect_to :stocks, notice: "ようこそ"
            else
                redirect_to :users, notice: "会員を新規登録しました"
            end
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
