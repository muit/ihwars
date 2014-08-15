require "networking/packet"
require "networking/opcode"

class LoadSys
  def initialize
    puts "***Loading Config:"
    puts "    MaxBases: 5"
    Settings.maxBases = 5
    puts "***"

    puts "***Loading Cache:"
    Cache.loadBuildings
    Cache.loadEntities
    puts "***"

    puts "***Loading Opcodes:"
    Opcode.load
    puts "***"
  end
end