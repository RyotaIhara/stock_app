class MembersController < ApplicationController
    def index
        @members = Member.all
    end

    def show
        @member = Member.find(params[:id])
    end

    def new
        @member = Member.new
    end

    def edit
        @member = Member.find(params[:id])
    end

    def create
        @member = Member.new(member_params)
        if @member.save
            redirect_to :members, notice: "会員を新規登録しました"
        else
            render "new"
        end
    end

    def update
        @member = Member.find(params[:id])
        @member.assign_attributes(member_params)
        if @member.save
            redirect_to @member, notice: "会員を更新しました"
        else
            render "edit"
        end
    end

    def destroy
        @member = Member.find(params[:id])
        @member.destroy
        redirect_to :members, notice: "会員を削除しました。"
    end

    #ストロングパラメーター
    private def member_params
        params.require(:member).permit(
            :name,
            :email,
            :password_digest,
            :administrator
        )
    end
end
