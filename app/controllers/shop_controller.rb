# -*- coding: utf-8 -*-
class ShopController < ApplicationController

  before_action :breadcrumb

  def breadcrumb
    add_breadcrumb 'すぐもぐ', root_url
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
    @shop = Shop.find_by_id params[:id]

    add_breadcrumb @shop.ja_pref, shop_pref_path(params[:pref])
    add_breadcrumb @shop.ja_city, shop_city_path(params[:pref], params[:city])
    add_breadcrumb @shop.name
  end

end
