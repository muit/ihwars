class CombatSimulatorController < ApplicationController
	def simulator
		if params[:result].present?
			@resultsHash = params[:result]
		end

		if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
	end

	def run
		ally_units = []
		enemy_units = []

		result = simulate_combat(ally_units, enemy_units)

		if mobile_device?
      render :mobile, layout: "mobile", result: result
    else
      render :desktop, layout: "desktop", result: result
    end
	end
end
