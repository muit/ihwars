class Descriptions < ActiveRecord::Migration
  def change
  	add_column :building_units, :description, :text
  	add_column :entity_stacks, :description, :text
  end
end
