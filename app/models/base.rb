class Base < ActiveRecord::Base
  has_many :entity_stacks
  has_many :building_units
  has_many :resource_stacks
  belongs_to :user

  def getEntities

    ActiveRecord::Base.transaction do
      Cache.entities.each do |entity|
        baseEntity = entity_stacks.where(type_id: entity[:type_id])[0]
        if(baseEntity == nil)
          entity_stacks.create(type_id: entity[:type_id], amount: 0)
        end
      end
    end
    entity_stacks
  end

  def getBuildingAmounts
    amounts = []
    ActiveRecord::Base.transaction do
      Cache.buildings.each do |building|
        amount = buildings_stacks.where(type_id: building[:type_id]).length
        amounts.push({type_id: building[:type_id], amount: amount})
      end
    end
    amounts
  end
end
