class Bank < BuildingUnit
  def self.create(arguments)
    arguments[:type_id] = 2
    arguments[:finish_building] = Time.now+Cache.building(2)[:construction_time].seconds
    super(arguments)
  end
end