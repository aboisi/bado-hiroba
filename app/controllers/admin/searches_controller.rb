class Admin::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    if @range == "Group"
      @groups = Group.looks(params[:search], params[:word])
    else
      @members = Member.looks(params[:search], params[:word])
    end
  end
end
