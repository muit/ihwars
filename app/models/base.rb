class Base < ActiveRecord::Base
  has_many :entity_stacks
  has_many :building_units
  has_many :resource_stacks
  belongs_to :user

<<<<<<< HEAD
  def self.create(arguments)
    base = super(arguments)
    puts "Creating base resources & entities"
    ActiveRecord::Base.transaction do
      ResourceType.getAll.each do |resource|
        base.resource_stacks.create(type_id: resource.type_id, amount: 0)
      end
      EntityType.getAll.each do |entity|
        base.entity_stacks.create(type_id: entity.type_id, amount: 0)
      end
    end
    base.building_units << Hub.create(level: 0)
    base
  end

  def getBuildingAmounts
    amounts = []
    ActiveRecord::Base.transaction do
      BuildingType.getAll.each do |building|
        amount = building_units.where(type_id: building.type_id).length
        amounts.push({type_id: building.type_id, name: building.name, amount: amount})
      end
    end
    amounts
=======
  after_create :create_hub

  validates :name, presence: true

  def hub
    building_units.find_by_type_id(BuildingUnit::HUB_ID)
  end

  private

  def create_hub
    building_units << Hub.create(level: 1)
>>>>>>> 90cc6f7ec9d786cbcba1cbb1c70cc898f7f34a0f
  end

end
