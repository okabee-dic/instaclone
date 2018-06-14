class FavoritesController < ApplicationController
  def create
    pic_id = params[:picture_id]
    favorite = current_user.favorites.create(picture_id: pic_id)
    if params[:from_show] != "true"
      redirect_to pictures_url #, notice: "#{favorite.picture.user.name}さんのブログをお気に入り登録しました"
    else
      redirect_to picture_path(pic_id)
    end
  end
  
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    pic_id = favorite.picture.id
    if params[:from_show] != "true"
      redirect_to pictures_url #, notice: "#{favorite.picture.user.name}さんのブログをお気に入り解除しました"
    else
      redirect_to picture_path(pic_id)
    end
  end
end



