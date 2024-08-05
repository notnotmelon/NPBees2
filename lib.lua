beekeeping.species = {}

beekeeping.price_defaults = {
	['wood'] = 20,
	['uranium-ore'] = 42,
	['crude-oil'] = 13,
	['coal'] = 6,
	['iron-ore'] = 10,
	['copper-ore'] = 9,
	['omnite'] = 10,
	['omnicium-plate'] = 26,
	['angels-ore1'] = 8,
	['angels-ore3'] = 7,
	['angels-ore5'] = 12,
	['angels-ore6'] = 13,
	['fissure'] = 18,
	['clowns-ore1'] = 30,
	['clowns-ore2'] = 25,
	['clowns-ore3'] = 22,
	['clowns-ore4'] = 18,
	['clowns-ore5'] = 20,
	['clowns-ore6'] = 20,
	['clowns-ore7'] = 25,
	['clowns-resource1'] = 12,
	['clowns-resource2'] = 13,
	['molybdenum-ore'] = 30,
	['sulfur-ore'] = 23,
	['manganese-ore'] = 21,
	['se-water-ice'] = 8,
	['se-vulcanite'] = 16,
	['se-vitamelange'] = 13,
	['se-naquium-ore'] = 72,
	['se-methane-ice'] = 11,
	['se-iridium-ore'] = 14,
	['se-holmium-ore'] = 12,
	['se-beryllium-ore'] = 13,
	['se-cryonite'] = 16
}

local function new(self, args, prototype)
	self.name = prototype.name
	self.subgroup_name = self.name .. '-bee-subgroup'
	self.prerequisites = args.prerequisites
	self.queen_durability = args.queen_durability
	self.parents = args.parents
	self.mutation_chance = args.mutation_chance
	self.level = args.level
	beekeeping.species[self.name] = self
end

function beekeeping.from_resource(args)
	local resource = args[1]
	local color = args.color
	local self = {}
	
	new(self, args, resource)
	
	if resource.minable then
		self.products = table.deepcopy(resource.minable.results)
		if self.products == nil then
			local result = resource.minable.result
			if result == nil then
				error(resource.name .. ' cannot be mined')
			end
			self.products = {{type='item', name = result, amount = (resource.minable.count or 1)}}
		end
	else
		error(resource.name .. ' cannot be mined')
	end
	
	for _, product in pairs(self.products) do
		if product.amount == nil then
			if product[2] then
				product.name = product[1]
				product.amount = product[2]
			else
				product.amount = math.ceil((product.amount_min + product.amount_max) / 2)
				product.amount_max = nil
				product.amount_min = nil
			end
		end
	
		if product.probability then
			product.amount = math.ceil(product.amount * product.probability)
		end
	
		if product.type == 'fluid' then
			product.amount = product.amount * 5
		end
	end
	
	self.required_fluid = resource.minable.required_fluid
	self.fluid_amount = resource.minable.fluid_amount
	if #self.products == 1 and self.products[1].type == 'fluid' then
		local fluid = data.raw.fluid[self.products[1].name]
		self.color = color or fluid.base_color
		if fluid.icons then
			self.icon = beekeeping.Icon:new(fluid.icons[1])
			self.icon.icon_size = self.icon.icon_size or fluid.icon_size
		else
			self.icon = beekeeping.Icon:new{icon=fluid.icon, icon_size=fluid.icon_size}
		end
	else
		self.color = color or resource.map_color
		if resource.icons then
			self.icon = beekeeping.Icon:new(resource.icons[1])
			self.icon.icon_size = self.icon.icon_size or resource.icon_size
		else
			self.icon = beekeeping.Icon:new{icon=resource.icon, icon_size=resource.icon_size}
		end
	end
	self.price = args.price or beekeeping.price_defaults[self.name] or 15
	self.localization = resource.localised_name or {'entity-name.' .. self.name}
	
	return self
end

function beekeeping.from_item(args)
	local item = args[1]
	local color = args.color
	local self = {}
	new(self, args, item)
	
	self.products = {{type='item', name=item.name, amount=1}}
	
	self.required_fluid = nil
	self.fluid_amount = nil
	if item.icons then
		self.icon = beekeeping.Icon:new(item.icons[1])
		self.icon.icon_size = self.icon.icon_size or item.icon_size
	else
		self.icon = beekeeping.Icon:new{icon=item.icon, icon_size=item.icon_size}
	end
	if color == nil then error('You need to set a color') end
	self.color = color
	self.price = beekeeping.price_defaults[self.name] or 15
	self.localization = item.localised_name or {'item-name.' .. self.name}
	
	return self
