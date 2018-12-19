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
  scope :search_name, -> (q) { where("#{self.table_name}.name like ?", "%#{q}%") }
  scope :search_address, -> (q) { where("#{self.table_name}.address like ?", "%#{q}%") }
  scope :search_company, -> (q) { where("#{self.table_name}.company like ?", "%#{q}%") }



end
