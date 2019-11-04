class Stock < ApplicationRecord
    belongs_to :product
    validates :quantity, presence: true,
        numericality: {
            allow_blank: false,
            greater_than: 0,
            only_integer: true
        }

    def validate_qty(inOutFlg, qty, originalQty)
        logger.debug("エラーチェックに入りました")
        if qty == 0
            errors.add(:qty, "が入力されていません")
        end
        
        #出荷の場合
        if inOutFlg == "2"
            #欠品の発生
            if qty > originalQty
                errors.add(:shortage, "が発生しました")
            end
        end
    end
    
end
