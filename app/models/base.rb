class Base < ActiveRecord::Base
  has_many :entity_stacks
  has_many :building_units
  has_many :resource_stacks
  belongs_to :user
  validates :name, presence: true

  after_create :prepare

  def get_building_info
    amounts = []
    ActiveRecord::Base.transaction do
      BuildingType.getAll.each do |building|
        if(!building.unique)
          amount = building_units.where(type_id: building.type_id).length
        else
          amount = -1
        end
        amounts.push({type_id: building.type_id, name: building.name, amount: amount})
      end
    end
    amounts
  end


  private
  def prepare
    ActiveRecord::Base.transaction do
      #create 
      ResourceType.getAll.each do |resource|
        resource_stacks.create(type_id: resource.type_id, amount: 0)
      end
      EntityType.getAll.each do |entity|
        entity_stacks.create(type_id: entity.type_id, amount: 0)
      end
      #create Hub
      building_units << Hub.create(level: 1)
    end
  end

end
