class Public::PostsController < ApplicationController
  
  def create
  end
  
  def index
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def show
  end

  def edit
  end
end
