local Icons = beekeeping.Icons
local Icon = beekeeping.Icon

beekeeping['beekeeping-1-effects'] = {}
beekeeping['beekeeping-2-effects'] = {}

local effects_1 = beekeeping['beekeeping-1-effects']
local effects_2 = beekeeping['beekeeping-2-effects']

for _, name in ipairs {
    'empty-syringe',
    'clean-queen-gen',
    'honey',
    'royal-jelly',
    'clean-comb',
    'clean-queen',
    'clean-bee'
} do
    effects_1[#effects_1 + 1] = name
end

data:extend{
    {
        name = 'empty-syringe',
        energy_required = 2,
        result = 'empty-syringe',
        ingredients = (mods.angelssmelting and
            {{type = 'item', name = 'iron-plate', amount = 5}, {type = 'item', name = 'angels-plate-glass', amount = 5}} or
            {{type = 'item', name = 'iron-plate', amount = 10}}),
        category = 'crafting',
        icon_size = 32,
        type = 'recipe',
        enabled = false
    },
    {
        name = 'clean-queen-gen',
        energy_required = 30,
        results = {
            {type = 'item', name = 'mutated-propolis', amount = 10},
            {type = 'item', name = 'clean-queen-10', amount = 1}
        },
        ingredients = (mods.angelsbioprocessing and
            {
                {type = 'item', name = 'cellulose-fiber', amount = 20},
                {type = 'item', name = 'automation-science-pack', amount = 10}
            } or
            {
                {type = 'item', name = 'iron-plate', amount = 10},
                {type = 'item', name = 'automation-science-pack', amount = 10}
            }),
        category = 'g-transposer',
        main_product = 'clean-queen-10',
        type = 'recipe',
        enabled = false
    },
    {
        name = 'honey',
        energy_required = 5,
        ingredients = {{type = 'item', name = 'clean-comb', amount = 20}},
        result = 'honey',
        result_count = 10,
        category = 'liquiformer',
        type = 'recipe',
        enabled = false
    },
    {
        name = 'royal-jelly',
        energy_required = 15,
        ingredients = {{type = 'item', name = 'clean-bee', amount = 1}},
        results = {{type = 'fluid', name = 'royal-jelly', amount = 25}},
        category = 'bee-grow',
        type = 'recipe',
        enabled = false
    },
    {
        name = 'clean-comb',
        energy_required = 10,
        ingredients = {{type = 'item', name = 'clean-bee', amount = 1}},
        results = {{type = 'item', name = 'clean-comb', amount = 10}},
        category = 'hive-1',
        type = 'recipe',
        enabled = false
    },
    {
        name = 'clean-queen',
        energy_required = 30,
        ingredients = {
            {type = 'item', name = 'clean-larva', amount = 1},
            {type = 'item', name = 'honey', amount = 20},
            {type = 'fluid', name = 'royal-jelly', amount = 50}
        },
        result = 'clean-queen-10',
        category = 'bee-grow',
        type = 'recipe',
        enabled = false
    },
    {
        name = 'clean-bee',
        energy_required = 10,
        ingredients = {{type = 'item', name = 'clean-larva', amount = 1}},
        result = 'clean-bee',
        category = 'bee-grow',
        main_product = 'clean-bee',
        type = 'recipe',
        enabled = false
    }
}

for i = 1, 10 do
    local results
    if i == 1 then
        results = {{type = 'item', name = 'clean-larva', amount = 1}}
    else
        results = {
            {type = 'item', name = 'clean-larva', amount = 1},
            {type = 'item', name = 'clean-queen-' .. (i - 1), amount = 1}
        }
    end

    data:extend{
        {
            name = 'clean-larva-' .. i,
            energy_required = 2,
            type = 'recipe',
            enabled = false,
            main_product = 'clean-larva',
            category = 'larva-hatching',
            subgroup = 'clean-bees',
            hidden = true,
            results = results,
            ingredients = {{type = 'item', name = 'clean-queen-' .. i, amount = 1}}
        }
    }
end
