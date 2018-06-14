class PicturesController < ApplicationController
  before_action :check_login, only: [:new, :confirm, :create, :favorites]
  def index
    @pictures = Picture.all
  end
  
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  
  def confirm 
    @picture = Picture.new(picture_params)
    render :new if @picture.invalid?
  end
  
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    
    if @picture.save
      #メール送信
      PictureMailer.picture_mail(@picture).deliver
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to pictures_path, notice: "投稿しました！"
    else
      render "new"
    end
  end
  
  def show 
    @picture = Picture.find(params[:id])
  end
  
  def edit
    @picture = Picture.find(params[:id]);
  end
  
  def update
    @picture = Picture.find(params[:id]);
    if @picture.update(picture_params)
      redirect_to pictures_path
    else
      render 'edit'
    end
    
  end
  
  def destroy 
    @picture = Picture.find(params[:id]);
    @picture.destroy
    redirect_to pictures_path
  end
  
  def favorites
    @favorites = Favorite.where(user_id: current_user.id)
  end
  
  
  private
  def picture_params
    params.require(:picture).permit(:content, :image, :image_cache)
  end
  def check_login
    if logged_in?
    else
      redirect_to new_session_path
    end
  end
end
