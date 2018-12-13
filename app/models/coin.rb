class Coin < ApplicationRecord

  # バリデーション
  validates :name, uniqueness: true
  validates :market_rank,
            uniqueness: true,
            :numericality => { :only_integer => true }


  # スコープ
  scope :order_market_rank, -> { order("market_rank ASC") }
end
