local Icons = beekeeping.Icons
local Icon = beekeeping.Icon

beekeeping.pattern['technology'] = function(species)
	local effects = {
		species.name .. '-queen-gen',
		species.name .. '-bee',
		species.name .. '-queen',
		species.name .. '-gen',
		species.name .. '-comb-1',
		species.name .. '-ore-1',
		species.name .. '-mold'
	}
	
	for i = 1, species.queen_durability do
		effects[#effects + 1] = species.name .. '-larva-' .. i
	end
	
	for i, effect in ipairs(effects) do
		effects[i] = {type = 'unlock-recipe', recipe = effect}
	end

	local prerequisites = species.prerequisites

	local science_packs = {
		{['automation-science-pack']=true},
		{['automation-science-pack']=true, ['logistic-science-pack']=true},
		{['automation-science-pack']=true, ['logistic-science-pack']=true, ['chemical-science-pack']=true},
		{['automation-science-pack']=true, ['logistic-science-pack']=true, ['chemical-science-pack']=true, ['production-science-pack']=true},
		{['automation-science-pack']=true, ['logistic-science-pack']=true, ['chemical-science-pack']=true, ['production-science-pack']=true}
	}
	science_packs = science_packs[species.level]
	
	local pack_count = {35, 50, 100, 200, 200}
	pack_count = pack_count[species.level]
	
	for _, prerequisite in ipairs(prerequisites) do
		local other_tech = data.raw.technology[prerequisite]
		
		if other_tech then
			local other_count = other_tech.unit.count
			if other_count then
				if other_count > pack_count then pack_count = other_count end
			end
		
			for _, ingredient in pairs(other_tech.unit.ingredients) do
				local name = ingredient.name or ingredient[1]
				if science_packs[name] == nil then
					science_packs[name] = true
				end
			end
		end
	end
	
	if pack_count > 400 then pack_count = 400 end
	
	local i = 1
	for pack, _ in pairs(science_packs) do
		science_packs[i] = {pack, 1}
		science_packs[pack] = nil
		i = i + 1
	end

	return {
		type = 'technology',
		name = 'bee-technology-' .. species.name,
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/bee-technology-stripes.png', icon_size = 128}:set_color(species.color):lighten(),
			Icon:new{icon = '__NPBees2__/graphics/dynamic/bee-technology-body.png', icon_size = 128}
		},
		effects = effects,
		unit = {
			count = pack_count,
			ingredients = science_packs,
			time = 30
		},
		order = 'q',
		name = 'bee-technology-' .. species.name,
		localised_name = {'technology-name.bee-research', species.localization},
		localised_description = {'technology-description.bee-research', species.localization},
		prerequisites = prerequisites
	}
end

local effects_1 = {
	{
		recipe = 'nursery',
		type = 'unlock-recipe'
	},
	{
		recipe = 'apiary',
		type = 'unlock-recipe'
	},
	{
		recipe = 'hive-1',
		type = 'unlock-recipe'
	},
	{
		recipe = 'liquiformer-1',
		type = 'unlock-recipe'
	},
	{
		recipe = 'genetic-transposer',
		type = 'unlock-recipe'
	},
	{
		recipe = 'sequencer',
		type = 'unlock-recipe'
	},
	{
		recipe = 'hive-2',
		type = 'unlock-recipe'
	}
}

for i = 1, 10 do
	effects_1[#effects_1 + 1] = {recipe = 'clean-larva-' .. i, type = 'unlock-recipe'}
end

for _, effect in ipairs(beekeeping['beekeeping-1-effects']) do
	effects_1[#effects_1 + 1] = {recipe = effect, type = 'unlock-recipe'}
end

local effects_2 = {
	{
		recipe = 'hive-3',
		type = 'unlock-recipe'
	},
	{
		recipe = 'propolis-ammo',
		type = 'unlock-recipe'
	},
	{
		recipe = 'liquiformer-2',
		type = 'unlock-recipe'
	}
}

for _, species in pairs(beekeeping.species) do
	effects_2[#effects_2 + 1] = {recipe = species.name .. '-comb-2', type = 'unlock-recipe'}
	if not species.required_fluid then
		effects_2[#effects_2 + 1] = {recipe = species.name .. '-ore-2', type = 'unlock-recipe'}
	end
end

for _, effect in ipairs(beekeeping['beekeeping-2-effects']) do
	effects_2[#effects_2 + 1] = {recipe = effect, type = 'unlock-recipe'}
end

data:extend{
	{
		type = 'technology',
		icon_size = 128,
		icon = '__NPBees2__/graphics/technology/beekeeping-1.png',
		name = 'beekeeping-1',
		prerequisites = {'automation-2', 'steel-processing'},
		effects = effects_1,
		unit = {
			count = 100,
			ingredients = {{'automation-science-pack', 1}},
			time = 10
		}
	},
	{
		type = 'technology',
		icon_size = 128,
		icon = '__NPBees2__/graphics/technology/beekeeping-2.png',
		name = 'beekeeping-2',
		prerequisites = {'beekeeping-1', 'advanced-material-processing-2'},
		effects = effects_2,
		unit = {
			count = 200,
			ingredients = {
				{'automation-science-pack', 1},
				{'logistic-science-pack', 1},
				{'chemical-science-pack', 1}
			},
			time = 30
		}
	}
}