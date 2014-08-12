class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.string :name
    end
  end
end