end

function beekeeping.from_fluid(args)
	local fluid = args[1]
	local color = args.color
	local self = {}
	new(self, args, fluid)
	
	self.products = {{type='fluid', name=fluid.name, amount=100}}
	
	self.required_fluid = nil
	self.fluid_amount = nil
	if fluid.icons then
		self.icon = beekeeping.Icon:new(fluid.icons[1])
		self.icon.icon_size = self.icon.icon_size or fluid.icon_size
	else
		self.icon = beekeeping.Icon:new{icon=fluid.icon, icon_size=fluid.icon_size}
	end
	self.color = color or fluid.base_color
	self.price = beekeeping.price_defaults[self.name] or 22
	self.localization = fluid.localised_name or {'fluid-name.' .. self.name}
	
	return self
end

function beekeeping.from_products(args)
	local main_product = args.main_product
	local products = args.products
	local color = args.color

	local self = {}
	new(self, args, main_product)
	
	self.products = products
	
	self.required_fluid = nil
	self.fluid_amount = nil
	if main_product.icons then
		self.icon = beekeeping.Icon:new(main_product.icons[1])
		self.icon.icon_size = self.icon.icon_size or main_product.icon_size
	else
		self.icon = beekeeping.Icon:new{icon=main_product.icon, icon_size=main_product.icon_size}
	end
	if main_product.type == 'fluid' then
		self.color = color or main_product.base_color
		self.localization = main_product.localised_name or {'fluid-name.' .. self.name}
	else
		self.color = color
		self.localization = main_product.localised_name or {'item-name.' .. self.name}
	end
	self.price = beekeeping.price_defaults[self.name] or 22
	
	return self
end

local function max(table)
	local best = next(table)
	best = table[best]
	for _, canadiate in pairs(table) do
		if canadiate > best then best = canadiate end
	end
	return best
end

