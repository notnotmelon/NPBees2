data:extend {
	{
		type = 'item',
		name = 'empty-syringe',
		icon = '__NPBees2__/graphics/icon/empty-syringe.png',
		order = 'c',
		stack_size = 50,
		icon_size = 32,
		subgroup = 'clean-bees'
	},
	{
		type = 'item',
		name = 'mutated-propolis',
		icon = '__NPBees2__/graphics/icon/mutated-propolis.png',
		order = 'g',
		stack_size = 200,
		icon_size = 32,
		subgroup = 'clean-bees'
	},
	{
		type = 'item',
		name = 'clean-bee',
		icon = '__NPBees2__/graphics/icon/clean-bee.png',
		order = 'a',
		stack_size = 20,
		icon_size = 32,
		subgroup = 'clean-bees'
	},
	{
		type = 'item',
		name = 'clean-larva',
		icon = '__NPBees2__/graphics/icon/clean-larva.png',
		order = 'b',
		stack_size = 200,
		icon_size = 32,
		subgroup = 'clean-bees'
	},
	{
		type = 'item',
		name = 'clean-comb',
		icon = '__NPBees2__/graphics/icon/clean-comb.png',
		order = 'e',
		stack_size = 200,
		icon_size = 32,
		subgroup = 'clean-bees'
	},
	{
		type = 'fluid',
		name = 'royal-jelly',
		icon = '__NPBees2__/graphics/icon/royal-jelly.png',
		order = 'f',
		subgroup = 'clean-bees',
		icon_size = 32,
		default_temperature = 23,
		heat_capacity = '0.1KJ',
		base_color = {r = 240 / 255, g = 223 / 255, b = 100 / 255},
		flow_color = {r = 240 / 255, g = 223 / 255, b = 100 / 255},
		max_temperature = 100,
		pressure_to_speed_ratio = 0.4,
		flow_to_energy_ratio = 0.59,
		auto_barrel = true
	},
	{
		capsule_action = {
			attack_parameters = {
				activation_type = 'consume',
				ammo_category = 'capsule',
				ammo_type = {
					action = {
						action_delivery = {
							target_effects = {
								{
									damage = {
										amount = -100,
										type = 'physical'
									},
									type = 'damage'
								},
								{
									sound = {
										{
											filename = '__base__/sound/eat.ogg',
											volume = 0.6
										},
										{
											filename = '__base__/sound/eat-1.ogg',
											volume = 0.6
										},
										{
											filename = '__base__/sound/eat-2.ogg',
											volume = 0.6
										},
										{
											filename = '__base__/sound/eat-3.ogg',
											volume = 0.6
										},
										{
											filename = '__base__/sound/eat-4.ogg',
											volume = 0.6
										}
									},
									type = 'play-sound'
								}
							},
							type = 'instant'
						},
						type = 'direct'
					},
					category = 'capsule',
					target_type = 'position'
				},
				cooldown = 30,
				range = 0,
				type = 'projectile'
			},
			type = 'use-on-self'
		},
		name = 'honey',
		icon = '__NPBees2__/graphics/icon/honey.png',
		order = 'ea',
		stack_size = 200,
		type = 'capsule',
		icon_size = 32,
		subgroup = 'clean-bees'
	},
	{
		type = 'recipe',
		name = 'propolis-ammo',
		enabled = false,
		energy_required = 2,
		ingredients =
		{
			{'iron-plate',       2},
			{'mutated-propolis', 4}
		},
		result = 'propolis-ammo',
		subgroup = 'bees-machine',
		category = 'crafting',
		order = 'y'
	},
	{
		type = 'ammo',
		name = 'propolis-ammo',
		icon = '__NPBees2__/graphics/icon/propolis-ammo.png',
		icon_size = 32,
		ammo_type = {
			category = 'bullet',
			action =
			{
				type = 'direct',
				action_delivery =
				{
					type = 'instant',
					source_effects =
					{
						type = 'create-explosion',
						entity_name = 'explosion-gunshot'
					},
					target_effects =
					{
						{
							type = 'create-entity',
							entity_name = 'explosion-hit'
						},
						{
							type = 'damage',
							damage = {
								amount = 12,
								type = 'physical'
							}
						}
					}
				}
			}
		},
		magazine_size = 35,
		subgroup = 'bees-machine',
		order = 'y',
		stack_size = 200
	}
}

for i = 1, 10 do
	data:extend {{
		order = 'd',
		type = 'item',
		icon = '__NPBees2__/graphics/icon/clean-queen.png',
		icon_size = 32,
		localised_name = {'item-name.queen', {'clean'}, i, 10},
		localised_description = {'item-description.queen', {'clean'}},
		name = 'clean-queen-' .. i,
		subgroup = 'clean-bees',
		stack_size = 20
	}}
end
