class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
       redirect_to admin_member_path(@member)
    else
      render :edit
    end
  end
  
  private
  
  def member_params
    params.require(:member).permit(:lastname, :first_name, :display_name, :email, :is_active)
  end
end
