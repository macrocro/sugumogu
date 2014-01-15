# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :title_meta_ogp

  def title_meta_ogp
    @meta = {
      :site => 'すぐもぐ！',
      # :image => URI.join(root_url, view_context.image_path('camera.png')),
      :image => 'http://exp.cdn-hotels.com/hotels/7000000/6380000/6376200/6376125/6376125_65_z.jpg',
      :description => 'すぐに潜れる、ダイビングショップ検索サイト。すべての人にダイビングを！',
      :keywords => 'ダイビング, 体験ダイビング, スキューバダイビング',
      :top_canonical => 'http://sugumogu.com',
      :fb_app_id => '464182493683853',
      :fb_page_id => '1439216986304758'
    }
  end

  def not_found!
    # render "errors/not_found", layout: "errors", status: 404
    render "errors/not_found", layout: "application", status: 404
  end

end
