class Battle < ActiveRecord::Base
  belongs_to :attacker, :class_name => "User", :foreign_key => "attacker_id"
  belongs_to :defender, :class_name => "User", :foreign_key => "defender_id"
  has_many :battle_entity_stacks
  has_many :battle_resource_stacks

  after_create :prepare

  def indexResults

    save
  end

  private
  def prepare
    ActiveRecord::Base.transaction do
      ResourceType.getAll.each do |resource|
        battle_resource_stacks.create(type_id: resource.type_id, amount: 0)
      end
      EntityType.getAll.each do |entity|
        battle_entity_stacks.create(type_id: entity.type_id, amount: 0)
      end
    end
  end
end