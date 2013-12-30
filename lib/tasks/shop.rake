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

  task tel_to_tel: :environment do
    shops = Shop.all.select('id,pref')

    shops.each do |shop|
      shop.tel = shop.pref
      shop.pref = nil
      shop.save
    end
  end

  task set_padi: :environment do
    shops = Shop.all

    shops.each do |shop|
      shop.license = 'padi'
      shop.save
    end
  end
end
