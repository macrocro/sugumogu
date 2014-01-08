class ChangeCityColumnToInt < ActiveRecord::Migration
  def change
    change_column :locations, :city, :integer
    change_column :shops, :city, :integer
  end
end
