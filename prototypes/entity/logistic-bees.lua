local logisticIngredients =
{
	{'clean-bee', 1},
	{'mutated-propolis', 20}
}

local constructionIngredients =
{
	{'clean-bee', 1},
	{'mutated-propolis', 20}
}

if mods.boblogistics then
	logisticIngredients[#logisticIngredients + 1] = {'robot-brain-logistic-2', 1}
	constructionIngredients[#constructionIngredients + 1] = {'robot-brain-construction-2', 1}
end

if mods.angelsbioprocessing then
	logisticIngredients[#logisticIngredients + 1] = {'alien-bacteria', 3}
	constructionIngredients[#constructionIngredients + 1] = {'alien-bacteria', 3}
end

data:extend({
	{
		type = 'item',
		name = 'bee-logistic',
		icon = '__NPBees2__/graphics/icon/bee-logistic.png',
		icon_size = 32,
		place_result = 'bee-logistic',
		subgroup = 'clean-bees',
		order = 'x',
		stack_size = 2
	},
	{
		type = 'recipe',
		name = 'bee-logistic',
		energy_required = 3.0,
		enabled = false,
		ingredients = logisticIngredients,
		result = 'bee-logistic',
		subgroup = 'clean-bees',
		order = 'x',
		category = 'g-transposer'
	},
	{
		type = 'logistic-robot',
		name = 'bee-logistic',
		icon = '__NPBees2__/graphics/icon/bee-logistic.png',
		icon_size = 32,
		flags = {'placeable-player', 'player-creation', 'placeable-off-grid', 'not-on-map'},
		minable = {hardness = 0.1, mining_time = 0.1, result = 'bee-logistic'},
		max_health = 250,
		resistances = {
			{type = 'fire', percent = 85},
			{type = 'physical', decrease = 10, percent = 40},
		},		
		collision_box = {{0, 0}, {0, 0}},
		selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
		max_payload_size = 1,
		speed = 0.03,
		transfer_distance = 0.5,
		max_energy = '0.5MJ',
		energy_per_tick = '0kJ',
		speed_multiplier_when_out_of_energy = 1,
		energy_per_move = '0kJ',
		min_to_charge = 0.2,
		max_to_charge = 0.9,
		idle = {
			filename = '__NPBees2__/graphics/entity/bee-logistic.png',
			priority = 'high',
			line_length = 2,
			width = 80,
			height = 80,
			frame_count = 2,
			shift = {0,0},
			scale = 0.5,
			direction_count = 16,		
			animation_speed = 0.3,			
		},
		idle_with_cargo = {
			filename = '__NPBees2__/graphics/entity/bee-logistic.png',
			priority = 'high',
			line_length = 2,
			width = 80,
			height = 80,
			frame_count = 2,
			shift = {0,0},
			scale = 0.5,
			direction_count = 16,		
			animation_speed = 0.3,		
		},
		in_motion  = 
		{
			filename = '__NPBees2__/graphics/entity/bee-logistic.png',
			priority = 'high',
			line_length = 2,
			width = 80,
			height = 80,
			frame_count = 2,
			shift = {0,0},
			scale = 0.5,
			direction_count = 16,		
			animation_speed = 0.3,		
		},
		in_motion_with_cargo  = 
		{
			filename = '__NPBees2__/graphics/entity/bee-logistic.png',
			priority = 'high',
			line_length = 2,
			width = 80,
			height = 80,
			frame_count = 2,
			shift = {0,0},
			scale = 0.5,
			direction_count = 16,		
			animation_speed = 0.3,			
		},
		shadow_idle = table.deepcopy(data.raw['logistic-robot']['logistic-robot']['shadow_idle']),
		shadow_idle_with_cargo = table.deepcopy(data.raw['logistic-robot']['logistic-robot']['shadow_idle_with_cargo']),
		shadow_in_motion = table.deepcopy(data.raw['logistic-robot']['logistic-robot']['shadow_in_motion']),
		shadow_in_motion_with_cargo = table.deepcopy(data.raw['logistic-robot']['logistic-robot']['shadow_in_motion_with_cargo']),
		working_sound = {
			sound = {
				filename = '__NPBees2__/sound/logistic-bee.ogg'
			},
			audible_distance_modifier = 0.5,
			probability = 1 / (3 * 60)
		},
		cargo_centered = {0.0, 0.2},
	},
	{
		type = 'item',
		name = 'bee-construction',
		icon = '__NPBees2__/graphics/icon/bee-construction.png',
		icon_size = 32,
		place_result = 'bee-construction',
		subgroup = 'clean-bees',
		order = 'x',
		stack_size = 2
	},
	{
		type = 'recipe',
		name = 'bee-construction',
		energy_required = 3.0,
		enabled = false,
		ingredients = constructionIngredients,
		result = 'bee-construction',
		subgroup = 'clean-bees',
		order = 'x',
		category = 'g-transposer'
	},
	{
		type = 'construction-robot',
		name = 'bee-construction',
		icon = '__NPBees2__/graphics/icon/bee-construction.png',
		icon_size = 32,
		flags = {'placeable-player', 'player-creation', 'placeable-off-grid', 'not-on-map'},
		minable = {hardness = 0.1, mining_time = 0.1, result = 'bee-construction'},
		resistances = { 
			{type = 'fire', percent = 85},
			{type = 'physical', decrease = 10, percent = 40},		
		},
		max_health = 250,
		collision_box = {{0, 0}, {0, 0}},
		selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
		max_payload_size = 1,
		speed = 0.03,
		transfer_distance = 0.5,
		max_energy = '0.5MJ',
		energy_per_tick = '0kJ',
		speed_multiplier_when_out_of_energy = 1,
		energy_per_move = '0kJ',
		min_to_charge = 0.2,
		max_to_charge = 0.9,
		working_light = {intensity = 0.8, size = 3, color = {r = 0.8, g = 0.8, b = 0.8}},
		idle = {
			filename = '__NPBees2__/graphics/entity/bee-construction.png',
			priority = 'high',
			line_length = 2,
			width = 80,
			height = 80,
			frame_count = 2,
			shift = {0,0},
			scale = 0.5,
			direction_count = 16,		
			animation_speed = 0.3,	
		},
		in_motion = {
			filename = '__NPBees2__/graphics/entity/bee-construction.png',
			priority = 'high',
			line_length = 2,
			width = 80,
			height = 80,
			frame_count = 2,
			shift = {0,0},
			scale = 0.5,
			direction_count = 16,		
			animation_speed = 0.3,	
		},
		shadow_idle = table.deepcopy(data.raw['construction-robot']['construction-robot']['shadow_idle']),
		shadow_in_motion = table.deepcopy(data.raw['construction-robot']['construction-robot']['shadow_in_motion']),
		working  = 
		{
			filename = '__NPBees2__/graphics/entity/bee-construction.png',
			priority = 'high',
			line_length = 2,
			width = 80,
			height = 80,
			frame_count = 2,
			shift = {0,0},
			scale = 0.5,
			direction_count = 16,		
			animation_speed = 0.3,	
		},
		shadow_working = {
			stripes = util.multiplystripes(2, {{
				filename = '__base__/graphics/entity/construction-robot/construction-robot-shadow.png',
				width_in_frames = 16,
				height_in_frames = 1,
			}}),
			priority = 'high',
			width = 50,
			height = 24,
			frame_count = 2,
			shift = {1.09375, 0.59375},
			direction_count = 16
		},
		smoke = {
			filename = '__base__/graphics/entity/smoke-construction/smoke-01.png',
			width = 39,
			height = 32,
			frame_count = 19,
			line_length = 19,
			shift = {0.078125, -0.15625},
			animation_speed = 0.3
		},
		sparks = {
			{
				filename = '__base__/graphics/entity/sparks/sparks-01.png',
				width = 39,
				height = 34,
				frame_count = 19,
				line_length = 19,
				shift = {-0.109375, 0.3125},
				tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
				animation_speed = 0.3
			},
			{
				filename = '__base__/graphics/entity/sparks/sparks-02.png',
				width = 36,
				height = 32,
				frame_count = 19,
				line_length = 19,
				shift = {0.03125, 0.125},
				tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
				animation_speed = 0.3
			},
			{
				filename = '__base__/graphics/entity/sparks/sparks-03.png',
				width = 42,
				height = 29,
				frame_count = 19,
				line_length = 19,
				shift = {-0.0625, 0.203125},
				tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
				animation_speed = 0.3
			},
			{
				filename = '__base__/graphics/entity/sparks/sparks-04.png',
				width = 40,
				height = 35,
				frame_count = 19,
				line_length = 19,
				shift = {-0.0625, 0.234375},
				tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
				animation_speed = 0.3
			},
			{
				filename = '__base__/graphics/entity/sparks/sparks-05.png',
				width = 39,
				height = 29,
				frame_count = 19,
				line_length = 19,
				shift = {-0.109375, 0.171875},
				tint = {r = 1, g = 0.9, b = 0, a = 1},
				animation_speed = 0.3
			},
			{
				filename = '__base__/graphics/entity/sparks/sparks-06.png',
				width = 44,
				height = 36,
				frame_count = 19,
				line_length = 19,
				shift = {0.03125, 0.3125},
				tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
				animation_speed = 0.3
			},
		},
		working_sound = {
			sound = {filename = '__NPBees2__/sound/logistic-bee.ogg'},
			audible_distance_modifier = 0.5,
			probability = 1 / (3 * 60),
			max_sounds_per_type = 3
		},
		cargo_centered = {0.0, 0.2},
		construction_vector = {0.30, 0.22},
	},
})