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
		@old_ally_units = normalize_units(get_units("ally", params))
		@old_enemy_units = normalize_units(get_units("enemy", params))

		result = Combat.new.simulate_combat(get_units("ally", params), get_units("enemy", params))
		
		@ally_result = normalize_units(result[:remaining_ally_units])
		@enemy_result = normalize_units(result[:remaining_enemy_units])

		if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
	end


	private
	def get_units(team_string, params)
		units = []
		EntityType.getAll.each do |an_entity|
			id = an_entity[:type_id]
			name = "#{team_string}_#{id}"
			if params[name].to_i > 0
				unit = EntityStack.new(amount: params[name].to_i, type_id: id)
				# unit = {amount: params[name].to_i, type_id: id}
				units.push(unit)
			end
		end
		units
	end

	def normalize_units(units)
		new_units = Array.new(EntityType.getAll.length)
		new_units = new_units.map {zeroed_unit}
		units.each do |an_old_unit|
			id = an_old_unit.type_id
			new_units[id] = an_old_unit
		end
		new_units
	end

	#def add_old_values(units, old_units)
	#	old_units.each do |an_old_unit|
	#		id = an_old_unit.type_id
	#		unit = units[id]
	#		unit[:old_amount] = an_old_unit[:amount]
	#		unit[:type_id] = an_old_unit[:type_id]
	#	end
	#	units
	#end

	def zeroed_unit()
		EntityStack.new(amount: 0)
	end
end
