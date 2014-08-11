class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :project_id
      t.date :date
      t.integer :hours
      t.integer :minutes
      t.text :comment
      t.timestamps
    end
  end
end
