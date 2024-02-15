class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @group_id = @post.group.id
    favorite = current_member.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @group_id = @post.group.id
    favorite = current_member.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end
