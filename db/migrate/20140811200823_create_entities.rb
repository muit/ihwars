class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.integer :type_id
      t.string :name

      #Future combat columns
      t.integer :damage
      t.integer :armor
    end
  end
end