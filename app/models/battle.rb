class Battle < ActiveRecord::Base
  belongs_to :user, foreign_key: "attacker_id"
  belongs_to :user, foreign_key: "defensor_id"
  has_many :entity_stacks

  after_create :prepare

  def indexResults

    save
  end

  private
  def prepare
    ActiveRecord::Base.transaction do
      ResourceType.getAll.each do |resource|
        resource_stacks.create(type_id: resource.type_id, amount: 0)
      end
      EntityType.getAll.each do |entity|
        entity_stacks.create(type_id: entity.type_id, amount: 0)
      end
    end
  end
end
