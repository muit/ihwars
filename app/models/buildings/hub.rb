class Hub < BuildingUnit
  def create(arguments)
    arguments[:type_id] = 0
    arguments[:finish_building] = Time.now+Cache.building(0)[:construction_time].seconds
    super(arguments)
  end
end