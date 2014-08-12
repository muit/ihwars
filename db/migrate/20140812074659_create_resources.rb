class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
    	t.integer :type_id
    	t.string :name
    end
  end
end
