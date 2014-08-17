class Barracks < BuildingUnit
  def self.create(arguments)
    arguments[:type_id] = 4
    arguments[:finish_building] = Time.now+Cache.building(4)[:construction_time].seconds
    super(arguments)
  end
end