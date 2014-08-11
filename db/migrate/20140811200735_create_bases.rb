class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.string :name
      t.integer :resources

      t.integer :entitystack_id
      t.integer :buildingstack_id
    end
  end
end
