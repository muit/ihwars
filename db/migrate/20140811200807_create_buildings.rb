class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.integer :type_id
      t.string :name_es
      t.string :name_en

      #Here insert what to produce(symbol string)
      t.string :product_model

      #Seconds to the new production
      t.integer :production_speed

      #Future combat columns
      #(Buildings can be destroyed)
      t.integer :armor

    end
  end
end
