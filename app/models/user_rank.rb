class UserRank < ActiveRecord::Base
	has_one :user

	def self.update_user_ranks
		users = User.all
		users.each do |a_user|
			userRank = UserRank.find_or_create_by("id = ?", a_user.id)
			userRank.reset
			a_user.bases.each do |a_base|
				userRank.add_resource_stacks(a_base.resource_stacks)
			end
			userRank.save
		end
	end

	def reset
		total_resources = 0
		total_materials = 0
		total_money = 0
	end

	private

	def add_resource_stacks(resource_stacks)
		total_money += resource_stacks[0]
		total_materials += resource_stacks[1]
		total_resources += total_money + total_materials
	end
end
