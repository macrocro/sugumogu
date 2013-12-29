# -*- coding: utf-8 -*-
namespace :shop do
  desc "TODO"
  task pref_and_city: :environment do
    shops = Shop.all.select('id,name,address')

    shops.each do |shop|
      address = shop.address
      /^((.*?(府|県|東京都|道)))/ =~ address
      shop.pref =  "#{$1}"
      shop.save
    end
  end
end
