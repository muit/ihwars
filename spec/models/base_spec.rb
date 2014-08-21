require 'rails_helper'
require 'pry'

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

  describe 'fighting!' do
    context 'regression test' do
      before do
        @ally_base = Base.create!(name: 'Allies')
        @enemy_base = Base.create!(name: 'Nazis')
      end

      it 'fails' do
        [@ally_base, @enemy_base].each { |b| b.entity_stacks.first.update_attribute(:amount, 100) }

        @ally_base.attack_base(@enemy_base)
      end

      it 'zero units' do
        @ally_base.attack_base(@enemy_base)
      end
    end

    it 'is a tie if both teams have the same (small) force' do
      # This may not be true with a bigger force
      ally_base = Base.create(name: 'A')
      enemy_base = Base.create(name: 'B')
      ally_base.entity_stacks.first.update_attribute(:amount, 10)
      enemy_base.entity_stacks.first.update_attribute(:amount, 10)

      result = ally_base.attack_base(enemy_base)

      expect(ally_base.entity_stacks.first.amount).to eq(0)
      expect(enemy_base.entity_stacks.first.amount).to eq(0)
    end

    it 'wins a team if its much more powerful' do
      ally_base = Base.create(name: 'A')
      enemy_base = Base.create(name: 'B')
      ally_base.entity_stacks.last.update_attribute(:amount, 10)
      enemy_base.entity_stacks.first.update_attribute(:amount, 10)

      result = ally_base.attack_base(enemy_base)

      expect(ally_base.entity_stacks.last.amount).to be > 0
      expect(enemy_base.entity_stacks.first.amount).to eq(0)
    end

    it 'loses a team if its much less powerful' do
      ally_base = Base.create(name: 'A')
      enemy_base = Base.create(name: 'B')
      ally_base.entity_stacks.first.update_attribute(:amount, 10)
      enemy_base.entity_stacks.last.update_attribute(:amount, 10)

      result = ally_base.attack_base(enemy_base)

      expect(ally_base.entity_stacks.first.amount).to eq(0)
      expect(enemy_base.entity_stacks.last.amount).to be > 0
    end

    it 'both bases should end with all entity stacks, which can be empty or not' do
      ally_base = Base.create(name: 'A')
      enemy_base = Base.create(name: 'B')
      ally_base.entity_stacks.first.update_attribute(:amount, 10)
      enemy_base.entity_stacks.last.update_attribute(:amount, 10)

      expected_stacks = EntityType.count
      result = ally_base.attack_base(enemy_base)

      expect(ally_base.entity_stacks.count).to eq(expected_stacks)
      expect(enemy_base.entity_stacks.count).to eq(expected_stacks)
    end
  end

  describe 'has a punctuations depending of its level' do
    it 'has only the Hub' do
      base = Base.create(name: "Test")
      expect(base.get_level_points).to eq(15)
    end
    
    it 'has a couple of buildings with different levels' do
      base = Base.create(name: "Test", building_units: [Bank.new(level: 3), Server.new(level: 4)])
      expect(base.get_level_points).to eq(70)
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
