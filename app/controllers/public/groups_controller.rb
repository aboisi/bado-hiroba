class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @group = Group.find(params[:id])
  end
  
  def join
    @group = Group.find(params[:group_id])
    @group.members << current_user
    redirect_to group_path(@group)
  end
  
  def destroy
    #グループ退会
    @group = Group.find(params[:id])
    #current_userは、@group.usersから消されるという記述。
    @group.members.delete(current_user)
    redirect_to root_path
  end

  
end
