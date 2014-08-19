class AddColumnToBuildingType < ActiveRecord::Migration
  def change
    add_column :building_types, :unique, :boolean
  end
end
