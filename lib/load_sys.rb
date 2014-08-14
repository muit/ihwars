class LoadSys
  def initialize
    Cache.loadBuildings
    Cache.loadEntities
  end
end