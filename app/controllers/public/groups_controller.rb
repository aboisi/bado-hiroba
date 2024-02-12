class Public::GroupsController < ApplicationController
   before_action :authenticate_admin!
  
  def new
  end 
  
  def create
  end
  
  def index
    @groups = Group.all
  end 
  
  def show
    @group = Group.find(params[:id])
  end
  
  def edit 
  end
end
