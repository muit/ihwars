require 'rails_helper'
require 'pry'

RSpec.describe UserRank, :type => :model do
  describe 'orders by' do
  	before(:each) do
  		base1 = Base.create(name: "First's base")
  		base1.resource_stacks.first.amount += 500
  		base1.building_units << Bank.create(level: 4)
  		user1 = User.create(name: 'First', email: 'first@first.com', password: 'password')
  		user1.bases << base1

  		base2 = Base.create(name: "Second's base")
 			user2 = User.create(name: 'Second', email: 'second@first.com', password: 'password')
 			user2.bases << base2

 			UserRank.update_user_ranks
 			@ranks_by_resources = UserRank.order('total_resources DESC')
 			@ranks_by_level = UserRank.order('total_level DESC')
  	end

  	it 'total resources' do
  		expect(@ranks_by_resources.first.user.name).to eq('First')
  	end

  	it 'total level' do
  		expect(@ranks_by_level.first.user.name).to eq('First')
  	end
  end
end
