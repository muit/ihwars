class BuildingUnit < ActiveRecord::Base
  @id = -1
  before_create :add_construction_time

  private
  def add_construction_time
    self.type_id = @id
    self.finish_building = Time.now+BuildingType.byTypeId(@id).construction_time.seconds
    super(arguments)
  end

	belongs_to :base
  self.inheritance_column = :type
end
