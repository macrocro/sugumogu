class ShopController < ApplicationController

  def pref
    @locations = Location.where('pref = ?', params[:pref])
  end

  def city
    @shop = Shop.where('pref = ? and city = ?', params[:pref], params[:city])
  end

  def data
    @shop = Shop.find_by pref: params[:pref]
  end

end
