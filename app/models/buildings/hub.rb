class Hub < BuildingUnit
  before_create :set_building_type

  private

  def set_building_type
    self.type_id = 0
  end
end
