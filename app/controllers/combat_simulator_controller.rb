class CombatSimulatorController < ApplicationController
	def simulator
		@ally_result = Array.new(EntityType.getAll.length, zeroed_unit_hash)
		@enemy_result = Array.new(EntityType.getAll.length, zeroed_unit_hash)

		if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
	end

	def run
		ally_units = get_units("ally", params)
		enemy_units = get_units("enemy", params)

		result = Combat.new.simulate_combat(ally_units, enemy_units)
		
		@ally_result = normalize_units(result[:remaining_ally_units])
		@ally_result = add_old_values(@ally_result, get_units("ally", params))

		@enemy_result = normalize_units(result[:remaining_enemy_units])
		@enemy_result = add_old_values(@enemy_result, get_units("enemy", params))	

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
				unit = {amount: params[name].to_i, type_id: id}
				units.push(unit)
			end
		end

		units
	end

	def normalize_units(units)
		new_units = Array.new(EntityType.getAll.length)
		new_units = new_units.map {zeroed_unit_hash_with_amount}
		units.each do |an_old_unit|
			id = an_old_unit[:type_id]
			new_units[id] = an_old_unit
		end
		new_units
	end

	def add_old_values(units, old_units)
		old_units.each do |an_old_unit|
			id = an_old_unit[:type_id]
			unit = units[id]
			unit[:old_amount] = an_old_unit[:amount]
			unit[:type_id] = an_old_unit[:type_id]
		end
		units
	end

	def zeroed_unit_hash()
		{old_amount: 0}
	end

	def zeroed_unit_hash_with_amount()
		{old_amount: 0, amount: 0}
	end
end
