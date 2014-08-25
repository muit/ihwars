class Battle < ActiveRecord::Base
  has_many :battle_entity_stacks
  has_many :battle_resource_stacks

  after_create :prepare

  def indexResults

    save
  end

  def attacker
    #Error
    Attacker(User.find(attacker_id)).addBattle(self)
  end

  def defensor
    #Error
    Defensor(User.find(defensor_id)).addBattle(self)
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

class Attacker < User
  def addBattle(obj)
    @battle = obj
    self
  end
  def <<(b)
    @battle.attacker_id = b.id
    @battle.save
  end
end

class Defensor < User
  def addBattle(obj)
    @battle = obj
    self
  end
  def <<(b)
    @battle.defensor_id = b.id
    @battle.save
  end
end
