class Admin::GroupsController < ApplicationController
  def new
     @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to admin_group_path(@group.id)
    else
      render :new
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :region_id, :address, :telephone_number, :introduction, :group_image)
  end
end
