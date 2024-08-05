local ingredients = {
    {'steel-plate', 15},
    {'iron-plate', 10},
    {'electronic-circuit', 6}
}

if mods['aai-industry'] then
    ingredients[2][1] = 'stone-brick'
end

data:extend{
	{
		type = 'item',
		name = 'nursery',
		icon = '__NPBees2__/graphics/icon/nursery.png',
		icon_size = 32,
		subgroup = 'bees-machine',
		order = 'a',
		place_result = 'nursery',
		stack_size = 50
	},
	{
		type = 'recipe',
		name = 'nursery',
		enabled = false,
		ingredients = ingredients,
		result = 'nursery',
		energy_required = 2.0
	},
	{
		type = 'furnace',
		name = 'nursery',
		icon = '__NPBees2__/graphics/icon/nursery.png',
		icon_size = 32,
		flags = {'placeable-neutral', 'placeable-player', 'player-creation'},
		minable = {mining_time = 1, result = 'nursery'},
		max_health = 100,
		corpse = 'big-remnants',
		collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		crafting_categories = {'larva-hatching'},
		module_specification = {
			module_slots = 2
		},
		allowed_effects = {'consumption', 'speed', 'pollution'},
		result_inventory_size = 2,
		crafting_speed = 1,
		source_inventory_size = 1,
		resistances = {
			{
				type = 'fire',
				percent = 80
			},
			{
				type = 'explosion',
				percent = 30
			}
		},
		energy_source = {
			type = 'electric',
			usage_priority = 'secondary-input'
		},
		energy_usage = '90kW',
		animation = {
			filename = '__NPBees2__/graphics/entity/nursery.png',
			priority = 'extra-high',
			width = 256,
			height = 256,
			frame_count = 1,
			scale = 0.5,
			shift = {0.375, -0.25}
		},
		working_sound = {
			sound = {
				filename = '__NPBees2__/sound/nursery.ogg'
			},
			audible_distance_modifier = 0.5
		},
		vehicle_impact_sound = {filename = '__base__/sound/car-metal-impact.ogg', volume = 0.65},
		repair_sound = {filename = '__base__/sound/manual-repair-simple.ogg'},
		open_sound = {filename = '__base__/sound/machine-open.ogg', volume = 0.85},
		close_sound = {filename = '__base__/sound/machine-close.ogg', volume = 0.75}
	}
}