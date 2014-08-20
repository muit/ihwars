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
<<<<<<< HEAD
=======
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
>>>>>>> 0cf7698... Fixed
    it 'is a tie if both teams have the same (small) force' do
      # This may not be true with a bigger force
      ally_base = Base.new(entity_stacks: [EntityStack.new(type_id: 0, amount: 5)])
      enemy_base = Base.new(entity_stacks: [EntityStack.new(type_id: 0, amount: 5)])

      result = ally_base.attack_base(enemy_base)

      expect(result[:remaining_ally_units]).to eq(result[:remaining_enemy_units])
    end

    it 'wins a team if its much more powerful' do
      ally_base = Base.new(entity_stacks: [EntityStack.new(type_id: 6, amount: 5)])
      enemy_base = Base.new(entity_stacks: [EntityStack.new(type_id: 0, amount: 5)])

      result = ally_base.attack_base(enemy_base)

      expect(result[:remaining_ally_units].length).to eq(1)
      expect(result[:remaining_enemy_units].length).to eq(0)
    end

    it 'loses a team if its much less powerful' do
      ally_base = Base.new(entity_stacks: [EntityStack.new(type_id: 0, amount: 5)])
      enemy_base = Base.new(entity_stacks: [EntityStack.new(type_id: 6, amount: 5)])

      result = ally_base.attack_base(enemy_base)

      expect(result[:remaining_ally_units].length).to eq(0)
      expect(result[:remaining_enemy_units].length).to eq(1)
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
