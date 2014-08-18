class Opcode
  class << self
    attr_accessor :BASE_CREATE, 
      :BASE_DELETE, 
      :BUILDING_CREATE, 
      :BUILDING_DELETE,
      :BASE_INFO,
      :BUILDING_INFO,
      :RESOURCE_INFO

    def load
      @BASE_CREATE = 0x07
      @BASE_DELETE = 0x08
      @BUILDING_CREATE = 0x09
      @BUILDING_DELETE = 0x0a
      @BASE_INFO = 0x0b
      @BUILDING_INFO = 0x0c
      @RESOURCE_INFO = 0x0d
    end
  end
end