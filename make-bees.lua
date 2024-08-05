	-- find all ores
-- ignore some of them
local ignore_patterns = {}
ignore_patterns.name = {}
if mods["space-exploration"] then
	ignore_patterns.name["se%-core%-fragment"] = true
	ignore_patterns.name["se%-core%-fragment.*%-sealed$"] = true --only ignore sealed fragments
end

for name, resource in pairs(data.raw.resource) do
	local ignore = false
	for pattern in pairs(ignore_patterns.name) do
		if string.find(name, pattern) then
			ignore = true
			break
		end
	end

	if not ignore and resource.minable and (resource.minable.result or resource.minable.results) then
		beekeeping.from_resource{resource}
	end
end

-- add wood
for _, recipe in pairs(data.raw.recipe) do
	if recipe.name ~= 'deadlock-stacks-unstack-wood' then
		for _, result in ipairs(beekeeping.recipe_to_results(recipe)) do
			if result.name == 'wood' then
				goto nowood
			end
		end
	end
end	

beekeeping.from_item{
	data.raw.item['wood'],
	color = {153, 85, 61},
	queen_durability = 20,
	parents = {},
	parents = {beekeeping.species.copper, beekeeping.species.iron},
	level = 2
}
::nowood::

if mods.omnimatter then
	beekeeping.from_item{data.raw.item['omnicium-plate'], color={188, 25, 210}}
end

if mods.SeaBlock then
	beekeeping.from_item{data.raw.item['manganese-ore'], color={223, 75, 75}}
end

require 'prototypes.dynamic.item'
require 'prototypes.dynamic.recipe'
require 'prototypes.dynamic.technology'

if beekeeping.override == false then
	local problem = beekeeping.extend()
	if problem then
		return problem
	end
end
