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
      redirect_to group_post_path(group_id: params[:group_id], id: @post.id)
    else
      redirect_to group_path(@group)
    end
  end

  def index
    @member = current_member
    @group = Group.find(params[:group_id])
    @posts = @group.posts.order(created_at: :desc)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @group_id = @post.group_id
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.member_id == current_member.id
      redirect_to request.referer
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to group_post_path(@post), notice: "編集しました。"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    #削除された投稿が所属していたグループのIDを取得
    @group_id = @post.group_id
    @post.destroy
    #リダイレクト先の分岐
    if request.referer == my_page_url
      redirect_to my_page_path
    else
      redirect_to group_posts_path(@group_id)
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
