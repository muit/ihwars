require "rails_helper"

RSpec.describe Hub, :type => :model do

  before(:each) do
  end 

  it "can be created" do
    lindeman = Hub.create(level: 1)

    expect(lindeman).not_to eq(nil)
  end

  it "can be asigned to a base" do
    base = Base.create(name: "chompy")
    base.building_units.delete_all
    base.building_units << Hub.create(level: 1)

    expect(base.building_units.count).to eq(1)
  end
end