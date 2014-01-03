class ShopController < ApplicationController
  def index
    if params[:pref].present?
      @shop = Shop.where('pref = ?',params[:pref]).select('id,name')
    else
      @shop = Shop.all.select('id,name')
    end
  end

  def detail
    @shop = Shop.find_by_id params[:id]
  end

  def data
    @shop = Shop.find_by_id params[:id]
  end
end
