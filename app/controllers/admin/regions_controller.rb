class Admin::RegionsController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    #データを受け取り新規登録するためのインスタンス作成
    region = Region.new(region_params)
    #データをデータベースに保持するためのsaveメソッド実行
    region.save
    redirect_to admin_regions_path
  end
  
  def index
    @region = Region.new
    @regions = Region.all
  end

  def edit
  end
  
  private
  
  def region_params
    params.require(:region).permit(:name)
  end
end
