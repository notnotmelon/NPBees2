--1 Clean Bee = 5 Honey
--1 Clean Queen = 10 Larva
--1 Clean Larva = 1 Clean Bee
--1 Clean Bee = 25 Royal Jelly
--1 Clean Queen = 50 Honey
--1 Clean Queen = 250 Royal Jelly

--1 Ore Queen = 10 Ore Larva
--1 Ore Larva + 1 Honey = 1 Ore Bees
--1 Ore Queen + 2 Clean Bees = 10 Ore Bees
--1 Ore Bee + 1 Clean Bee = 25 Ore Combs (adv)
--1 Ore Queen + 12 Clean Bees = 250 Combs (adv)
--5 Ore Queen + 6 Clean Queen = 1250 Combs (adv)
--1 Ore Bee = 10 Combs (basic)
--1 Ore Queen + 2 Clean Bees = 100 Combs (basic)
--5 Ore Queen + 1 Clean Queen = 500 Combs (basic)

--Using the advanced recipes consumes the same amount of ore queens to create 2.5 times more ores, however it also uses 5 more clean queens

local Icons = beekeeping.Icons
local Icon = beekeeping.Icon

beekeeping.pattern['queen-generation'] = function(species)	
	local ingredients = {{type = 'item', name = species.name .. '-gen', amount = 1}}
	
	local mutation_chance
	if #species.parents == 0 then
		ingredients[#ingredients + 1] = {type = 'item', name = 'clean-queen-1', amount = 1}
	else
		mutation_chance = 1
		for _, parent in pairs(species.parents) do
			ingredients[#ingredients + 1] = {type = 'item', name=parent.name .. '-queen-1', amount = 1}
		end
	end

	return {
		type = 'recipe',
		name = species.name .. '-queen-gen',
		energy_required = 30,
		results = {
			{type = 'item', name = 'mutated-propolis', amount = species.price},
			{type = 'item', name = species.name .. '-queen-' .. species.queen_durability, amount = 1, probability = species.mutation_chance}
		},
		main_product = species.name .. '-queen-' .. species.queen_durability,
		ingredients = ingredients,
		category = 'g-transposer',
		enabled = false
	}
end

beekeeping.pattern['larva-hatching'] = function(species)
	local prototypes = {}

	for i = 1, species.queen_durability do
		local results
		if i == 1 then
			results = {
				{type = 'item', name = species.name .. '-larva', amount = 1}
			}
		else
			results = {
				{type = 'item', name = species.name .. '-larva', amount = 1},
				{type = 'item', name = species.name .. '-queen-' .. (i - 1), amount = 1}
			}
		end
	
		prototypes[#prototypes + 1] = {
			type = 'recipe',
			name = species.name .. '-larva-' .. i,
			energy_required = 2,
			ingredients = {{type = 'item', name = species.name .. '-queen-' .. i, amount = 1}},
			results = results,
			main_product = species.name .. '-larva',
			category = 'larva-hatching',
			enabled = false,
			hidden = true
		}
	end
	
	return prototypes
end

beekeeping.pattern['larva-growth'] = function(species)
	beekeeping.productivity(species.name .. '-bee')

	return {
		type = 'recipe',
		name = species.name .. '-bee',
		energy_required = 10,
		results = {{type = 'item', name = species.name .. '-bee', amount = 1}},
		ingredients = {
			{type = 'item', name = species.name .. '-larva', amount = 1},
			{type = 'item', name = 'honey', amount = 1}
		},
		category = 'bee-grow',
		enabled = false
	}
end

beekeeping.pattern['queen-growth'] = function(species)
	beekeeping.productivity(species.name .. '-queen')

	return {
		type = 'recipe',
		name = species.name .. '-queen',
		energy_required = 30,
		results = {{type = 'item', name = species.name .. '-queen-' .. species.queen_durability, amount = 1}},
		ingredients = {
			{type = 'item', name = species.name .. '-larva', amount = 1},
			{type = 'item', name = 'honey', amount = 5},
			{type = 'fluid', name = 'royal-jelly', amount = 25}
		},
		category = 'bee-grow',
		enabled = false
	}
end

beekeeping.pattern['syringe-production'] = function(species)
	beekeeping.productivity(species.name .. '-gen')

	local ingredients = table.deepcopy(species.products)
	for _, ingredient in ipairs(ingredients) do
		ingredient.amount = 40
	end
	ingredients[#ingredients + 1] = {type = 'item', name = 'mutated-propolis', amount = 20}
	ingredients[#ingredients + 1] = {type = 'item', name = 'empty-syringe', amount = 1}

	return {
		type = 'recipe',
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/syringe-fluid.png', icon_size = 32}:set_color(species.color),
			Icon:new{icon = '__NPBees2__/graphics/dynamic/syringe-base.png', icon_size = 32}
		}:corner_icon(species.icon),
		name = species.name .. '-gen',
		energy_required = 30,
		results = {{type = 'item', name = species.name .. '-gen', amount = 1}},
		ingredients = ingredients,
		category = 'g-maker',
		enabled = false
	}
end

beekeeping.pattern['comb-production-1'] = function(species)
	beekeeping.productivity(species.name .. '-comb-1')

	return {
		type = 'recipe',
		localised_name = {'recipe-name.comb-generation', species.localization},
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/comb.png', icon_size = 32}:set_color(species.color):lighten()
		},
		name = species.name .. '-comb-1',
		energy_required = 10,
		results = {{type = 'item', name = species.name .. '-comb', amount = 10}},
		ingredients = {{type = 'item', name = species.name .. '-bee', amount = 1}},
		category = 'hive-2',
		enabled = false
	}
end

beekeeping.pattern['comb-production-2'] = function(species)
	beekeeping.productivity(species.name .. '-comb-2')
	
	return {
		type = 'recipe',
		localised_name = {'recipe-name.comb-generation-2', species.localization},
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/comb.png', icon_size = 32}:set_color(species.color):lighten()
		}:corner_icon(Icon:new{icon = '__NPBees2__/graphics/icon/honey.png', icon_size = 32}),
		name = species.name .. '-comb-2',
		energy_required = 10,
		results = {{type = 'item', name = species.name .. '-comb', amount = 25}},
		ingredients = {
			{type = 'item', name = species.name .. '-bee', amount = 1},
			{type = 'item', name = 'honey', amount = 5}
		},
		category = 'hive-2',
		enabled = false
	}
end

beekeeping.pattern['ores-1'] = function(species)
	beekeeping.productivity(species.name .. '-ore-1')
	
	local products = table.deepcopy(species.products)
	for _, product in pairs(products) do
		product.amount = product.amount * 4
	end
	
	local icons = Icons:new{species.icon}
	local solution
	if species.required_fluid then
		local fluid = data.raw.fluid[species.required_fluid]
		if fluid.icons then
			icons:corner_icons(fluid.icons)
		else
			icons:corner_icon(Icon:new{icon=fluid.icon, icon_size=fluid.icon_size})
		end
		solution = {type = 'fluid', name = species.required_fluid, amount = species.fluid_amount}
	else
		solution = {type = 'fluid', name = 'water', amount = 20}
		icons:corner_icon(Icon:new{icon=data.raw.fluid['water'].icon, icon_size=data.raw.fluid['water'].icon_size})
	end

	return {
		type = 'recipe',
		localised_name = species.localization,
		icons = icons,
		order = 'g',
		name = species.name .. '-ore-1',
		subgroup = species.subgroup_name,
		energy_required = 1,
		allow_decomposition = false,
		results = products,
		ingredients = {
			{type = 'item', name = species.name .. '-mold', amount = 1},
			solution
		},
		category = 'crafting-with-fluid',
		enabled = false
	}
end

beekeeping.pattern['ores-2'] = function(species)
	if species.required_fluid then return end

	beekeeping.productivity(species.name .. '-ore-2')
	
	local fluid = data.raw.fluid[mods.angelsrefining and 'mineral-sludge' or 'sulfuric-acid']
	
	local products = table.deepcopy(species.products)
	for _, product in pairs(products) do
		product.amount = product.amount * 7
	end
	
	local icons = Icons:new{species.icon}
	if fluid.icons then
		icons:corner_icons(fluid.icons)
	else
		icons:corner_icon(Icon:new{icon=fluid.icon, icon_size=fluid.icon_size})
	end

	return {
		type = 'recipe',
		localised_name = species.localization,
		icons = icons,
		order = 'h',
		name = species.name .. '-ore-2',
		subgroup = species.subgroup_name,
		energy_required = 3,
		allow_decomposition = false,
		results = products,
		ingredients = {
			{type = 'item', name = species.name .. '-mold', amount = 1},
			{type = 'fluid', name = fluid.name, amount = 30}
		},
		category = 'crafting-with-fluid',
		enabled = false
	}
end

beekeeping.pattern['mold-production'] = function(species)
	beekeeping.productivity(species.name .. '-mold')

	return {
		type = 'recipe',
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/ore-mold-1.png', icon_size = 32}:set_color(species.color):lighten(),
			Icon:new{icon = '__NPBees2__/graphics/dynamic/ore-mold-2.png', icon_size = 32}:set_color(species.color):lighten(),
			Icon:new{icon = '__NPBees2__/graphics/dynamic/ore-mold-3.png', icon_size = 32}
		}:corner_icon(species.icon),
		name = species.name .. '-mold',
		energy_required = 2,
		results = {{type = 'item', name = species.name .. '-mold', amount = 1}},
		ingredients = {{type = 'item', name = species.name .. '-comb', amount = species.price}},
		category = 'liquiformer',
		enabled = false
	}
end