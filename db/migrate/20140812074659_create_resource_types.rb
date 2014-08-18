class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
    	t.integer :type_id
    	t.string :name
    end
  end
end
