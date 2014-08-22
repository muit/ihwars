class EntityController < ApplicationController
  def add
    base = params[:selectedBase]
    opcode = Opcode::ENTITY_CREATE

    return_error opcode, "Can't create entities without factories!" unless hasFactories?
    return_error opcode, "Not enought space in the base. Build houses!" if is_entity_size_exceded?(amount, base)

    cost = EntityType.byTypeId(typeId).cost
    baseMaterials = selectedBase.resource_stacks.find_by_type_id(0)
    return if watch_error(opcode, cost > baseMaterials.amount, "You dont have enought materials!")
    baseMaterials.amount -= cost
    baseMaterials.save

    stack = base.entity_stacks.where(type_id: params[:type_id]).first
    stack.amount += params[:amount]
    stack.save

    return_success opcode, amount: stack.amount
  end

  def remove
    render :json => Packet.new(Opcode::ENTITY_DELETE, {error: true})
  end

  private

  def return_success(opcode, answer)
    render :json => Packet.new(opcode, {error: false}.merge!(answer))
  end

  def return_error(opcode, message)
    render :json => Packet.new(opcode, {error: true, msg: message})
  end

end
