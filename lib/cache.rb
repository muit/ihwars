class Cache
  class << self

    #Building - Resource Links
    attr_accessor :building_resources
    def loadLinks
      puts "    Loading Resource - Building links..."
      @building_resources = [
        {building_id: 2, resource_id: 0},
        {building_id: 3, resource_id: 1},
        {building_id: 1, resource_id: 2}
      ]
    end
  end
end