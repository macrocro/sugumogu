class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :url
      t.string :name
      t.string :zip_code
      t.string :address
      t.string :tel
      t.string :mail

      t.timestamps
    end
  end
end
