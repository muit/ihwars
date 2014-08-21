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
    ally_units = generate_array(entity_stacks)
    enemy_units = generate_array(enemy_base.entity_stacks)

    simulate_combat(ally_units, enemy_units)

    fill_base(self, ally_units)
    fill_base(enemy_base, enemy_units)

    {remaining_ally_units: entity_stacks, remaining_enemy_units: enemy_base.entity_stacks}
  end

  def get_level_points
    points = 0
    building_units.each do |a_building_unit|
      points += 10 # For being built
      points += 5 * a_building_unit.level # 5 points per level
    end
    points
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
    distance = 100
    ally_accumulated_damage = 0
    enemy_accumulated_damage = 0

    while array_has_units(ally_units) && array_has_units(enemy_units)
      ally_damage = damage_dealt_by_units(ally_units, distance)
      enemy_damage = damage_dealt_by_units(enemy_units, distance)

      enemy_accumulated_damage = kill_units(ally_units, enemy_damage + enemy_accumulated_damage)
      ally_accumulated_damage = kill_units(enemy_units, ally_damage + ally_accumulated_damage)

      distance -= 10 if distance > 0   
    end
  end

  def generate_array(entity_stacks)
    new_array = Array.new(EntityType.count, 0)
    entity_stacks.each do |a_stack|
      new_array[a_stack.type_id] = a_stack.amount
    end
    new_array
  end

  def damage_dealt_by_units(units, distance)
    damage = 0
    units.each_with_index do |a_unit, index|
      entity_type = EntityType.by(:type_id, index)
      if entity_type.range >= distance
        damage += a_unit * entity_type.damage
      end
    end
    damage * precision_factor(distance)
  end

  def kill_units(units, damage)
    max = 20 # prevent infinite loop
    while damage >= 10 && max > 0
      index = rand(units.length)
      entity_type = EntityType.by(:type_id, index)
      if damage >= entity_type.armor && units[index] > 0
        units[index] -= 1
        damage -= entity_type.armor
      end
      max -= 1
    end
    damage
  end

  def fill_base(base, units)
    base.entity_stacks.each do |a_stack|
      a_stack.update_attribute(:amount, units[a_stack.type_id])
    end
  end

  def array_has_units(array)
    result = false
    array.each do |a_unit|
      result = true if a_unit != 0
    end
    result
  end

  def precision_factor(distance)
    Math::exp(-(distance / 100.0))
  end
  ##########
end
