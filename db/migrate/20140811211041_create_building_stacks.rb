class CreateBuildingStacks < ActiveRecord::Migration
  def change
    create_table :building_stacks do |t|
      t.integer :base_id
      t.integer :type_id
      t.integer :amount
    end
  end
end
