require 'rails_helper'

RSpec.describe Barracks, :type => :model do
  before(:each) do
  end 

  it "can be created" do
    lindeman = Barracks.create(level: 1)

    expect(lindeman).not_to eq(nil)
  end

  it "can be asigned to a base" do
    base = Base.create(name: "chompy")
    base.building_units.delete_all
    base.building_units << Barracks.create(level: 1)

    expect(base.building_units.count).to eq(1)
  end
end
