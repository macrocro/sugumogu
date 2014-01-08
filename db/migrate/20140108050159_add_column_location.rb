class AddColumnLocation < ActiveRecord::Migration
  def change
    add_column :locations, :ja_pref, :string, :after => :city
    add_column :locations, :ja_city, :string, :after => :ja_pref
  end
end
