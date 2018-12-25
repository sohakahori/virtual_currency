class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 論理削除
  acts_as_paranoid


  # バリデーション
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true

  # スコープ
  scope :search_first_name, -> (q) { where("first_name like ?", "%#{q}%") }
  scope :search_last_name, -> (q) { where("last_name like ?", "%#{q}%") }
  scope :search_nickname, -> (q) { where("nickname like ?", "%#{q}%") }
  scope :search_full_name, -> (q) { where("CONCAT_WS(' ', last_name, first_name) like ?", "%#{q}%") }
  scope :search_email, -> (q) { where("email like ?", "%#{q}%") }
end
