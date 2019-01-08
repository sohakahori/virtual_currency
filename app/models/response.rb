class Response < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :body, presence: true,
            length: { maximum: 50 }

  # スコープ
  scope :search_body, -> (q) { where("body like ?", "%#{q}%") }
  scope :search_id, -> (q) { where(id: q) }
  scope :order_created_at, -> (q) { order(created_at: "#{q}") }
end
