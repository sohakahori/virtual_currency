class Board < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :responses, dependent: :destroy

  accepts_nested_attributes_for :responses

  validates :title, presence: true,
            length: { maximum: 20 }

  # スコープ
  scope :search_title, -> (q) { where("title like ?", "%#{q}%") }

end
