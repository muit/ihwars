module UsersHelper
	def entity_stacks_has_units(entity_stacks)
		result = false
		entity_stacks.each do |a_stack|
			result = true unless a_stack.amount == 0
		end
		result
	end
end
