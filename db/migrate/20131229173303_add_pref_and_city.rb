class AddPrefAndCity < ActiveRecord::Migration
  def change
    add_column :shops, :pref, :string, :after => :address
    add_column :shops, :city, :string, :after => :pref
  end
end