function beekeeping.calcuate_meta()
	local meta_calculations
	if beekeeping.record_calculations then
		meta_calculations = {}
		beekeeping.calculations = beekeeping.calculations or {}
		beekeeping.calculations[#beekeeping.calculations + 1] = meta_calculations
	end

	local tech_layers = {}
	local remaining = {}
	for name, tech in pairs(data.raw.technology) do
		local no_prerequisites = true
		for _, prerequisites in pairs({
				(tech.normal and tech.normal.prerequisites) or nil,
				(tech.expensive and tech.expensive.prerequisites) or nil,
				tech.prerequisites
			}) do

			no_prerequisites = false
			if #prerequisites == 0 then
				tech_layers[name] = 1
			else
				remaining[name] = {}
				for _, p in pairs(prerequisites) do
					remaining[name][p] = -1
				end
			end
			break --use first difficulty found: normal -> expensive -> "both"
		end
		if no_prerequisites then
			tech_layers[name] = 1
		end
	end

	local tries = 0
	local max_tries = 1000
	if beekeeping.record_calculations then
		meta_calculations.before_tech_layers = table.deepcopy(tech_layers)
		meta_calculations.before_remaining = table.deepcopy(remaining)
	end

	while next(remaining) do
		tries = tries + 1
		if tries >= max_tries then break end
		local finished
		for name, prerequisites in pairs(remaining) do
			finished = true
			for prerequisite, layer in pairs(prerequisites) do
				if tech_layers[prerequisite] then
					prerequisites[prerequisite] = tech_layers[prerequisite] + 1
				elseif data.raw.technology[prerequisite] == nil then
					prerequisites[prerequisite] = math.huge
				elseif layer == -1 then
					finished = false
				end
			end
			if finished then
				tech_layers[name] = max(remaining[name])
				remaining[name] = nil
				break
			end
		end
	end

	if beekeeping.record_calculations then
		meta_calculations.remaining = table.deepcopy(remaining)
		meta_calculations.tech_layers = table.deepcopy(tech_layers)
	end

	if tries >= max_tries then
		log("could not resolve technologies within "..max_tries.." loops, quitting")
		return true --failed
	end

	for _, species in pairs(beekeeping.species) do
		local in_products = {}
		for _, product in ipairs(species.products) do
			in_products[product.name] = true
		end
		
		local prerequisites = {}
		species.layer = math.huge
		
		for _, recipe in pairs(data.raw.recipe) do
			if recipe.enabled ~= false and (not recipe.normal or recipe.normal.enabled ~= false) and (not recipe.expensive or recipe.expensive.enabled ~= false) then
				for _, result in ipairs(beekeeping.recipe_to_ingredients(recipe)) do
					if in_products[result.name] then
						if species.prerequisites then
							species.prerequisites_set_manually = true
						else
							species.prerequisites = {}
						end
						species.level = species.level or 1
						goto basic
					end
				end
			end
		end

		for name, tech in pairs(data.raw.technology) do
			if name ~= 'fluid-handling' and name:find('deadlock%-stacking%-.+') == nil and tech.effects then
				for _, effect in ipairs(tech.effects) do
					if effect.type == 'unlock-recipe' then
						local recipe = data.raw.recipe[effect.recipe]
						if recipe then
							for _, result in ipairs(beekeeping.recipe_to_ingredients(recipe)) do
								if in_products[result.name] then
									local this_layer = tech_layers[name]
									if this_layer < species.layer then
										species.layer = this_layer
										prerequisites = {name}
										goto nexttech
									elseif this_layer == species.layer then
										prerequisites[#prerequisites + 1] = name
										goto nexttech
									end
								end
							end
						end
					end
				end
			end
			::nexttech::
		end
		
		if species.prerequisites == nil then
			species.prerequisites = prerequisites
		else
			species.prerequisites_set_manually = true
		end
		
		::basic::
		
		if species.queen_durability == nil then
			species.queen_durability = math.min(18, math.floor(4 + math.sqrt(species.price / 2)) * 2)
		end
	end
	
	local min_layer = math.huge

	for _, species in pairs(beekeeping.species) do
		if species.layer < min_layer then
			min_layer = species.layer
		end
	end
	
	for _, species in pairs(beekeeping.species) do
		local prerequisites = species.prerequisites
		species.layer = species.layer - min_layer
	
		if species.level == nil then
			if next(prerequisites) then
				species.level = math.floor(4 * species.layer / (species.layer + 7)) + 2
			else
				species.level = 2
			end
		end
		
		if not species.prerequisites_set_manually then
			if species.level == 1 or species.level == 2 then
				prerequisites[#prerequisites + 1] = 'beekeeping-1'
			else
				prerequisites[#prerequisites + 1] = 'beekeeping-2'
			end
		end
		species.prerequisites_set_manually = nil
	end
	
	local individual_levels = {{}, {}, {}, {}, {}}
	local all_levels = {{}, {}, {}, {}, {}}
	for _, species in pairs(beekeeping.species) do
		local t
		for level=species.level, #all_levels do
			t = all_levels[level]
			t[#t + 1] = species
		end
		t = individual_levels[species.level]
		t[#t + 1] = species
	end

	for i = 2, #all_levels do
		for _, species in ipairs(individual_levels[i]) do
			if species.parents == nil then
				local sample = all_levels[i - 1]
				local sample_size = #sample
				if sample_size ~= 0 then
					if sample_size == 1 then
						species.parents = {sample[1]}
					else
						math.randomseed(species.level * species.queen_durability * species.price)
						local first = math.random(sample_size)
						local second = math.random(sample_size)
						while first == second do second = math.random(sample_size) end
						if i == 4 or i == 5 then
							local third = math.random(sample_size)
							while first == third or second == third do third = math.random(sample_size) end
							species.parents = {sample[first], sample[second], sample[third]}
						else
							species.parents = {sample[first], sample[second]}
						end
					end
				end
			end
		end
	end
	
	for _, species in pairs(beekeeping.species) do
		species.parents = species.parents or {}
	end
	
	for _, species in pairs(beekeeping.species) do
		local mutation_chances = {
			0.05,
			0.025,
			0.0005,
			0.0001,
			0.0001
		}
		species.mutation_chance = mutation_chances[species.level]
		
		for name, other in pairs(species.parents) do
			if other.mutation_chance then
				species.prerequisites[#species.prerequisites + 1] = 'bee-technology-' .. other.name
			else
				species.parents[name] = nil
			end
		end
	end
end

function beekeeping.remove_bees(bees)
	for _, name in pairs(bees) do
		beekeeping.species[name] = nil
	end
end

beekeeping.pattern = {}

function beekeeping.extend()
	local fail = beekeeping.calcuate_meta()
	if fail then
		return fail
	end

	local bee_data = {}
	for _, species in pairs(beekeeping.species) do
		for _, pattern in pairs(beekeeping.pattern) do
			local result = pattern(species)
			if result then
				if result.type then
					bee_data[#bee_data + 1] = result
				else
					data:extend(result)
				end
			end
		end
	end
	data:extend(bee_data)
end

function beekeeping.recipe_to_ingredients(recipe)
	local unit = recipe.normal or recipe.expensive or recipe
	local ingredients = {}
	for _, ingredient in pairs(unit.ingredients) do
		if ingredient.name then
			ingredients[#ingredients + 1] = ingredient
		else
			ingredients[#ingredients + 1] = {type = 'item', name = ingredient[1]}
		end
	end
	return ingredients
end

function beekeeping.recipe_to_results(recipe)
	local unit = recipe.normal or recipe.expensive or recipe
	if unit.result then
		return {{type = 'item', name = unit.result}}
	else
		results = {}
		for _, result in ipairs(results) do
			if result.name then
				results[#results] = result
			end
		end
		return results
	end
end

beekeeping.Icons = {icon_size=32}
beekeeping.Icon = {}

function beekeeping.Icons:new(icons)
	setmetatable(icons, self)
	self.__index = self
	return icons
end

function beekeeping.Icons:add_top(icon)
	self[#self + 1] = icon
end

function beekeeping.Icons:add_bottom(icon)
	table.insert(self, icon, 1)
end

function beekeeping.Icons:corner_icon(icon)
	local scale = 19
	local shift = {-10, -10}
	local size = icon.icon_size
	for _, icon in ipairs(self) do
		if icon.shift then
			x = icon.shift[1]
			y = icon.shift[2]
			if x == -10 and y == -10 then
				shift = {10, -10}
			elseif x == 10 and y == -10 then
				shift = {-10, 10}
			elseif x == -10 and y == 10 then
				shift = {10, 10}
			elseif x == 10 and y == 10 then
				error('You added too many corner icons')
			end
		end
	end
	
	self:add_top(beekeeping.Icon:new{icon=icon.icon, icon_size=size, scale=scale / size, shift=shift})
	return self
end

function beekeeping.Icons:corner_icons(icons)
	local scale = 19
	local shift = {-10, -10}
	for _, icon in ipairs(self) do
		if icon.shift then
			x = icon.shift[1]
			y = icon.shift[2]
			if x == -10 and y == -10 then
				shift = {10, -10}
			elseif x == 10 and y == -10 then
				shift = {-10, 10}
			elseif x == -10 and y == 10 then
				shift = {10, 10}
			elseif x == 10 and y == 10 then
				error('You added too many corner icons')
			end
		end
	end
	
	for _, icon in ipairs(icons) do
		self:add_top(beekeeping.Icon:new{icon=icon.icon, icon_size=icon.icon_size, scale=scale / icon.icon_size, shift=shift})
		if icon.tint then
			self[#self]:set_color(icon.tint)
		end
	end
	return self
end

function beekeeping.Icon:new(icon)
	icon = table.deepcopy(icon)
	setmetatable(icon, self)
	self.__index = self
	return icon
end

function beekeeping.Icon:set_color(color)
	color = {
		r=color.r or color[1] or 0,
		g=color.g or color[2] or 0,
		b=color.b or color[3] or 0,
		a=color.a or color[4] or 1,
	}
	if color.r > 1 or color.g > 1 or color.b > 1 then
		color.r = color.r / 255
		color.g = color.g / 255
		color.b = color.b / 255
	end
	self.tint = color
	
	return self:clamp_rgb()
end

function beekeeping.Icon:lighten()
	local tint = self.tint
	local constant = -self:rgb_average() + 0.2
	
	tint.r = tint.r + constant
	tint.g = tint.g + constant
	tint.b = tint.b + constant

	return self:clamp_rgb()
end

function beekeeping.Icon:clamp_rgb()
	local tint = self.tint
	if tint.r > 1 then tint.r = 1 end
	if tint.g > 1 then tint.g = 1 end
	if tint.b > 1 then tint.b = 1 end
	if tint.r < 0 then tint.r = 0 end
	if tint.g < 0 then tint.g = 0 end
	if tint.b < 0 then tint.b = 0 end
	
	return self
end

function beekeeping.Icon:rgb_average()
	local tint = self.tint
	return (tint.r + tint.g + tint.b) / 3
end

function beekeeping.productivity(recipe_name)
	for _, mod in pairs(data.raw.module) do
		if mod.effect.productivity and mod.effect.productivity.bonus and mod.effect.productivity.bonus > 0 and mod.limitation then
			mod.limitation[#mod.limitation + 1] = recipe_name
		end
	end
end