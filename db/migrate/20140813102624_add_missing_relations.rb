class AddMissingRelations < ActiveRecord::Migration
  def change
  	add_column :bases, :user_id, :integer
  	add_column :building_units, :base_id, :integer
  end
end
