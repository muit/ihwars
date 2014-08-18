class Base < ActiveRecord::Base
  has_many :entity_stacks
  has_many :building_units
  has_many :resource_stacks
  belongs_to :user

  after_create :create_hub

  validates :name, presence: true

  def hub
    building_units.find_by_type_id(BuildingUnit::HUB_ID)
  end

  private

  def create_hub
    building_units << Hub.create(level: 1)
  end

end
