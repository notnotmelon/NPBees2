

data:extend(
{
  --Item
  {
    type = 'item',
    name = 'hive-1',
    icon = '__NPBees2__/graphics/icon/hive-1.png',
	icon_size = 32,
    subgroup = 'bees-machine',
    order = 'a',
    place_result = 'hive-1',
    stack_size = 50
  },
  --Recipe
    {
    type = 'recipe',
    name = 'hive-1',
    enabled = false,
    ingredients = 
    {
      {'steel-plate', 9},
	  {'stone', 3},
	  {'electronic-circuit', 8}

    },
    result = 'hive-1'
  },
  --Technology

  --Entity
    {
    type = 'assembling-machine',
		name = 'hive-1',
		icon = '__NPBees2__/graphics/icon/hive-1.png',
		icon_size = 32,
		flags = {'placeable-neutral','placeable-player', 'player-creation'},
		minable = {hardness = 0.2, mining_time = 0.5, result = 'hive-1'},
		max_health = 300,
		corpse = 'big-remnants',
		collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
		selection_box = {{-1.0, -1.0}, {1.0, 1.0}},	
		crafting_categories = {'hive-1'},
		energy_usage = '110kW',
		fast_replaceable_group = 'beehive',
        ingredient_count = 4,
        crafting_speed = 1,
        energy_source = {type = 'electric', input_priority = 'secondary', usage_priority = 'secondary-input'},
		open_sound = { filename = '__base__/sound/machine-open.ogg', volume = 0.85 },
        close_sound = { filename = '__base__/sound/machine-close.ogg', volume = 0.75 },
		module_specification =
		{
			module_slots = 2
		},
		allowed_effects = {'consumption', 'speed', 'productivity', 'pollution'},
        working_sound = {
			sound = {
				filename = '__NPBees2__/sound/bee-machine.ogg'
			},
			audible_distance_modifier = 0.5
		},
		animation=
		{
			filename = '__NPBees2__/graphics/entity/hive-1.png',
			priority = 'extra-high',
			width = 192,
			height = 192,
			frame_count = 1,
			scale=0.5,
			shift = {0.375, -0.375}
		},

	},
        
 }
)


