class Bank < BuildingUnit
  def self.create(arguments)
    arguments[:type_id] = 6
    arguments[:finish_building] = Time.now+Cache.building(6)[:construction_time].seconds
    super(arguments)
  end
end