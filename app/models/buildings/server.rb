class Server < BuildingUnit
  def self.create(arguments)
    arguments[:type_id] = 1
    arguments[:finish_building] = Time.now+Cache.building(1)[:construction_time].seconds
    super(arguments)
  end
end