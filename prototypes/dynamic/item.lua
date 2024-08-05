local Icons = beekeeping.Icons
local Icon = beekeeping.Icon

beekeeping.pattern['syringe'] = function(species)
	return {
		type = 'item',
		localised_name = {'item-name.syringe', species.localization},
		localised_description = {'item-description.syringe', species.localization},
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/syringe-fluid.png', icon_size = 32}:set_color(species.color),
			Icon:new{icon = '__NPBees2__/graphics/dynamic/syringe-base.png', icon_size = 32}
		},
		order = 'c',
		name = species.name .. '-gen',
		stack_size = 10,
		subgroup = species.subgroup_name
	}
end

beekeeping.pattern['bee'] = function(species)
	return {
		type = 'item',
		localised_name = {'item-name.bee', species.localization},
		localised_description = {'item-description.bee', species.localization},
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/bee-base.png', icon_size = 32},
			Icon:new{icon = '__NPBees2__/graphics/dynamic/bee-stripes.png', icon_size = 32}:set_color(species.color):lighten()
		},
		order = 'a',
		name = species.name .. '-bee',
		stack_size = 20,
		subgroup = species.subgroup_name
	}
end

beekeeping.pattern['larva'] = function(species)
	return {
		type = 'item',
		localised_name = {'item-name.larva', species.localization},
		localised_description = {'item-description.larva', species.localization},
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/larva-base.png', icon_size = 32},
			Icon:new{icon = '__NPBees2__/graphics/dynamic/larva-stripes.png', icon_size = 32}:set_color(species.color):lighten()
		},
		order = 'b',
		name = species.name .. '-larva',
		stack_size = 200,
		subgroup = species.subgroup_name
	}
end


beekeeping.pattern['queen'] = function(species)
	local prototypes = {}

	for i = 1, species.queen_durability do
		prototypes[#prototypes + 1] = {
			type = 'item',
			localised_name = {'item-name.queen', species.localization, i, species.queen_durability},
			localised_description = {'item-description.queen', species.localization},
			icons = Icons:new{
				Icon:new{icon = '__NPBees2__/graphics/dynamic/queen-base.png', icon_size = 32},
				Icon:new{icon = '__NPBees2__/graphics/dynamic/queen-stripes.png', icon_size = 32}:set_color(species.color):lighten()
			},
			order = 'd',
			name = species.name .. '-queen-' .. i,
			stack_size = 20,
			subgroup = species.subgroup_name
		}
	end
	
	return prototypes
end

beekeeping.pattern['comb'] = function(species)
	return {
		type = 'item',
		localised_name = {'item-name.comb', species.localization},
		localised_description = {'item-description.comb', species.localization},
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/comb.png', icon_size = 32}:set_color(species.color):lighten()
		},
		order = 'e',
		name = species.name .. '-comb',
		stack_size = 200,
		subgroup = species.subgroup_name
	}
end

beekeeping.pattern['mold'] = function(species)
	return {
		type = 'item',
		localised_name = {'item-name.mold', species.localization},
		localised_description = {'item-description.mold', species.localization},
		icons = Icons:new{
			Icon:new{icon = '__NPBees2__/graphics/dynamic/ore-mold-1.png', icon_size = 32}:set_color(species.color):lighten(),
			Icon:new{icon = '__NPBees2__/graphics/dynamic/ore-mold-2.png', icon_size = 32}:set_color(species.color):lighten(),
			Icon:new{icon = '__NPBees2__/graphics/dynamic/ore-mold-3.png', icon_size = 32}
		},
		order = 'f',
		name = species.name .. '-mold',
		stack_size = 100,
		subgroup = species.subgroup_name
	}
end

beekeeping.pattern['subgroup'] = function(species)
	return {
		type = 'item-subgroup',
		name = species.subgroup_name,
		group = 'beekeeping',
		order = 'dynamic-' .. tostring(species.level)
	}
end