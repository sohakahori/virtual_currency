class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :first_name, presence: true
  validates :last_name, presence: true

  # スコープ
  scope :order_updated_at, -> { order("updated_at DESC") }
  scope :search_first_name, -> (q) { where("first_name LIKE ?", "%#{q}%") }
  scope :search_last_name, -> (q) { where("last_name LIKE ?", "%#{q}%") }
  scope :search_email, -> (q) { where("email LIKE ?", "%#{q}%") }
  scope :search_full_name, -> (q) { where("CONCAT_WS( ' ', last_name, first_name) LIKE ?", "%#{q}%") }
end
