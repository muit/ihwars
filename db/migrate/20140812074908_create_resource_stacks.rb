class CreateResourceStacks < ActiveRecord::Migration
  def change
    create_table :resource_stacks do |t|
    	t.integer :base_id
    	t.integer :type_id
    	t.integer :amount

      t.timestamps
    end
  end
end
