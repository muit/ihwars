require "networking/packet"
require "networking/opcode"

if File.basename($0)!="rake"
  puts "***Loading Config:"
  puts "    MaxBases: 5"
  Settings.maxBases = 5
  puts "    CoefPerlevel: 0.25"
  Settings.coefPerLevel = 0.25
  puts "***"

  puts "***Loading Cache:"
  Cache.loadLinks
  puts "***"


  #Detect that is loading server 
  if(File.basename($0) == "rails" && ENV["RAILS_ENV"] != nil)
    puts "***Loading Jobs..."
    Jobs.new
    puts "***"
  end
  
end