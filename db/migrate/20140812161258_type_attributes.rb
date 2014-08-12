class TypeAttributes < ActiveRecord::Migration
  def change
  	add_column :entities, :range, :integer
  end
end
