require 'rails_helper'

RSpec.describe UserRank, :type => :model do
  describe 'User rank orders by' do
  	before(:each) do
  		base1 = Base.create(name: "First's base")
  		base1.resource_stacks.create(type_id: 0, amount: 500)
  		base1.building_units.create(type_id: 1, level: 4)
  		user1 = User.create(name: 'First', bases: [base1])

  		base2 = Base.create(name: "Second's base")
 			user2 = User.create(name: 'Second', bases: [base2])

 			UserRank.update_user_ranks
 			ranks_by_resources = UserRank.order('total_resources DESC')
 			ranks_by_level = UserRank.order('total_level DESC')
  	end

  	it 'total resources' do
  		expect(ranks_by_resources.first.id).to be(1)
  	end

  	it 'total level' do
  		expect(ranks_by_level.first.id).to be(1)
  	end
  end
end
