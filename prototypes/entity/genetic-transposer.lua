local ingredients =
{
	{'steel-plate', 18},
	{'iron-gear-wheel', 15},
	{'electronic-circuit', 20}
}

if mods['aai-industry'] then
	ingredients[1][1] = 'stone-brick'
end

data:extend({
	{
		type = 'item',
		name = 'genetic-transposer',
		icon = '__NPBees2__/graphics/icon/genetic-transposer.png',
		icon_size = 32,
		subgroup = 'bees-machine',
		order = 'b',
		place_result = 'genetic-transposer',
		stack_size = 50
	},
	{
		type = 'recipe',
		name = 'genetic-transposer',
		enabled = false,
		ingredients = ingredients,
		result = 'genetic-transposer',
		energy_required = 5.0
	},
	{
		type = 'assembling-machine',
		name = 'genetic-transposer',
		icon = '__NPBees2__/graphics/icon/genetic-transposer.png',
		icon_size = 32,
		flags = {'placeable-neutral','placeable-player', 'player-creation'},
		minable = {hardness = 0.2, mining_time = 0.5, result = 'genetic-transposer'},
		max_health = 300,
		corpse = 'big-remnants',
		collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},	
		crafting_categories = {'g-transposer'},
		energy_usage = '4000kW',
		ingredient_count = 4,
		crafting_speed = 1,
		energy_source = {type = 'electric', input_priority = 'secondary', usage_priority = 'secondary-input', emissions = 0.01},
		open_sound = {filename = '__base__/sound/machine-open.ogg', volume = 0.85},
		close_sound = {filename = '__base__/sound/machine-close.ogg', volume = 0.75},
		module_specification = {module_slots = 2},
		allowed_effects = {'consumption', 'speed', 'productivity', 'pollution'},
		working_sound =
		{
			sound = {
				{
					filename = '__base__/sound/chemical-plant.ogg',
					volume = 0.8
				}   
			},
			idle_sound = {filename = '__base__/sound/idle1.ogg', volume = 0.6},
			apparent_volume = 1.5
		},
		animation =
		{
			filename = '__NPBees2__/graphics/entity/genetic-transposer.png',
			priority = 'medium', 
			width = 256, 
			height = 256, 
			frame_count = 16, 
			line_length = 8, 
			shift = {0.3, -0.5},
			scale = 0.5, 
			animation_speed = 1
		}
	}
})