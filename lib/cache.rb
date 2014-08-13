class Cache
  class << self
    #Cache will save in memory static db contents(witch wont change)
    #Entity adapter
    attr_accessor :entities
    def loadEntities
      @entities = Entity.all.map{|entity| entity.attributes}
    end
    def entity(type_id)
      @entities.select{|entity| entity["type_id"] == type_id}[0]
    end

    #Building adapter
    attr_accessor :buildings
    def loadBuildings
      @buildings = Building.all.map{|building| building.attributes}
    end
    def building(type_id)
      @buildings.select{|building| building["type_id"] == type_id}[0]
    end
  end
end