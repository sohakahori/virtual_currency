class Board < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :responses, dependent: :destroy
end
