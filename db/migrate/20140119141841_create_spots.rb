class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :area
      t.string :pref
      t.string :ja_area
      t.string :ja_pref
      t.string :name
      t.string :dievnet
      t.string :oceana

      t.timestamps
    end
  end
end
