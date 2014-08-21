class AddRankPosition < ActiveRecord::Migration
  def change
  	add_column :user_ranks, :position, :integer, :default => 0
  end
end
