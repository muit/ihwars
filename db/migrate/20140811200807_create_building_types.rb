class CreateBuildingTypes < ActiveRecord::Migration
  def change
    create_table :building_types do |t|
      t.integer :type_id
      t.string :name

      # Amount of time to finish the building
      t.integer :construction_time

      # Here insert what to produce(symbol string)
      t.string :product_model

      # Basic production
      t.integer :productsxMinute

      # Future combat columns
      # (Buildings can be destroyed)
      t.integer :armor
    end
  end
end
