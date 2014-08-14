class CreateBuildingUnits < ActiveRecord::Migration
  def change
    create_table :building_units do |t|
    	t.integer :type_id
    	t.integer :level
      t.time :finish_building
      t.integer :base_id
      t.timestamps
    end
  end
end
