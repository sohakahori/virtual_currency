class Shop < ApplicationRecord

  # アソシエーション
  has_many :coin_shops, dependent: :destroy
  has_many :coins, through: :coin_shops

  validates :name, presence: true
  validates :address, presence: true
  validates :company, presence: true
  # validates :coin_shops, presence: true
  #

  # スコープ
  scope :search_name, -> (q) { where("name like ?", "%#{q}%") }
  scope :search_address, -> (q) { where("address like ?", "%#{q}%") }
  scope :search_company, -> (q) { where("company like ?", "%#{q}%") }
end
