class Coin < ApplicationRecord

  # アソシエーション
  has_many :coin_shops, dependent: :destroy
  has_many :shops, through: :coin_shops

  # バリデーション
  validates :name, uniqueness: true
  validates :coin_market_cap_id, uniqueness: true
  validates :symbol, uniqueness: true
  validates :rank,
            uniqueness: true,
            :numericality => { :only_integer => true }


  # スコープ
  scope :order_market_rank, -> { order("rank ASC") }
  scope :coin_ids, ->(ids) { where(id: ids) }
end
