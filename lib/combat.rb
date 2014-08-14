class Combat
	def self.simulate_combat(ally_units, enemy_units)
		#########################################
		# The units start in a certain range (say 100) and they will get closer 10 by 10
		# In each step, the damage produced by the units in range is added, and multiplied by a factor due to bad aiming
		# The enemy units die when the damage received is greater than the armor
		# Which unit suffers the damage is determined randomly
		#########################################

		distance = 100
		while ally_units.length > 0 && enemy_units.length > 0
			#puts "Attacking from distance #{distance}"

			ally_damage_dealt = damage_dealt_by_units(ally_units, distance)
			enemy_damage_dealt = damage_dealt_by_units(enemy_units, distance)

			ally_units = kill_units(ally_units, enemy_damage_dealt)
			enemy_units = kill_units(enemy_units, ally_damage_dealt)

			distance -= 10 if distance > 0
		end

		{remaining_ally_units: ally_units, remaining_enemy_units: enemy_units}
	end


	private

	def self.damage_dealt_by_units(units, distance)
		damage = 0
		units.each do |a_unit_stack|
			#puts "a stack: type = #{a_unit_stack.type_id}, amount = #{a_unit_stack.amount}"
			entity_type = Cache.entity(a_unit_stack.type_id)
			#puts "entity = #{entity_type}"
			#puts "damage by unit = #{entity_type[:damage]}"
			#puts "range = #{entity_type[:range]}"
			if entity_type[:range] >= distance
				#puts "range = #{entity_type[:range]}"
				damage += a_unit_stack.amount * entity_type[:damage]
			end
		end
		#puts "real damage = #{damage}"
		#puts "damage done = #{damage * precision_factor(distance)}"
		damage * precision_factor(distance)
	end

	def self.kill_units(units, damage_dealt)
		max = 20 # prevent infinite loop
		while damage_dealt >= 10 && max > 0
			#puts "max = #{max}"
			index = rand(units.length)
			entity_type = Cache.entity(units[index].type_id)
			if damage_dealt >= entity_type[:armor] && units[index].amount > 0
				units[index].amount -= 1
				damage_dealt -= entity_type[:armor]
				#puts "Killed unit!"
				if units[index].amount <= 0
					units.delete_at(index)
					break;
				end
			end
			max -= 1
		end
		#puts "Out of killing!"
		units
	end

	def self.precision_factor(distance)
		#puts "precision_factor = #{Math::exp(- (distance / 100.0))}"
		Math::exp(- (distance / 100.0))
	end
end