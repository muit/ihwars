class CombatSimulatorController < ApplicationController
	def simulator
		if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
	end

	def run

	end
end
