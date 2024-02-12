class Public::GroupsController < ApplicationController
  
  def new
    # @group = Group.new
  end 
  
  def index
    # @groups = Group.all
  end 
  
  def show
    # @group = Group.find(params[:id])
  end
  
  def edit 
  end
  
  private
  
  # def group_params
  #   params.require(:group).permit(:name, :region_id, :address, :telephone_number, :introduction, :group_image)
  # end
end
