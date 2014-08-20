class AddColumnCostToEntityType < ActiveRecord::Migration
  def change
    add_column :entity_types, :cost, :integer
  end
end
