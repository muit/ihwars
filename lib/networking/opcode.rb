class Opcode
  class << self
    attr_accessor :BASE_CREATE, 
      :BASE_DELETE, :BUILDING_CREATE, :BUILDING_DELETE

    def load
      @BASE_CREATE = 0x07
      @BASE_DELETE = 0x08
      @BUILDING_CREATE = 0x09
      @BUILDING_DELETE = 0x0a
    end
  end
end