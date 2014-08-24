class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :attacker_id
      t.integer :defensor_id
      
      t.timestamps
    end
  end
end
