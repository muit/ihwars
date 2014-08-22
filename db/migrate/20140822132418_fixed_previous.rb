class FixedPrevious < ActiveRecord::Migration
  def change
  	remove_column :building_units, :description
  	remove_column :entity_stacks, :description
  	add_column :building_types, :description, :text
  	add_column :entity_types, :description, :text
  end
end
