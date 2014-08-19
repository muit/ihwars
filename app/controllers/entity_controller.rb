class EntityController < ApplicationController
  def create
    amount = params[:amount]
    base = params[:selectedBase]
    type_id = params[:type_id]
    opcode = Opcode::ENTITY_CREATE

    return if watch_error opcode, !hasFactories?, "Can´t create entities without factories!"

    return if watch_error opcode, is_entity_size_exceded?(amount, base), "Not enought space in the base. Build houses!"

    stack = base.entity_stacks.where(type_id: type_id).first
    stack.amount += amount
    stack.save

    answerObject = {error: false, amount: stack.amount}
    render :json => Packet.new(opcode, answerObject)
  end

  def remove
    render :json => Packet.new(Opcode::ENTITY_DELETE, {error: true})
  end

  private
  
end
