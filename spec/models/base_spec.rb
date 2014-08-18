require 'rails_helper'

RSpec.describe Base, :type => :model do

  before(:each) do
  end 

  it "can be created and it´s not nil" do
    base = Base.create(name: "chompy")

    expect(base).not_to eq(nil)
  end

  it "adds entity_stacks when created" do
    base = Base.create(name: "chompy")

    expect(base.entity_stacks.count).to eq(Entity.count)
  end

  it "adds resource_stacks when created" do
    base = Base.create(name: "chompy")

    expect(base.resource_stacks.count).to eq(Resource.count)
  end

  it "adds Hub when created" do
    base = Base.create(name: "chompy")

    expect(base.building_units.where(type_id: 0)[0]).not_to be_nil
  end
end
