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
      redirect_to action: :index
    else
      render "groups/show"
    end
  end
  
  def index
    @group = Group.find(params[:group_id])
    @posts = @group.posts
  end

  def show
  end

  def edit
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body)
  end
end
