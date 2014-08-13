class IndexRankings < ActiveRecord::Migration
  def change
  	add_index(:user_ranks, :total_resources)
  	add_index(:user_ranks, :total_money)
  	add_index(:user_ranks, :total_materials)
  end
end
