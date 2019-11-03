class Product < ApplicationRecord
    validates :productName, presence: true, uniqueness: true
    validates :price, presence: true
end
