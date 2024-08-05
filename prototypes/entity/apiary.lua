local ingredients = 
{
	{'steel-plate', 5},
	{'wood', 20},
	{'electronic-circuit', 4}
}

if mods.angelsbioprocessing then
	ingredients[2] = {'wood-bricks', 4}
end

if mods['aai-industry'] then
	ingredients[1] = {'stone-brick', 10}
end

data:extend(
{
    {
		type = 'item',
		name = 'apiary',
		icon = '__NPBees2__/graphics/icon/apiary.png',
		icon_size = 32,
		subgroup = 'bees-machine',
		order = 'a',
		place_result = 'apiary',
		stack_size = 50
	},
	{
		type = 'recipe',
		name = 'apiary',
		enabled = false,
		ingredients = ingredients,
		result = 'apiary',
		energy_required = 2.0,
	},
    {
    type = 'assembling-machine',
    name = 'apiary',
    icon = '__NPBees2__/graphics/icon/apiary.png',
	icon_size = 32,
    flags = {'placeable-neutral', 'placeable-player', 'player-creation'},
	minable = {hardness = 0.2, mining_time = 0.5, result = 'apiary'},
	max_health = 80,
    fast_replaceable_group = 'apiary',
    corpse = 'small-remnants',
	collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
	selection_box = {{-1.0, -1.0}, {1.0, 1.0}},	
    crafting_categories = {'bee-grow'},
	ingredient_count = 4,
    module_specification =
    {
      module_slots = 2
    },
    allowed_effects = {'consumption', 'speed', 'pollution', 'productivity'},
    result_inventory_size = 1,
    crafting_speed = 1,
    source_inventory_size = 1,
    resistances =
    {{
        type = 'fire',
        percent = -20
    }},
	fluid_boxes = {
		off_when_no_fluid_recipe = false,
		{
			production_type = 'input',
			base_area = 10,
			base_level = -1,
			pipe_connections = 
			{
				{type='input', position = {0.5, -1.5}},
				{type='input', position = {-0.5, -1.5}}
			},
			pipe_covers = pipecoverspictures(),
			},
			{
			production_type = 'output',
			base_level = 1,
			pipe_connections = 
			{
				{position = {0.5, 1.5}},
				{position = {-0.5, 1.5}}
			},
			pipe_covers = pipecoverspictures(),
		}
	},
    energy_source = {type = 'electric', input_priority = 'secondary', usage_priority = 'secondary-input'},
    energy_usage = '30kW',
	animation =	{
	  north =
      {
        filename = '__NPBees2__/graphics/entity/apiary-v2.png',
        width = 192,
        height = 192,
        frame_count = 1,
		shift = {0.25, -0.3125},
		scale = 0.5
      },
      east =
      {
        filename = '__NPBees2__/graphics/entity/apiary-h.png',
        width = 192,
        height = 192,
        frame_count = 1,
        shift = {0.25, -0.3125},
		scale = 0.5
      },
      south =
      {
        filename = '__NPBees2__/graphics/entity/apiary-v2.png',
        width = 192,
        height = 192,
        frame_count = 1,
        shift = {0.25, -0.3125},
		scale = 0.5
      },
      west =
      {
        filename = '__NPBees2__/graphics/entity/apiary-h.png',
        width = 192,
        height = 192,
        frame_count = 1,
        shift = {0.25, -0.3125},
		scale = 0.5
      },
	},
	working_sound = {
		sound = {
			filename = '__NPBees2__/sound/bee-machine.ogg'
		},
		audible_distance_modifier = 0.5
	},
	vehicle_impact_sound =  { filename = '__base__/sound/car-metal-impact.ogg', volume = 0.65 },
    repair_sound = { filename = '__base__/sound/manual-repair-simple.ogg' },
    open_sound = { filename = '__base__/sound/machine-open.ogg', volume = 0.85 },
    close_sound = { filename = '__base__/sound/machine-close.ogg', volume = 0.75 },
  },
})