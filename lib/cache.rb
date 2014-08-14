class Cache
  class << self
    #Cache will save in memory static db contents(witch wont change)
    #Entity adapter
    attr_accessor :entities
    def loadEntities
      puts "    Loading Entity Types from database..."
      @entities = Entity.all.map{|entity| entity.attributes}
      @entities.map{|entity| entity.symbolize_keys!()}
    end
    def selectEntity(argument, value)
      return nil if !@entities
      @entities.select{|entity| entity[argument.to_sym] == value}[0]
    end
    def entity(type_id)
      return nil if !@entities
      @entities.select{|entity| entity[:type_id] == type_id}[0]
    end

    #Building adapter
    attr_accessor :buildings
    def loadBuildings
      puts "    Loading Building Types from database..."
      @buildings = Building.all.map{|building| building.attributes}
      @buildings.map{|building| building.symbolize_keys!()}
    end
    def selectBuilding(argument, value)
      return nil if !@buildings
      @buildings.select{|building| building[argument.to_sym] == value}[0]
    end
    def building(type_id)
      return nil if !@buildings
      @buildings.select{|building| building[:type_id] == type_id}[0]
    end
  end
end