class AddColumnBuildingsUnits < ActiveRecord::Migration
  def change
    add_column :building_units, :type, :string
  end
end
