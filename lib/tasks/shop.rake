# -*- coding: utf-8 -*-
namespace :shop do
  desc "TODO"
  task pref_and_city: :environment do

    hash = ["北海道"=>"hokkaido",
            "青森県"=>"aomori",
            "岩手県"=>"iwate",
            "宮城県"=>"miyagi",
            "秋田県"=>"akita",
            "山形県"=>"yamagata",
            "福島県"=>"hukushima",
            "茨城県"=>"ibaraki",
            "栃木県"=>"tochigi",
            "群馬県"=>"gunma",
            "埼玉県"=>"saitama",
            "千葉県"=>"chiba",
            "東京都"=>"tokyo",
            "神奈川県"=>"kanagawa",
            "新潟県"=>"nigata",
            "富山県"=>"toyama",
            "石川県"=>"ishikawa",
            "福井県"=>"hukui",
            "山梨県"=>"yamanashi",
            "長野県"=>"nagano",
            "岐阜県"=>"gihu",
            "静岡県"=>"shizuoka",
            "愛知県"=>"aichi",
            "三重県"=>"mie",
            "滋賀県"=>"shiga",
            "京都府"=>"kyoto",
            "大阪府"=>"osaka",
            "兵庫県"=>"hyogo",
            "奈良県"=>"nara",
            "和歌山県"=>"wakayama",
            "鳥取県"=>"tottori",
            "島根県"=>"shimane",
            "岡山県"=>"okayama",
            "広島県"=>"hiroshima",
            "山口県"=>"yamaguchi",
            "徳島県"=>"hukushima",
            "香川県"=>"kagawa",
            "愛媛県"=>"ehime",
            "高知県"=>"kouchi",
            "福岡県"=>"hukuoka",
            "佐賀県"=>"saga",
            "長崎県"=>"nagasaki",
            "熊本県"=>"kumamoto",
            "大分県"=>"oita",
            "宮崎県"=>"miyazaki",
            "鹿児島県"=>"kagoshima",
            "沖縄県"=>"okinawa"]

    shops = Shop.all.select('id,address,pref').limit(10)

    shops.each do |shop|
      address = shop.address
      /^((.*?(府|県|東京都|道)))/ =~ address

      if "#{$1}".blank?
        next
      end

      # hash.each{ |key,value|
      #   if key == "#{$1}"
      #     shop.pref = value
      #   end
      # }

      pref_hash = hash.select { |k, v| k == "#{$1}" }

      binding.pry

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
