require_relative "../app.rb"

describe "Transit" do
  before :each do
    @db = DBRetriever.new(DBAdaptorFake)
  end
  it "request db" do
    expect(@db.get.state).to eq(true)
  end
  it "request DB Station by name" do
    expect(@db.get.StationByName("station")).to eq({:id => 22, :name => "station"})
  end
  it "request DB Station by id" do
    expect(@db.get.StationById(56)).to eq({:id => 56, :name => "station"})
  end
end

describe "Parser" do
  before :each do

  end
  it "loads"
    expect(RenfeParser.new).to eq("http://renfe.com")
  end
  it "Conects to Renfe" do
  end
  it "requests renfe web" do
  end
end

