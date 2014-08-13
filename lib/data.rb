class Data
  class << self
    #Entity adapter
    attr_accessor :entities
    def loadEntities
      @entities = Entity.all
    end
    def entity(type_id)
      @entities.find_by_type_id(type_id)
    end

    #Building adapter
    attr_accessor :buildings
    def loadBuildings
      @buildings = Building.all
    end
    def building(type_id)
      @buildings.find_by_type_id(type_id)
    end
  end
end