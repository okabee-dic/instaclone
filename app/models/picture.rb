class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  belongs_to :user, optional: true
  
  validates :content, presence: true
  validates :image, presence: true
end
