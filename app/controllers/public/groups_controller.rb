class Public::GroupsController < ApplicationController
  before_action :authenticate_member!

  def show
    @group = Group.find(params[:id])
    @post = Post.new
  end

  def join
    @group = Group.find(params[:group_id])
    @group.members << current_member
    redirect_to group_path(@group)
  end

  def destroy
    #グループ退会
    @group = Group.find(params[:id])
    #current_userは、@group.usersから消されるという記述。
    @group.members.delete(current_member)
    redirect_to root_path
  end


end
