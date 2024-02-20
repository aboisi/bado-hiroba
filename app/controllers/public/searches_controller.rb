class Public::SearchesController < ApplicationController

  def search_region
    @region = Region.find(params[:id])
    @groups = Group.where(region_id: @region.id)
  end

  def search
    @range = params[:range]
    if @range == "Group"
      @groups = Group.looks(params[:search], params[:word])
    end
  end
end
