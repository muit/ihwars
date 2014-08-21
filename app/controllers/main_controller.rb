class MainController < ApplicationController
	def index
		if user_signed_in?
			redirect_to base_path
		else
			redirect_to new_user_session_path
		end
	end
end
