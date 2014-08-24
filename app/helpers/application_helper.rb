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

  def is_entity_size_exceded?(amount, base)
    entityAmountArray = base.entity_stacks.all.map{|entityStack| entityStack.amount}
    size = entityAmountArray.sum + amount
    total_entity_size(base) <= size
  end

  def total_entity_size(base)
    houses = base.building_units.where(type: "House")
    Settings::INITIAL_ENTITY_SIZE + houses.count * House.entity_size
  end

  def watch_error(opcode, condition, msg)
    if(condition)
      render :json => Packet.new(opcode, {error: true, msg: msg})
    end
    condition
  end

  def hasFactories?(base)
    base.building_units.where(type: "Factory").count >= 1
  end
  def hasBarracks?(base)
    base.building_units.where(type: "Barracks").count >= 1
  end
end