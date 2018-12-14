class Shop < ApplicationRecord

  # アソシエーション
  has_many :coin_shops, dependent: :destroy
  has_many :coins, through: :coin_shops
end
