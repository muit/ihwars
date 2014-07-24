require_relative "../app.rb"

describe "Transit" do
  it "request db" do
    db = DBRetriever.new(DBAdaptorFake)
    expect(db.get.state).to eq(true)
  end
end

class DBAdaptorFake
  attr_accessor :state
  def initialize
    @state = true
  end
end