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
    ally_units = r_generate_array(entity_stacks)
    enemy_units = r_generate_array(enemy_base.entity_stacks)

    r_simulate_combat(ally_units, enemy_units)

    r_fill_base(self, ally_units)
    r_fill_base(enemy_base, enemy_units)

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
  def r_simulate_combat(ally_units, enemy_units)
    distance = 100
    ally_accumulated_damage = 0
    enemy_accumulated_damage = 0

    while r_array_has_units(ally_units) && r_array_has_units(enemy_units)
      ally_damage = r_damage_dealt_by_units(ally_units, distance)
      enemy_damage = r_damage_dealt_by_units(enemy_units, distance)

      enemy_accumulated_damage = r_kill_units(ally_units, enemy_damage + enemy_accumulated_damage)
      ally_accumulated_damage = r_kill_units(enemy_units, ally_damage + ally_accumulated_damage)

      distance -= 10 if distance > 0   
    end
  end

  def r_generate_array(entity_stacks)
    new_array = Array.new(EntityType.count, 0)
    entity_stacks.each do |a_stack|
      new_array[a_stack.type_id] = a_stack.amount
    end
    new_array
  end

  def r_damage_dealt_by_units(units, distance)
    damage = 0
    units.each_with_index do |a_unit, index|
      entity_type = EntityType.by(:type_id, index)
      if entity_type.range >= distance
        damage += a_unit * entity_type.damage
      end
    end
    damage * precision_factor(distance)
  end

  def r_kill_units(units, damage)
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

  def r_fill_base(base, units)
    base.entity_stacks.each do |a_stack|
      a_stack.update_attribute(:amount, units[a_stack.type_id])
    end
  end

  def r_array_has_units(array)
    result = false
    array.each do |a_unit|
      result = true if a_unit != 0
    end
    result
  end

  def simulate_combat(ally_units, enemy_units)
    # The units start in a certain range (100) and they will get closer 10 by 10
    # In each step, the damage produced by the units in range is added, and multiplied by a factor (<=1) due to bad aiming
    # The enemy units die when the damage received is greater than their armor
    # Which unit suffers the damage is determined randomly
    distance = 100
    ally_accumulated_damage = 0
    enemy_accumulated_damage = 0

    ally_units = ally_units.select{|a_unit| a_unit.amount > 0}
    enemy_units = enemy_units.select{|a_unit| a_unit.amount > 0}

    while ally_units.length > 0 && enemy_units.length > 0
      ally_damage_dealt = damage_dealt_by_units(ally_units, distance)
      enemy_damage_dealt = damage_dealt_by_units(enemy_units, distance)

      enemy_accumulated_damage = kill_units(ally_units, enemy_damage_dealt + enemy_accumulated_damage)
      ally_accumulated_damage = kill_units(enemy_units, ally_damage_dealt + ally_accumulated_damage)

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
    damage_dealt
  end

  def precision_factor(distance)
    Math::exp(-(distance / 100.0))
  end

  def fill_spaces(entity_stacks)
    new_entity_stacks = []
    for i in 0...EntityType.count
      old_stack = entity_stacks.select { |stack| stack.type_id == i }.first
      if old_stack.present?
        old_stack.save
        new_entity_stacks << old_stack
      else
        new_entity_stacks << EntityStack.create(type_id: i, amount: 0)
      end
    end
    new_entity_stacks
  end
  ##########
end
