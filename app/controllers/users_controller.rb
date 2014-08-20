class UsersController < ApplicationController
	def profile
		@user = User.where('id = ?', params[:id]).first

		if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
	end

	def attack
		enemy_base_index = params[:index].to_i
		ally_base_id = params[:from_base].to_i
		ally_base = Base.where('id = ?', ally_base_id).first
		@user = User.where('id = ?', params[:id]).first
		if @user.present?
			enemy_base = @user.bases[enemy_base_index]
			if enemy_base.present?
				if ally_base.present?
					@result = ally_base.attack_base(enemy_base)
				else
					@error = "Sorry, you do not have that base."
				end
			else
				@error = "Sorry, the user #{user.name} does not have that base."
			end
		else
			@error = "Sorry, the user you are trying to attack does not exist."
		end
	end
end
