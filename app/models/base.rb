class Base < ActiveRecord::Base
  has_many :entity_stacks
  has_many :building_units
  has_many :resource_stacks
  belongs_to :user

  def self.create(arguments)
    base = super(arguments)
    puts "Creating base resources & entities"
    ActiveRecord::Base.transaction do
      Cache.resources.each do |resource|
        base.resource_stacks.create(type_id: resource[:type_id], amount: 0)
      end
      Cache.entities.each do |entity|
        base.entity_stacks.create(type_id: entity[:type_id], amount: 0)
      end
    end
    base
  end

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
        amount = building_units.where(type_id: building[:type_id]).length
        amounts.push({type_id: building[:type_id], name: building[:name], amount: amount})
      end
    end
    amounts
  end
end
