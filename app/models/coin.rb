class Coin < ApplicationRecord

  # アソシエーション
  has_many :coin_shops, dependent: :destroy
  has_many :shops, through: :coin_shops

  # バリデーション
  validates :name, uniqueness: true
  validates :market_rank,
            uniqueness: true,
            :numericality => { :only_integer => true }


  # スコープ
  scope :order_market_rank, -> { order("market_rank ASC") }
end
