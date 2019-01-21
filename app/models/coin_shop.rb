class CoinShop < ApplicationRecord
  belongs_to :coin
  belongs_to :shop
end
