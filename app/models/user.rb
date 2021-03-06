class User < ApplicationRecord
            # Include default devise modules.
            devise :database_authenticatable, :registerable,
                    :recoverable, :rememberable, :validatable
                    # :confirmable, :omniauthable
            include DeviseTokenAuth::Concerns::User


  # 論理削除
  acts_as_paranoid

  # アソシエーション
  has_many :boards, dependent: :destroy
  has_many :responses, dependent: :destroy


  # バリデーション
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true

  # スコープ
  scope :search_first_name, -> (q) { where("first_name like ?", "%#{q}%") }
  scope :search_last_name, -> (q) { where("last_name like ?", "%#{q}%") }
  scope :search_nickname, -> (q) { where("nickname like ?", "%#{q}%") }
  scope :search_full_name, -> (q) { where("CONCAT_WS(' ', last_name, first_name) like ?", "%#{q}%") }
  scope :search_no_space_full_name, -> (q) { where("CONCAT(last_name, first_name) like ?", "%#{q}%") }
  scope :search_email, -> (q) { where("email like ?", "%#{q}%") }
  scope :search_id, -> (q) { where(id: q) }
end
