class UserRank < ActiveRecord::Base
	belongs_to :user

	def self.update_user_ranks
		users = User.all
		users.each do |a_user|
			userRank = UserRank.find_or_create_by(user: a_user)
			userRank.reset
			a_user.bases.each do |a_base|
				userRank.add_resource_stacks(a_base.resource_stacks) # This is not useful anymore because now the ranking is by level

			end
			userRank.save
		end
	end

	def reset
		self.total_resources = 0
		self.total_materials = 0
		self.total_money = 0
	end

	def add_resource_stacks(resource_stacks)
		self.total_money += resource_stacks[0].amount
		self.total_materials += resource_stacks[1].amount
		self.total_resources += total_money + total_materials
	end

	def add_level_of_base(base)
		
	end

	def set_properties
		reset
		a_user.bases.each do |a_base|
				userRank.add_resource_stacks(a_base.resource_stacks) # This is not useful anymore because now the ranking is by level
				userRank.add_level_of_base(a_base)
			end
	end
end
