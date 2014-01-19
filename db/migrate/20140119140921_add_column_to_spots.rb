class AddColumnToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :spot, :string, :after => :area

  end
end
