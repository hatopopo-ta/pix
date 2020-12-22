class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
end
