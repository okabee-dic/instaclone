class User < ApplicationRecord
  has_secure_password
  
  with_options if: :password do |user|
    user.validates :password, 
      on: :create,
      presence: { message: "パスワードを入力して下さい" },
      length: { minimum: 6 },
      confirmation: { allow_blank: true } 
    user.validates :password, 
      on: :update,
      presence: { message: "新しいパスワードを入力して下さい" },
      length: { minimum: 6 },
      confirmation: { allow_blank: true }
  end
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture
  
  has_many :pictures
end
