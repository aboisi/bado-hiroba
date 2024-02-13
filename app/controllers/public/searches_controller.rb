class Public::SearchesController < ApplicationController

  def search_region
    @region = Region.find(params[:id])
    @groups = Group.where(region_id: @region.id)
  end
end
