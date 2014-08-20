class Base < ActiveRecord::Base
  has_many :entity_stacks
  has_many :building_units
  has_many :resource_stacks
  belongs_to :user
  validates :name, presence: true

  after_create :prepare

  def get_building_info
    info = []
    ActiveRecord::Base.transaction do
      BuildingType.getAll.each do |building|
        buildingUnit = building_units.where(type_id: building.type_id).first
        if(buildingUnit != nil)
          buildingLevel = buildingUnit.level
        else
          buildingLevel = 0
        end
        info.push({type_id: building.type_id, name: building.name, level: buildingLevel})
      end
    end
    info
  end

  def attack_base(enemy_base)
    # For simplicity, all the units in the base figth
    ally_units = entity_stacks
    enemy_units = enemy_base.entity_stacks

    result = simulate_combat(ally_units, enemy_units)
    
    entity_stacks = result[:remaining_ally_units]
    enemy_base.entity_stacks = result[:remaining_enemy_units]

    result
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

  ##### COMBAT SIMULATION #####
  def simulate_combat(ally_units, enemy_units)
    # The units start in a certain range (100) and they will get closer 10 by 10
    # In each step, the damage produced by the units in range is added, and multiplied by a factor (<=1) due to bad aiming
    # The enemy units die when the damage received is greater than their armor
    # Which unit suffers the damage is determined randomly

    distance = 100
    while ally_units.length > 0 && enemy_units.length > 0
      ally_damage_dealt = damage_dealt_by_units(ally_units, distance)
      enemy_damage_dealt = damage_dealt_by_units(enemy_units, distance)

      ally_units = kill_units(ally_units, enemy_damage_dealt)
      enemy_units = kill_units(enemy_units, ally_damage_dealt)

      distance -= 10 if distance > 0
    end

    {remaining_ally_units: ally_units, remaining_enemy_units: enemy_units}
  end

  def damage_dealt_by_units(units, distance)
    damage = 0
    units.each do |a_unit|
      entity_type = EntityType.by(:type_id, a_unit.type_id)
      if entity_type.range >= distance
        damage += a_unit.amount * entity_type.damage
      end
    end
    damage * precision_factor(distance)
  end

  def kill_units(units, damage_dealt)
    max = 20 # prevent infinite loop
    while damage_dealt >= 10 && max > 0
      index = rand(units.length)
      entity_type = EntityType.by(:type_id, units[index].type_id)
      if damage_dealt >= entity_type.armor && units[index].amount > 0
        units[index].amount -= 1
        damage_dealt -= entity_type.armor
        if units[index].amount <= 0
          # units.delete_at(index)
          units.delete(units[index])
          break
        end
      end
      max -= 1
    end
    units
  end

  def precision_factor(distance)
    Math::exp(-(distance / 100.0))
  end
  ##########
end
