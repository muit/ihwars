class EntityController < ApplicationController
  include ApplicationHelper
  def add
    base = getBase(params[:actualBase])
    amount = params[:amount].to_i
    typeId = params[:type_id].to_i
    opcode = Opcode::ENTITY_CREATE
    return if watch_error(opcode, !hasBarracks?(base), "You can´t create units until you build the barracks!")
    return if watch_error(opcode, is_entity_size_exceded?(amount, base), "Not enought space in the base. Build houses!")

    cost = EntityType.byTypeId(typeId).cost*amount
    baseMaterials = base.resource_stacks.find_by_type_id(0)
    return if watch_error(opcode, cost > baseMaterials.amount, "You dont have enought materials!")
    baseMaterials.amount -= cost
    baseMaterials.save

    stack = base.entity_stacks.where(type_id: typeId).first
    stack.amount += amount
    stack.save
    
    answerObject = {error: false}
    render :json => Packet.new(Opcode::ENTITY_CREATE, answerObject)
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
