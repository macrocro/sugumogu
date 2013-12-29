class AddLicense < ActiveRecord::Migration
  def change
    add_column :shops, :license, :string, :after=>:mail
  end
end
