class Battle < ActiveRecord::Base
  belongs_to :attacker, :class_name => "User", :foreign_key => "attacker_id"
  belongs_to :defender, :class_name => "User", :foreign_key => "defender_id"
  has_many :battle_entity_stacks
  has_many :battle_resource_stacks

  after_create :prepare

  def storeResults(attacker_entity_stacks, defender_entity_stacks, resource_stacks)
    ActiveRecord::Base.transaction do
      ResourceType.getAll.each do |resource|
        battle_resource_stacks.create(type_id: resource.type_id, attackers: true, amount: 0)
      end
      ResourceType.getAll.each do |resource|
        battle_resource_stacks.create(type_id: resource.type_id, attackers: false, amount: 0)
      end

      EntityType.getAll.each do |entity|
        battle_entity_stacks.create(type_id: entity.type_id, amount: 0)
      end
    end
    save
  end

  private
  def prepare
  end
end