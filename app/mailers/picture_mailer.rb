class PictureMailer < ApplicationMailer
  def picture_mail(pic)
    @picture = pic
    mail to: @picture.user.email, subject: "[instaclone] 画像を投稿しました。"
  end
end
