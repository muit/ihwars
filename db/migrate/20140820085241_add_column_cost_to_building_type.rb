class AddColumnCostToBuildingType < ActiveRecord::Migration
  def change
    add_column :building_types, :cost, :integer
  end
end
