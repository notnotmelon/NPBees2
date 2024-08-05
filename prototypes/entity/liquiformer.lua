local machine_tiers = 2

local item = {
	type = 'item',
	name = 'liquiformer-',
	icon = '__NPBees2__/graphics/icon/liquiformer-',
	icon_size = 32,
	subgroup = 'bees-machine',
	order = 'b',
	place_result = 'liquiformer-',
	stack_size = 50
}

local recipe = {
	type = 'recipe',
    name = 'liquiformer-',
    enabled = false,
    result = 'liquiformer-',
	energy_required = 1.0
}

local buildingIngredients = {
	{
		{'stone-brick', 15},
		{'iron-gear-wheel', 20},
		{'electronic-circuit', 6}
    },
	{
		{'liquiformer-1', 1},
		{'engine-unit', 4},
		{'advanced-circuit', 10}
    }
}

if mods['aai-industry'] then
	buildingIngredients[2][#buildingIngredients[2] + 1] = {'concrete', 20}
end

local entity = {
	type = 'assembling-machine',
	name = 'liquiformer-',
	icon = '__NPBees2__/graphics/icon/liquiformer-',
	icon_size = 32,
	flags = {'placeable-neutral', 'placeable-player', 'player-creation'},
	minable = {hardness = 0.2, mining_time = 0.5},
	max_health = 300,
	corpse = 'big-remnants',
	collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
	selection_box = {{-1.5, -1.5}, {1.5, 1.5}},	
	crafting_categories = {'liquiformer'},
	ingredient_count = 4,
	fast_replaceable_group = 'liquiformer',
	energy_source = {type = 'electric', input_priority = 'secondary', usage_priority = 'secondary-input', emissions = 0.003},
	open_sound = {filename = '__base__/sound/machine-open.ogg', volume = 0.85},
	close_sound = {filename = '__base__/sound/machine-close.ogg', volume = 0.75},
	module_specification = {module_slots = 2},
	allowed_effects = {'consumption', 'speed', 'productivity', 'pollution'},
	working_sound = {
		sound = {{filename = '__base__/sound/chemical-plant.ogg', volume = 0.8}},
		idle_sound = {filename = '__base__/sound/idle1.ogg', volume = 0.6},
		apparent_volume = 1.5
	},
	animation =	{
		filename = '__NPBees2__/graphics/entity/liquiformer-',
		priority = 'medium', 
		width = 256, 
		height = 256, 
		frame_count = 16, 
		line_length = 8, 
		shift = {0.3, -0.5},
		scale = 0.5, 
		animation_speed = 0.5,
		run_mode = 'forward-then-backward'
	}
}

for i = 1, machine_tiers do
	local storage = table.deepcopy(item)
	storage.name = storage.name .. i
	storage.icon = storage.icon .. i .. '.png'
	storage.place_result = storage.place_result .. i
	data:extend({storage})
	storage = table.deepcopy(recipe)
	storage.name = storage.name .. i
	storage.ingredients = buildingIngredients[i]
	storage.result = storage.result .. i
	storage.energy_required = storage.energy_required * i
	data:extend({storage})
	storage = table.deepcopy(entity)
	storage.name = storage.name .. i
	storage.icon = storage.icon .. i .. '.png'
	storage.minable.result = storage.name
	storage.energy_usage = ((i / 2) + 1) * 150 .. 'kW'
	storage.crafting_speed = i / 2
	storage.animation.filename = storage.animation.filename .. i .. '.png'
	if i == 2 then
		storage.animation.frame_count = 24
	end
	data:extend({storage})
end