class UserRank < ActiveRecord::Base
	belongs_to :user

	def self.reload
		users = User.all
		users.each do |a_user|
			userRank = UserRank.find_or_create_by(user: a_user)
			userRank.set_properties
			userRank.save
		end

		order("total_level DESC").each_with_index do |a_rank, index|
			a_rank.update_attribute(:position, index + 1)
		end
	end

	def self.default(user)
		user = create(user: user)
		user.reset
	end

	def reset
		update_attribute(:total_resources, 0)
		update_attribute(:total_materials, 0)
		update_attribute(:total_money, 0)
		update_attribute(:total_level, 0)
	end

	def add_resource_stacks(resource_stacks)
		update_attribute(:total_resources, resource_stacks[0].amount)
		update_attribute(:total_materials, resource_stacks[1].amount)
		update_attribute(:total_money, total_money + total_materials)
	end

	def add_level_of_base(base)
		update_attribute(:total_level, base.get_level_points)
	end

	def set_properties
		reset
		user.bases.each do |a_base|
			add_resource_stacks(a_base.resource_stacks) # This is not useful anymore because now the ranking is by level
			add_level_of_base(a_base)
		end
	end
end
