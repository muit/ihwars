class Laboratory < BuildingUnit
  def self.create(arguments)
    arguments[:type_id] = 5
    arguments[:finish_building] = Time.now+Cache.building(5)[:construction_time].seconds
    super(arguments)
  end
end