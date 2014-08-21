class CombatSimulatorController < ApplicationController
	def simulator
		@ally_result = Array.new(EntityType.getAll.length, zeroed_unit)
		@enemy_result = Array.new(EntityType.getAll.length, zeroed_unit)

		@old_ally_units = Array.new(EntityType.getAll.length, zeroed_unit)
		@old_enemy_units = Array.new(EntityType.getAll.length, zeroed_unit)

		if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
	end

	def run
		@old_ally_units = get_units("ally", params)
		@old_enemy_units = get_units("enemy", params)

		ally_base = Base.create(name: "Ally base")
		enemy_base = Base.create(name: "Enemy base")
		populate_base(ally_base, get_units("ally", params))
		populate_base(enemy_base, get_units("enemy", params))

		result = ally_base.attack_base(enemy_base)

		@ally_result = normalize_units(ally_base.entity_stacks)
		@enemy_result = normalize_units(enemy_base.entity_stacks)

		ally_base.destroy
		enemy_base.destroy

		if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
	end


	private
	def populate_base(base, units)
		units.each_with_index do |a_unit, index|
			base.entity_stacks[index].update_attribute(:amount, a_unit)
		end
	end

	def get_units(team_string, params)
		units = []
		EntityType.getAll.each do |an_entity|
			id = an_entity[:type_id]
			name = "#{team_string}_#{id}"
			units[id] = params[name].to_i
		end
		units
	end

	def normalize_units(units)
		new_units = Array.new(EntityType.getAll.length)
		units.each do |an_old_unit|
			id = an_old_unit.type_id
			new_units[id] = an_old_unit
		end
		new_units
	end

	def zeroed_unit()
		EntityStack.new(amount: 0)
	end
end
