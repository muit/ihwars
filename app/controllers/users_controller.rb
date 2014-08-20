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

	end
end
