require_relative "../app.rb"

describe "Transit" do
  before :each do
    @db = DBRetriever.new(DBAdaptorFake)
  end
  it "request db" do
    expect(@db.get.state).to eq(true)
  end
  it "request DB Station by name" do
    expect(@db.get.getStationByName("station")).to eq({:id => 22, :name => "station"})
  end
  it "request DB Station by id" do
    expect(@db.get.getStationById(22)).to eq({:id => 56, :name => "station"})
  end
end

class DBAdaptorFake
  attr_accessor :state
  def initialize
    @stations = double("Station Data")

    @state = true
  end
  
  def getStationByName(name)
    @stations.stub(:getStationByName).and_return({:id => 22, :name => name})
    @stations.getStationByName
  end
  def getStationById(id)
    @stations.stub(:getStationById).and_return({:id => id, :name => "station"})
    @stations.getStationById
  end
end