class AddJaPrefAndJaCityToShop < ActiveRecord::Migration
  def change
    add_column :shops, :ja_pref, :string, :after => :city
    add_column :shops, :ja_city, :string, :after => :ja_pref
  end
end
