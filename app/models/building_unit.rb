class BuildingUnit < ActiveRecord::Base
  before_create :add_construction_time

  private
  def add_construction_time
    self.type_id = get_id
    self.finish_building = Time.now+BuildingType.byTypeId(get_id).construction_time.seconds
  end
  def get_id
    -1
  end
	belongs_to :base
  self.inheritance_column = :type
end
