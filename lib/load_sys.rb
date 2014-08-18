require "networking/packet"
require "networking/opcode"

class LoadSys
  def initialize
    puts "***Loading Config:"
    puts "    MaxBases: 5"
    Settings.maxBases = 5
    puts "    CoefPerlevel: 0.25"
    Settings.coefPerLevel = 0.25
    puts "***"

    puts "***Loading Cache:"
    Cache.loadBuildings
    Cache.loadEntities
    Cache.loadResources
    Cache.loadLinks
    puts "***"

    puts "***Loading Opcodes..."
    Opcode.load

    puts "***Loading Jobs..."
    Jobs.new
    
    puts "***"
  end
end