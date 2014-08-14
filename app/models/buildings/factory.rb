class Factory < BuildingUnit
  def create(arguments)
    arguments[:type_id] = 3
    arguments[:finish_building] = Time.now+Cache.building(3)[:construction_time].seconds
    super(arguments)
  end
end