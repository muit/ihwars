class LoadSys
  def initialize
    puts "***Loading Cache:"
    Cache.loadBuildings
    Cache.loadEntities
    puts "***"
  end
end