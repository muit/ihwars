class UpdateStructure < ActiveRecord::Migration
  def change
  	add_column :buildingStack, :level, :integer

  end
end
