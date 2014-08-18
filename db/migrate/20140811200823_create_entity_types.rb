class CreateEntityTypes < ActiveRecord::Migration
  def change
    create_table :entity_types do |t|
      t.integer :type_id
      t.string :name

      #Future combat columns
      t.integer :damage
      t.integer :armor
      t.integer :range
    end
  end
end
