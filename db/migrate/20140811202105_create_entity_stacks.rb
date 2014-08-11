class CreateEntityStacks < ActiveRecord::Migration
  def change
    create_table :entity_stacks do |t|
      t.integer :base_id
      t.integer :type_id
      t.integer :amount
    end
  end
end
