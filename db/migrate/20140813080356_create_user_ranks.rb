class CreateUserRanks < ActiveRecord::Migration
  def change
    create_table :user_ranks do |t|
    	t.integer :total_resources
    	t.integer :total_money
    	t.integer :total_materials

    	t.integer :user_id
    end
  end
end
