class CreateBattleEntityStacks < ActiveRecord::Migration
  def change
    create_table :battle_entity_stacks do |t|
      t.integer :battle_id
      t.integer :type_id
      t.boolean :attackers
      t.integer :amount
      t.timestamps
    end
  end
end
