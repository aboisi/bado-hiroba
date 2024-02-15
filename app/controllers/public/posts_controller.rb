class Public::PostsController < ApplicationController
  before_action :authenticate_member!

  def create
    @group = Group.find(params[:group_id])
    #取得したグループに関連づいた新し投稿を作成
    @post = @group.posts.new(post_params)
    #投稿にユーザー情報を紐付け
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = "投稿しました。"
      redirect_to group_post_path(group_id: params[:group_id], id: @post)
    else
      render "groups/show"
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @posts = @group.posts
  end

  def show
    @post = Post.find(params[:id])
    @group_id = @post.group_id
  end

  def edit
  end
  
  def update
  end
  
  def destroy
    @post = Post.find(params[:id])
    #削除された投稿が所属していたグループのIDを取得
    @group_id = @post.group_id
    @post.destroy
    redirect_to group_posts_path(@group_id)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
