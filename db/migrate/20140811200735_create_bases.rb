class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.integer :user_id
      t.string :name
    end
  end
end
