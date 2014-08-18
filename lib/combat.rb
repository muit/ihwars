class Combat
	def simulate_combat(ally_units, enemy_units)
		#########################################
		# The units start in a certain range (say 100) and they will get closer 10 by 10
		# In each step, the damage produced by the units in range is added, and multiplied by a factor due to bad aiming
		# The enemy units die when the damage received is greater than the armor
		# Which unit suffers the damage is determined randomly
		#########################################

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


	private

	def damage_dealt_by_units(units, distance)
		damage = 0
		units.each do |a_unit_hash|
			entity_type = Cache.entity(a_unit_hash[:type_id])
			if entity_type[:range] >= distance
				damage += a_unit_hash[:amount] * entity_type[:damage]
			end
		end
		damage * precision_factor(distance)
	end

	def kill_units(units, damage_dealt)
		max = 20 # prevent infinite loop
		while damage_dealt >= 10 && max > 0
			index = rand(units.length)
			entity_type = Cache.entity(units[index][:type_id])
			if damage_dealt >= entity_type[:armor] && units[index][:amount] > 0
				units[index][:amount] -= 1
				damage_dealt -= entity_type[:armor]
				if units[index][:amount] <= 0
					units.delete_at(index)
					break;
				end
			end
			max -= 1
		end
		units
	end

	def precision_factor(distance)
		Math::exp(- (distance / 100.0))
	end
end