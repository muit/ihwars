class CreateBattleResourceStacks < ActiveRecord::Migration
  def change
    create_table :battle_resource_stacks do |t|
      t.integer :battle_id
      t.integer :type_id
      t.integer :amount
      t.timestamps
    end
  end
end
