class CreateBuildingUnits < ActiveRecord::Migration
  def change
    create_table :building_units do |t|
    	t.integer :type_id
    	t.integer :level

      t.timestamps
    end
  end
end
