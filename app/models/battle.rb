class Battle < ActiveRecord::Base
  belongs_to :attacker, :class_name => "User", :foreign_key => "attacker_id"
  belongs_to :defender, :class_name => "User", :foreign_key => "defender_id"
  has_many :battle_entity_stacks
  has_many :battle_resource_stacks

  def storeResults(attacker_entity_stacks, defender_entity_stacks, resource_stacks)
    ActiveRecord::Base.transaction do
      EntityType.getAll.each_with_index do |entity, index|
        #Attacker Final Units
        add_entity_stack(entity.type_id, true, attacker_entity_stacks[index])
        #Attacker Final Units
        add_entity_stack(entity.type_id, false, defender_entity_stacks[index])
      end
      if resource_stacks != nil
        ResourceType.getAll.each do |resource|
          #money stealed
          battle_resource_stacks.create(type_id: resource.type_id, amount: resource_stacks[index].amount)
        end
      end
      save
    end
  end

  private
  def add_entity_stack(type_id, attackers, amount)
    battle_entity_stacks.create(type_id: type_id, attackers: attackers, amount: amount)
  end
end