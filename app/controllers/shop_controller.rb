# -*- coding: utf-8 -*-
class ShopController < ApplicationController

  before_action :breadcrumb
  layout 'shop'

  def breadcrumb
    add_breadcrumb 'すぐもぐ', '/'
  end

  def pref
    @locations = Location.where('pref = ?', params[:pref])

    add_breadcrumb @locations[0].ja_pref
  end

  def city
    @shop = Shop.where('pref = ? and city = ?', params[:pref], params[:city])

    add_breadcrumb @shop[0].ja_pref, shop_pref_path(params[:pref])
    add_breadcrumb @shop[0].ja_city
  end

  def data
    @shop = Shop.find_by_id data_params[:id]
    @pref_shops = Shop.where('pref = ? and city = ?', data_params[:pref], data_params[:city])

    return not_found! unless @shop && @pref_shops.present?

    # shop_idのpref,cityにURLをあわせるようredirect
    if !(@shop[:pref] == data_params[:pref] && @shop[:city] == data_params[:city].to_i)
      return redirect_to shop_data_path(@shop[:pref], @shop[:city], @shop[:id])
    end

    add_breadcrumb @shop.ja_pref, shop_pref_path(params[:pref])
    add_breadcrumb @shop.ja_city, shop_city_path(params[:pref], params[:city])
    add_breadcrumb @shop.name
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def data_params
    params.permit(:pref, :city, :id)
  end

end
