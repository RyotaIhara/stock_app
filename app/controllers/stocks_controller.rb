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
        @inOutFlg = params.require(:stock)["inOutFlg"]
        @qty = params.require(:stock)["quantity"].to_i

        #在庫の存在チェック
        if Stock.exists?(product_id: params.require(:stock)["product_id"])
            logger.debug("条件OKです")
            @stock = Stock.find_by(product_id: params.require(:stock)["product_id"])
            #@qty = params.require(:stock)["quantity"])
            #入荷の場合
            if "1" == @inOutFlg
                logger.debug("増える処理に入りました")
                @stock.increment(:quantity, @qty)
                if @stock.save
                    redirect_to :stocks, notice: "在庫を新規登録しました"
                else
                    render "new"
                end
            #出荷の場合
            else
                logger.debug("減る処理に入りました")
                @stock.decrement(:quantity, @qty)
                if @stock.save
                    redirect_to :stocks, notice: "在庫を新規登録しました"
                else
                    render "new"
                end
            end
        else
            logger.debug("条件OUTです")
            #入荷の場合新規作成
            if "1" == @inOutFlg
                @stock = Stock.new(stock_params)
                if @stock.save
                    redirect_to :stocks, notice: "在庫を新規登録しました"
                else
                    render "new"
                end
            #出荷のため在庫が存在しませんのエラーが返す
            else
            end
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