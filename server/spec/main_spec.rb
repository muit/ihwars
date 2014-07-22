require_relative "../lib/main.rb"

describe "RankingManager" do
  before :each do
    @barcelona = Point.new(100, ["I love it!", "So FUCKING beautiful!"])
    @miami = Point.new(10, ["Holy Shit!", "There were butterflies in my soap!"])
    @agadez = Point.new(50, ["I saw an elephant in the desert!"])
    @madrid = Point.new(70, ["My grandfather came back to life to see that!", "The underground was cool!", "Drugs are for free!"])

    @ranking = RankingManager.new([@barcelona, @miami, @agadez, @madrid])
  end  

  it "ranks correctly by popularity" do
    expect(@ranking.byPopularity).to eq([@barcelona, @madrid, @agadez, @miami])
  end

  it "ranks correctly by number of comments" do
    expect(@ranking.byComments).to eq([@madrid, @miami, @barcelona, @agadez])
  end

  it "ranks correctly by number of commentary words" do
    expect(@ranking.byNumberOfWords).to eq([@madrid, @miami, @agadez, @barcelona])
  end
end