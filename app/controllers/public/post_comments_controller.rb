class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!

  def create
    post = Post.find(params[:post_id])
    @comment = current_member.post_comments.new(post_comment_params)
    @comment.post_id = post.id
    @comment.save
    @post_comment = PostComment.new
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
