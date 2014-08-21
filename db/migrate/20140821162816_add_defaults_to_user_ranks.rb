class AddDefaultsToUserRanks < ActiveRecord::Migration
  def change
  	change_column :user_ranks, :total_level, :integer, :default => 0
		change_column :user_ranks, :total_resources, :integer, :default => 0
		change_column :user_ranks, :total_money, :integer, :default => 0
		change_column :user_ranks, :total_materials, :integer, :default => 0
  end
end
