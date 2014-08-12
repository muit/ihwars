class Opcode
  class << self
    attr_accessor :BASE_CREATE, 
      :BASE_DELETE
    
    @BASE_CREATE = 0x07
    @BASE_DELETE = 0x08
  end
end