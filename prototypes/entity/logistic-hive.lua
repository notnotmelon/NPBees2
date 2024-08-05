data:extend({
	{
		type = 'item',
		name = 'logistic-hive',
		icon = '__NPBees2__/graphics/icon/logistic-hive.png',
		icon_size = 32,
		subgroup = 'clean-bees',
		order = 'z',
		place_result = 'logistic-hive',
		stack_size = 20
	},
	{
		type = 'recipe',
		name = 'logistic-hive',
		energy_required = 5.0,
		enabled = false,
		ingredients = {
			{'roboport', 1},
			{'honey', 50},
			{'mutated-propolis', 100},
			{'steel-plate', 20}
		},
		result = 'logistic-hive'
	},
	{
		type = 'roboport',
		name = 'logistic-hive',
		icon = '__NPBees2__/graphics/icon/logistic-hive.png',
		icon_size = 32,
		flags = {'placeable-player', 'player-creation'},
		minable = {hardness = 0.2, mining_time = 0.5, result = 'logistic-hive'},
		max_health = 600,
		corpse = 'big-remnants',
		collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		resistances =
		{
			{
				type = 'fire',
				percent = 80
			},
			{
				type = 'impact',
				percent = 60
			}
		},
		dying_explosion = 'medium-explosion',
		energy_source =
		{
			type = 'electric',
			usage_priority = 'secondary-input',
			input_flow_limit = '1MW',
			buffer_capacity = '1MJ'
		},
		recharge_minimum = '1MJ',
		energy_usage = '10kW',
		charging_energy = '1kW',
		logistics_radius = 14.5,
		construction_radius = 14.5,
		charging_station_count = 1,
		charge_approach_distance = 8,
		robot_slots_count = 50,
		material_slots_count = 7,
		stationing_offset = {0, -1.25},
		charging_offsets = {},
		base = {
			filename = '__NPBees2__/graphics/entity/bee-hive-idle.png',
			width = 256,
			height = 256,
			shift = {0.4375, -0.53125},
			scale = 0.5,
		},
		base_patch = {
			filename = '__NPBees2__/graphics/nothing.png',
			priority = 'medium',
			width = 32,
			height = 32,
			frame_count = 1,
			shift = {0, 0}
		},
		base_animation = {
			filename = '__NPBees2__/graphics/entity/bee-hive.png',
			priority = 'medium',
			width = 256,
			height = 256,
			frame_count = 4,
			animation_speed = 0.05,
			shift = {0.4375, -0.53125},
			scale = 0.5,
		},
		door_animation_up = {
			filename = '__NPBees2__/graphics/nothing.png',
			priority = 'medium',
			width = 32,
			height = 32,
			frame_count = 1,
			shift = {0, 0}
		},
		door_animation_down = {
			filename = '__NPBees2__/graphics/nothing.png',
			priority = 'medium',
			width = 32,
			height = 32,
			frame_count = 1,
			shift = {0, 0}
		},
		recharging_animation = {
			filename = '__base__/graphics/entity/roboport/roboport-recharging.png',
			priority = 'high',
			width = 37,
			height = 35,
			frame_count = 16,
			scale = 1.5,
			animation_speed = 0.5
		},
		vehicle_impact_sound =  {filename = '__base__/sound/car-metal-impact.ogg', volume = 0.65},
		working_sound = {
			sound = {
				filename = '__NPBees2__/sound/logistic-bee.ogg',
				volume = 0.7
			},
			audible_distance_modifier = 0.5,
			max_sounds_per_type = 6
		},
		recharging_light = {intensity = 0.4, size = 5, color = {r = 1.0, g = 1.0, b = 1.0}},
		request_to_open_door_timeout = 15,
		spawn_and_station_height = -0.1,
		draw_logistic_radius_visualization = true,
		draw_construction_radius_visualization = false,
		circuit_wire_connection_point = {
			shadow = {green = {0.53125, -0.515625}, red = {0.75, -0.5625}},
			wire = {green = {0.453125, -0.609375}, red = {0.390625, -0.84375}}
		},
		circuit_connector_sprites = table.deepcopy(data.raw['roboport']['roboport']['circuit_connector_sprites']),
		circuit_wire_max_distance = 9,
		default_available_logistic_output_signal = {type = 'virtual', name = 'signal-X'},
		default_total_logistic_output_signal = {type = 'virtual', name = 'signal-Y'},
		default_available_construction_output_signal = {type = 'virtual', name = 'signal-Z'},
		default_total_construction_output_signal = {type = 'virtual', name = 'signal-T'},
	}
})

data:extend({{
	name = 'logistic-hive',
	prerequisites = {
		'beekeeping-2',
		'construction-robotics',
		'logistic-robotics',
		'production-science-pack'
	},
	effects = {
		{
			type = 'unlock-recipe',
			recipe = 'logistic-hive'
		},
		{
			type = 'unlock-recipe',
			recipe = 'bee-logistic'
		},
		{
			type = 'unlock-recipe',
			recipe = 'bee-construction'
		}
	},
	unit = {
		count = 300,
		ingredients = {
			{'automation-science-pack', 1},
			{'logistic-science-pack', 1},
			{'chemical-science-pack', 1}
		},
		time = 30
	},
	type = 'technology',
	icon_size = 128,
	icon = '__NPBees2__/graphics/technology/logistic-hive.png'
}})