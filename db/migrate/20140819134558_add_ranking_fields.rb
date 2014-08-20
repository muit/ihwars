class AddRankingFields < ActiveRecord::Migration
  def change
  	add_column :user_ranks, :total_level, :integer
  end
end
