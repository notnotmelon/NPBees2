if beekeeping.problem_in_data_updates then
	require("make-bees")

	if beekeeping.record_calculations then
		for i,layer in pairs(beekeeping.calculations) do
			log("calculation: "..i)
			local before_remaining = layer.before_remaining
			local before_tech_layers = layer.before_tech_layers
			local remaining = layer.remaining
			local tech_layers = layer.tech_layers

			--log("before_tech_layers "..serpent.block(before_tech_layers))
			--log("before_remaining "..serpent.block(before_remaining))
			--log("tech_layers "..serpent.block(tech_layers))
			--log("remaining "..serpent.block(remaining))

			local check_furthest_tech = false
			if check_furthest_tech then
				-- does not look useful
				if next(remaining) then
					local max_name = "no dependency completed"
					local max_level = 0
					for name,dependencies in pairs(remaining) do
						for dependency, level in pairs(dependencies) do
							if (level > max_level) and (level ~= (1/0)) then
								max_level = level
								max_name = name
							end
						end
					end
					log("max level and last tech finished: "..max_level.." "..max_name)
				else
					log("no remaining technology")
				end
			end
		end
	end
end