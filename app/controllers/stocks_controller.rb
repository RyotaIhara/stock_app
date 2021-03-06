class StocksController < ApplicationController
    before_action :login_required

    def index
        @stocks = Stock.all
    end

    def show
        @stock = Stock.find(params[:id])
    end

    #新規作成フォーム
    def new
        @stock = Stock.new
        @errors = Array.new
    end

    def create
        @inOutFlg = params.require(:stock)["inOutFlg"]
        @qty = params.require(:stock)["quantity"].to_i

        #在庫の存在チェック
        if Stock.exists?(product_id: params.require(:stock)["product_id"])
            logger.debug("条件OKです")
            @stock = Stock.find_by(product_id: params.require(:stock)["product_id"])         
            @stock.validate_qty(@inOutFlg, @qty, @stock.quantity.to_i)
            if @stock.errors.count > 0
                logger.debug("エラーがあります")
                @errors = @stock.errors.full_messages
                logger.debug(@errors)
                @stock = Stock.new
                render "new"
            else
                #入荷の場合
                if "1" == @inOutFlg
                    logger.debug("増える処理に入りました")
                    @stock.increment(:quantity, @qty)
                    if @stock.save
                        redirect_to :stocks, notice: "入荷が完了しました"
                    else
                        render "new"
                    end
                #出荷の場合
                else
                    logger.debug("減る処理に入りました")
                    @stock.decrement(:quantity, @qty)
                    if @stock.save
                        redirect_to :stocks, notice: "出荷が完了しました"
                    else
                        render "new"
                    end
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
                @stock = Stock.new
                @stock.errors.add(:shortage, "が発生しました")
                @errors = Array.new
                render "new"
            end
        end
    end

    def edit
        @stock = Stock.find(params[:id])
    end

    def update
        @stock = Stock.find(params[:id])
        @stock.assign_attributes(stock_params)
        if @stock.save
            redirect_to @stock, notice: "在庫を更新しました"
        else
            render "edit"
        end
    end

    #削除
    def destroy
        @stock = Stock.find(params[:id])
        @stock.destroy
        redirect_to :stocks, notice: "在庫を削除しました。"
    end

    #管理画面
    def dashBord
        stock = Stock.pluck(:product_id, :quantity)
        @stock = Hash[*stock.flatten]
        logger.debug(@stock)
        @stocks = Stock.all
        @hash = {}
        @stocks.each do |stock|
            @hash.store(stock.product.productName, stock.quantity)
        end 
    end

    #ストロングパラメーター
    private def stock_params
        params.require(:stock).permit(
            :quantity,
            :product_id
        )
    end
end