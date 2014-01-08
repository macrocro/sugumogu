# -*- coding: utf-8 -*-
namespace :shop do
  desc "set Shops.pref from ja-Address ex. Shops.pref = hokkaido"
  task pref_and_city: :environment do

    hash = ["北海道"=>"hokkaido",
            "青森県"=>"aomori",
            "岩手県"=>"iwate",
            "宮城県"=>"miyagi",
            "秋田県"=>"akita",
            "山形県"=>"yamagata",
            "福島県"=>"fukushima",
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
            "福井県"=>"fukui",
            "山梨県"=>"yamanashi",
            "長野県"=>"nagano",
            "岐阜県"=>"gifu",
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
            "徳島県"=>"fukushima",
            "香川県"=>"kagawa",
            "愛媛県"=>"ehime",
            "高知県"=>"kouchi",
            "福岡県"=>"fukuoka",
            "佐賀県"=>"saga",
            "長崎県"=>"nagasaki",
            "熊本県"=>"kumamoto",
            "大分県"=>"oita",
            "宮崎県"=>"miyazaki",
            "鹿児島県"=>"kagoshima",
            "沖縄県"=>"okinawa"]

    n = 0
    while true do
      shops = Shop.all.select('id,address,pref').limit(100).offset(100*n)
      break if shops.blank?

      shops.each do |shop|
        p shop.id
        address = shop.address
        /^((.*?(府|県|東京都|道)))/ =~ address

        if "#{$1}".blank?
          p "ERROR: id: #{shop.id}, address: #{shop.address}"
          next
        end

        pref_hash = hash[0].select { |k, v| k == "#{$1}" }

        shop.pref = pref_hash.values[0]
        shop.ja_pref = "#{$1}"

        shop.save
      end

      n = n + 1;
    end
  end

  desc "not in use"
  task tel_to_tel: :environment do
    shops = Shop.all.select('id,pref')

    shops.each do |shop|
      shop.tel = shop.pref
      shop.pref = nil
      # shop.save
    end
  end

  desc "alart!!! this task set all shop PADI!wwww"
  task set_padi: :environment do
    shops = Shop.all

    shops.each do |shop|
      shop.license = 'padi'
      # shop.save
    end
  end

  # 正規表現でだいぶ選べるようになったけど、ぼちぼち外してるのがcityの方であるから手作業Checkは必要
  desc "set location table from shop.address analyzed"
  task set_location: :environment do
    shops = Shop.all

    shops.each do |shop|
      /^(東京都|大阪府|京都府|.+?県|.+?道)(三宅島|八丈島|大島町|小笠原村父島|小笠原村母島|.+?市|.+?郡|.+?区|.+?村|.+?島|.+?町)/ =~ shop.address
      # p "#{$1} / #{$2}  /// #{shop.address}"

      shop.city = nil
      shop.ja_city = "#{$2}"
      p shop.ja_city
      shop.save
    end
  end

  task set_location_pref: :environment do
    prefs_hash = Location.get_pref_hash

    # 全都道府県でeach
    prefs_hash[0].each{ |ja_pref, pref|
      shops = Shop.where("pref = ?", pref).select("id, name, pref, city, ja_pref, ja_city")

      # あるprefの中でcityに関して
      shops.each do |shop|
        location = Location.find_by ja_city: shop.ja_city
        # ja_cityで登録されていないならば保存してエリア番号をつける
        if location.blank?

          # 最新のエリア番号を取得する
          pref_location = Location.where("ja_pref = ?", shop.ja_pref).order("city DESC").limit(1)
          if pref_location.blank?
            city_no = 1
          else
            city_no = pref_location[0].city.to_i + 1
          end

          # 保存
          location = Location.new
          location.pref = shop.pref
          location.city = city_no
          location.ja_pref = shop.ja_pref
          location.ja_city = shop.ja_city

          p "pref: " + location.pref + " no: " + location.city.to_s
          location.save

          shop.city = location.city
          shop.save
        else
          shop.city = location.city
          shop.save
        end
      end
    }

    # pref_hash = prefs_hash[0].select { |k, v| k == "#{$1}" }

    # shop.pref = pref_hash.values[0]
    # shop.ja_pref = "#{$1}"
  end

end
