class StocksController < ApplicationController
    def index
        @stocks = Stock.all
    end

    def show
        @stock = Stock.find(params[:id])
    end

    #新規作成フォーム
    def new
        @stock = Stock.new
    end

    def create
        @stock = Stock.new(stock_params)
        if @stock.save
            redirect_to :stocks, notice: "在庫を新規登録しました"
        else
            render "new"
        end
    end

    #削除
    def destroy
        @stock = Stock.find(params[:id])
        @stock.destroy
        redirect_to :stocks, notice: "会員の削除しました。"
    end

    #ストロングパラメーター
    private def stock_params
        params.require(:stock).permit(
            :quantity,
            :product_id
        )
    end
end