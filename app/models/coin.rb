class Coin < ApplicationRecord

  # バリデーション
  validates :name, uniqueness: true
  validates :market_rank,
            uniqueness: true,
            :numericality => { :only_integer => true }
end
