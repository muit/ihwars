require 'rails_helper'

RSpec.describe Base, :type => :model do


  describe 'creating a base' do
    it "has a name" do
      base = Base.create(name: "chompy")
      expect(base.name).to eq('chompy')
    end

    it 'cannot be created without a name' do
      base = Base.new
      expect(base.valid?).to eq(false)
    end

    it 'has a hub by default' do
      base = Base.create(name: "chompy")

      expect(base.building_units.find_by_type("Hub")).not_to be_nil
    end
  end

  #it "adds entity_stacks when created" do
  #  base = Base.create(name: "chompy")

  #  expect(base.entity_stacks.count).to eq(Entity.count)
  #end

  #it "adds resource_stacks when created" do
  #  base = Base.create(name: "chompy")

  #  expect(base.resource_stacks.count).to eq(Resource.count)
  #end

  #it "adds Hub when created" do
  #end
end
