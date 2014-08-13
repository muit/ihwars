module ApplicationHelper
	def get_current_user_resource(id)
		amount = 0
		current_user.bases.each do |a_base|
			a_base.resource_stacks.each do |a_resource_stack|
				if a_resource_stack.type_id == id
					amount += a_resource_stack.amount
				end
			end
		end
		amount
	end
end