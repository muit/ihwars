
#//DATABASE////////

class DBRetriever
  def initialize (adaptor = DBAdaptor)
    @adaptor = adaptor.new
  end
  def get
    @adaptor
  end
end

class DBAdaptor
  attr_accessor :state
  def initialize
    @state = true
  end

  def StationByName(name)
  end
  def StationById(id)
  end
end

class DBAdaptorFake
  attr_accessor :state
  def initialize
    @stations = double("StationData")
    @state = true
  end
  
  def StationByName(name)
    @stations.stub(:StationByName).and_return({:id => 22, :name => name})
    @stations.StationByName
  end
  def StationById(id)
    @stations.stub(:StationById).and_return({:id => id, :name => "station"})
    @stations.StationById
  end
end

#Tables
#class Station < Activerecord::Base
#end