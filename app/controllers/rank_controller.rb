class RankController < ApplicationController
	before_action :authenticate_user!

	def rank
		# FIXME: no defined order. Decide and implement an order
		# FIXME: don't show all users, only the nearest ones
		@profile_id = current_user.id
		@ranks = UserRank.order('total_level DESC')

		if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
	end
end
