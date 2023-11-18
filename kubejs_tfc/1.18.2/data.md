---
layout: page
title: Custom Data
permalink: /kubejs_tfc/1.18.2/data/
---

KubeJS TFC allows users to easily write some of TFC's [custom data](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/) types without having to directly write json files

In the `tfc.data` event there are methods for:

- [Damage Resistances](#damage-resistances)
  - [Item](#item-resistances)
  - [Entity](#entity-resistances)
- [Drinkables](#drinkables)
- [Fertilizers](#fertilizers)
- [Food Items](#food-items)
- [Fuels](#fuels)
- [Heats](#heats)
- [Item Size](#item-size)
- [Lamp fuels](#lamp-fuels)
- [Metals](#metals)
- [Supports](#supports)
- [Sluicing](#sluicing)
- [Panning](#panning)
- [Climate Ranges](#climate-ranges)
- [Fauna](#fauna)

There is also support for [FirmaLife](https://modrinth.com/mod/firmalife) and [Beneath](https://github.com/eerussianguy/Beneath/tree/v1.0.3-alpha) custom data types as well

- [FirmaLife Greenhouses](#greenhouses)
- [FirmaLife Plantables](#plantables)
- [Beneath Nether Fertilizers](#nether-fertilizers)

Additionally, the ability to to access and manipulate some of the non-datapack accessable TFC adds to the player can be accessed from a `PlayerJS` object in scripts. See [here](#attached-tfc-data) for specifics

# Damage Resistances

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#damage-resistances)!

TFC has two different types of damage resistance, item and entity

## Item Damage Resistance

- 1st argument: An item ingredient, which the resistances will apply to
- 2nd argument: A string which determines the resistances and their values
  - The format is `p=20, crushing=40`; the different types of damage *must* be separated by commas, negative values are allowed, and the types may be shortened to just their first letter:
    - piercing/p
    - slashing/s
    - crushing/c
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the resistance, if not provided a name will be automatically generated based on the ingredient

### Example
```js
// Gives diamond leggings very high resistance against piercing and a slight weakness against crushing
onEvent('tfc.data', event => {
    event.addTFCItemDamageResistance('minecraft:diamond_leggings', 'p=1000000, c=-50')
})
```

## Entity Damage Resistance

- 1st argument: An entity tag, which the resistances will apply to
- 2nd argument: A string which determines the resistances and their values
  - The format is `p=20, crushing=40`; the different types of damage *must* be separated by commas, negative values are allowed, and the types may be shortened to just their first letter:
    - piercing/p
    - slashing/s
    - crushing/c
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the resistance, if not provided a name will be automatically generated based on the ingredient

### Example
```js
// Makes land prey slightly strong against crushing damage and weak towards piercing damage
onEvent('tfc.data', event => {
    event.addTFCEnttiyDamageResistance('tfc:land_prey', 'c=20, p=-3000')
})
```

# Drinkables

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#drinkables)!

- 1st argument: A [fluid ingredient](<wrappers#fluid-stack-ingredient>), the fluid(s) which this drinkable data will apply to
- 2nd argument: A consumer with several methods:
  - `consumeChance(number)`: Accepts a number, in the range [0, 1], and sets the chance a fluid block will be consumed, defaults to 0
  - `thirst(integer)`: Accepts an integer, in the range [0, 100], and sets how much thirst is consumed per 25mB drank, defaults to 0
  - `intoxication(integer)`: Accepts an integer, and sets the number of ticks a player will be intoxicated for, per 25mB drank, defaults to 0
  - `effect`
    - 1st argument: A string representing an effect that will be applied to the player when drinking. A full list of available effects can be attained by running the command `/kubejs dump_registry minecraft:mob_effect` in-game
    - *optional 2nd argument*: A consumer with several methods:
      - `duration(integer)`: Accepts an integer and sets the number of ticks the effects will be apllied for, defaults to 20
      - `amplifier(integer)`: Accepts an integer and sets the level of the effect applied, defaults to 0
      - `chance(number)`: Accepts a number, in the range [0, 1], and sets the chance the effect will be applied per 25mB drank, defaults to 1
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the drinkable, if not provided a name will be automatically generated based on the fluid ingredient

## Example
```js
// Makes spring water drinkable, with a consume chance of 0.5, giving 2 thirst, and applying the thirst and glowing effects
onEvent('tfc.data', event => {
    event.addTFCDrinkable('tfc:spring_water', e => {
        e.consumeChance(0.5)
        e.thirst(2)
        e.effect('minecraft:glowing', e => {
            e.duration(10)
        })
       e.effect('tfc:thirst')
})
```

# Fertilizers

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#fertilizers)!

- 1st argument: An item ingredient which the fertilizer values will apply to
- 2nd argument: A string which describes the fertilizer types and their values
  - The format is `n=0.2, p=0.5`; the different types *must* be separated by commas and the types may be shorted to their chemical symbol:
    - nitrogen/n
    - phosphorous/p
    - potassium/k
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the fertilizer, if not provided a name will be automatically generated based on the ingredient

## Example
```js
// Make coarse dirt apply 50% of every fertilizer type
onEvent('tfc.data', event => {
    event.addTFCFertilizer('minecraft:coarse_dirt', 'n=0.5, p=0.5, k=0.5')
})
```

# Food Items

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#food-items)!

- 1st argument: An ingredient, the item(s) the which this food item data will apply to
- 2nd argument: A consumer with several methods:
  - `type(sting)`: Accepts either `dynamic` or `dynamic_bowl`, if either of those are provided the values below will be ignored. This is primarily used for meals, see the dynamic foods note [here](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#food-items)
  - `hunger(integer)`: Accepts an integer and defines how much hunger the ingredient restores, defaults to 4
    - The player's full hunger bar is equal to 20
  - `saturation(number)`: Accepts a number and defines how much saturation the ingredient restores, defaults to 0
  - `water(number)`: Accepts a number and defines how much water the ingredient restores, defaults to 0
    - The player's full water bar is equal to 100
  - `decayModifier(number)`: Accepts a number and defines how quickly the ingredient decays, defaults to 1
    - A higher value means a faster decay and shorter expiration time
  - `grain(number)`: Accepts a number and defines how much of the grain nutrient the ingredient provides, defaults to 0
  - `fruit(number)`: Accepts a number and defines how much of the fruit nutrient the ingredient provides, defaults to 0
  - `vegetables(number)`: Accepts a number and defines how much of the vegetables nutrient the ingredient provides, defaults to 0
  - `protein(number)`: Accepts a number and defines how much of the protein nutrient the ingredient provides, defaults to 0
  - `dairy(number)`: Accepts a number and defines how much of the dairy nutrient the ingredient provides, defaults to 0
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the food item, if not provided a name will be automatically generated based on the ingredient

## Example
```js
// Makes vanilla steak a TFC food item, giving it 20 protein, 2 saturation, and 6 hunger
onEvent('tfc.data', event => {
    event.addTFCFoodItem('minecraft:cooked_beef', e => {
        e.protein(20)
        e.saturation(2)
        e.hunger(6)
    })
})
```

# Fuels

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#fuels)!

- 1st argument: An item ingredient which the fuel values will apply to
- 2nd argument: A number representing the temperature (℃) at which the ingredient will burn for
- 3rd argument: An integer representing the duration, in ticks, the ingredient will burn for
- *optional 4th argument*: A `ResourceLocation` which determines the name/file of the fuel, if not provided a name will be automatically generated based on the ingredient

## Example
```js
// Makes coal blocks burn at 1800℃ for 1200 ticks
onEvent('tfc.data', event => {
    event.addTFCFuel('minecraft:coal_block', 1800, 1200)
})
```

# Heats

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#item-heats)!

- 1st argument: An item ingredient which the heat definition applies to
- 2nd argument: A number which specifies how fast the item heats up relative to others
- ***nullable** 3rd argument*: A number which determines above which temperature (℃) the ingredient may be forged
- ***nullable** 4th argument*: A number which determines above which temperature (℃) the ingredient may be welded
- *optional 5th argument*: A `ResourceLocation` which defines the name/file this heat uses, if not provided a name will be automatically generated based on the ingredient

## Example
```js
// Gives netherite ingots a heat definition that makes them heat up slower than most materials and able to forge at 1450℃
onEvent('tfc.data', event => {
    event.addTFCHeat('minecraft:netherite_ingot', 3.05, null, 1450)
})
```

# Item Sizes

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#item-sizes)! **Note: per the main page, this will not override blocks/items which specify their own weight/size**

- 1st argument: An item ingredient which the size and weight values will apply to
- 2nd arguemnt: A string which describes the weight and size values
  - The format is `s=small, w=light`; the types *must* be separated by commas and types the may be shorted to their first letter:
    - size/s
      - Allowed values: `tiny`, `very_small`, `small`, `normal`, `large`, `very_large`, `huge`
    - weight/w
      - Allowed values: `very_light`, `light`, `medium`, `heavy`, `very_heavy`
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the item size, if not provided a name will be automatically generated based on the ingredient

## Example
```js
// Makes dirt huge and heavy
onEvent('tfc.data', event => {
    event.addTFCItemSize('minecraft:dirt', 's=huge, w=heavy')
})
```

# Lamp Fuels

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#lamp-fuels)!

- 1st argument: A [fluid stack ingredient](<wrappers#fluid-stack-ingredient>) which determines the fluids this lamp fuel applies to, the amount will be ignored
- 2nd argument: A [block ingredient](<wrappers#block-ingredient>) which determines which lamp blocks the fuel may be added to
- 3rd argument: An integer representing how fast the lamp burns fuel, in ticks per mB
- *optional 4th argument*: A `ResourceLocation` which determines the name/file of the lamp fuel, if not provided a name will be automatically generated based on the fluid ingredient

## Example
```js
// Allows all tfc:alcohols to burn in all tfc:lamps for 300 ticks per mB
onEvent('tfc.data', event => {
    event.addTFCLampFuel('#tfc:alcohols', '#tfc:lamps', 300)
})
```

# Metals

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#metals)!

- 1st argument: A string representing the registry name of a fluid which the metal definition will apply to
- 2nd argument: A number which determines the temperature (℃) at which the metal will melt at
- 3rd argument: A number which specifies how fast the metal heats up relative to others
- 4th argument: An item ingredient which defines the ingot items of the metal
- 5th argument: An item ingredient which defines the sheet items of the metal
- 6th argument: An integer which determines the tier of the metal, defaults to 0
- *optional 7th argument*: A `ResourceLocation` which determines the name/file of the metal, if not provided a name will be automatically generated with `kubejs_tfc` as the namespace and the path will be the fluid string will all non `a-z0-9` characters replaced with underscores

Using the example below, the metal will be `kubejs_tfc:minecraft_water`, and the texture location will be `kubejs_tfc:textures/block/metal/full/minecraft_water.png`

Alternatively put `settings.dataPackOutput = true` at the top of your script file and when entering the world or using `/reload` KubeJS will print the location of the virtual file, which can be used to determine the names as well, as well as its contents to the log

## Example
```js
// Makes water melt at 0℃, heat up slowly with iron ingots as the ingot item and gold ingots as the sheet item
onEvent('tfc.data', event => {
    event.addTFCMetal('minecraft:water', 0, 50, 'minecraft:iron_ingot', 'minecraft:gold_ingot', 0)
})

// An example of referring to the metal
onEvent('recipes', event => {
    event.recipes.tfc.alloy('kubejs_tfc:minecraft_water', [
        ['tfc:zinc', 0.5, 0.5],
        ['tfc:bronze', 0.5, 0.5]
    ])
})
```

# Supports

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#supports)!

- 1st argument: A [block ingredient](<wrappers#block-ingredient>) which defines which blocks this support applies to
- 2nd argument: An integer representing the number of blocks up this support supports
- 3rd argument: An integer representing the number of blocks down this support supports
- 4th argument: An integer representing the number of blocks horizontally the support supports
- *optional 5th argument*: A `ResourceLocation` which determines the name/file of the support, if not provided a name will be automatically generated based on the block ingredient

## Example
```js
// Makes cobblestone walls support 1 above them, 1 below them, and three horizontally away from them
onEvent('tfc.data', event => {
    event.addTFCSupport('minecraft:cobblestone_wall', 1, 1, 3)
})
```

# Sluicing

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#sluicing)!

- 1st argument: An ingredient, matching the items that will go into the sluice
- 2nd argument: A String, representing the location of the loot table to be used
  - See the main page and its links for making loot tables, or take a look at [LootJS](https://www.curseforge.com/minecraft/mc-mods/lootjs)
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the sluicing definition, if not provided a name will be automatically generated based on the ingredient.

## Example
```js
// Associates dirt with the tfc:blocks/clay/loam loot table when sluiced
onEvent('tfc.data', event => {
    event.addTFCSluicing('minecraft:dirt', 'tfc:blocks/clay/loam')
})
```

# Panning

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#panning)!

- 1st argument: A [block ingredient](<wrappers#block-ingredient>), matching the blocks that will go into the pan
- 2nd argument: A String, representing the location of the loot table to be used
  - See the main page and its links for making loot tables, or take a look at [LootJS](https://www.curseforge.com/minecraft/mc-mods/lootjs)
- 3rd argument: A string list, representing an list of model locations which will be iterated through and rendered as panning progresses. Must have at least one model, but may have as many as you wish
  - **Note:** These models need to be added to the Forge Special Model Registry. If the models aren't working, see the main page and its instructions on adding them through the client config
- *optional 4th argument*: A `ResourceLocation` which determines the name/file of the panning definition, if not provided the name will be automatically generated based off the block ingredient

## Example
```js
// Associates dirt with the tfc:blocks/clay/loam loot table when panned and uses the full quartzite native gold and native gold result models
onEvent('tfc.data', event => {
    event.addTFCPanning('minecraft:dirt', 'tfc:blocks/clay/loam', ['tfc:item/pan/native_gold/quartzite_full', 'tfc:item/pan/native_gold/result'])
})
```

# Climate Ranges

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#climate-ranges)!

- 1st argument: A consumer with several optional methods
  - `minHydration(integer)`: Sets the `min_hydration` property, in the range [0,100]
  - `maxHydration(integer)`: Sets the `max_hydration` property, in the the range [0, 100]
  - `hydrationWiggle(integer)`: Sets the `hydration_wiggle_range` property
  - `minTemperature(integer)`: Sets the `min_temperature` property
  - `maxTemperature(integer)`: Sets the `max_temperature` property
  - `temperatureWiggle(integer)`: Sets the `temperature_wiggle_range` property
- 2nd argument: A `ResourceLocation` which defines the name/file of the climate range

## Example
```js
// Makes it so barley can grow anywhere between hydration levels of 70 to 75 with a wiggle range of 30
onEvent('tfc.data', event => {
    event.addTFCClimateRange(climate => {
        climate.minHydration(70)
        climate.maxHydration(75)
        climate.hydrationWiggle(30)
    }, 'tfc:barley')
})
```

# Fauna

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/custom/#fauna)!

- 1st argument: A consumer with methods matching world generation feature placement [climate consumer](https://github.com/Notenoughmail/KubeJS-TFC/wiki/World-Generation#climateconsumer)
- 2nd argument: A consumer with several optional methods
  - `chance(integer)`: Sets the chance (in 1/N chunks) that something will spawn
  - `distanceBelowSeaLevel(integer)`: Sets the distance below sea level something must spawn under, should only be used for aquatic animals
  - `solidGround(boolean)`: If true, requires the mob to spawn on a block with the `minecraft:valid_spawn` tag
  - `maxBrightness(integer)`: Sets the maximum brightness the mob may spawn at
- 3rd argument: A `ResourceLocation` which determines the name/file of the fauna definition

## Example
```js
/* 
 * Makes it so orcas can spawn in regions
 * - between 3 and 23 degrees Celsius
 * - with at least 75 mm of rain
 * in areas
 * - at least 13 blocks below sea level
 * - no brighter than 7
 */
onEvent('tfc.data', event => {
    event.addTFCFauna(climate => {
        climate.minTemp(3)
        climate.maxTemp(23)
        climate.minRain(75)
    }, fauna => {
        fauna.chance(20)
        fauna.distanceBelowSeaLevel(13)
        fauna.maxBrightness(7)
    }, 'tfc:orca')
})
```

# Greenhouses

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation#data)!

- 1st argument: A [block ingredient](<wrappers#block-ingredient>) which determines which blocks are part of this greenhouse
- 2nd argument: An integer representing the tier of the blocks defined
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the greenhouse definition, if not provided a name will be automatically generated based on the block ingredient

## Example
```js
// Makes green glass a tier 5 greenhouse block, the same as treated wood greenhouses
onEvent('tfc.data', event => {
    event.addFLGreenhouse('minecraft:green_glass', 5)
})
```

# Plantables

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation#data)!

- 1st argument: An ingredient, specifying the seed to use
- 2nd argument: A consumer with several methods
  - `planter(string)`: Accepts a string and sets which planter type may be used, available options are: `quad`, `large`, `hanging`, `trellis`, `bonsai`, and `hydroponic`. Defaults to `quad`
  - `tier(integer)`: Accepts an integer and sets the minimum tier [greenhouse](<#greenhouses>) needed, defaults to 0
  - `stages(integer)`: Accepts an integer, should be one less than the number of textures the planter will cycle through as it grows. Does not need to be specified for `trellis` or `bonsai` planters
    - As an example squash has 5 textures that it uses for growing, the stage number is 4
  - `extraSeedChance(number)`: Accepts a number, in the range [0, 1], sets the chance of getting a second seed back, defaults to 0.5
  - `seed(object)`: Accepts an item, sets the seed that will be returned when picked
  - `crop(object)`: Accepts an item, sets the item that is guaranteed to be returned when picked
  - `nitrogen()`: Sets the nutrient to `nitrogen`
  - `phosphorous()`: Sets the nutrient to `phosphorous`
  - `potassium()`: Sets the nutrient to `potassium`
  - `texture(string...)`: Accepts an array of strings corresponding to the textures the planter uses. Rules vary depending on planter:
    - For `large`, `quad`, `hydroponic`, and `hanging`: List the textures in order of growth
    - For `trellis`: List the strings in the order: `growing`, `dry`, `flowering`, `fruiting`
    - For `bonsai`: List the strings in the order: `fruiting`, `dry`, `flowering`, `branch`, `leaves`
  - `specials(string...)`: Accepts an array of strings corresponding to extra textures the planter uses. Rules vary depending on planter:
    - For `hanging`: Specify the fruit texture
    - For everything else this method isn't needed
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the plantable definition, if not provided a name will be automatically generated based on the ingredient

## Example
```js
// Makes oak saplings plantable in bonsai planters in a greenhouse tier of 15 or more
onEvent('tfc.data', event => {
    event.addFLPlantable('minecraft:oak_sapling', e => {
        e.planter('bonsai')
        e.tier(15)
        e.extraSeedChance(0.15)
        e.seed('minecraft:oak_sapling')
        e.crop('minecraft:oak_log')
        e.phosphorous()
        e.texture('minecraft:block/oak_sapling', 'minecraft:block/dead_bush', 'tfc:block/fruit_tree/cherry_sapling', 'tfc:block/fruit_tree/red_apple_sapling')
    })
})
```

# Nether Fertilizers

[Beneath](https://github.com/eerussianguy/Beneath/tree/main) (an in-progress nether addon) adds a new set of fertilizer types for the nether

- 1st argument: An item ingredient which the nether fertilizer values will apply to
- 2nd argument: A string which describes the nether fertilizer types and their values
  - The format is `d=0.5, f=0.7`; the different types *must* be separated by commas and the types may be shorted to:
    - death/d
    - destruction/t
    - flame/f
    - decay/c
    - sorrow/s
- *optional 3rd argument*: A `ResourceLocation` which determines the name/file of the fertilizer, if not provided a name will be automatically generated based on the ingredient

## Example
```js
// Makes crimson fungus apply 70% flame and 20% death
onEvent('tfc.data', event => {
    event.addBeneathFertilizer('minecraft:crimson_fungus', 'f=0.7, d=0.2')
})
```

# Attached TFC Data

In order to add nutrition, the chisel mode, and a few other things TFC attaches some data onto the player, this can be accessed through a `PlayerJS` object through the `.getData()` method which returns a map of strings to objects. Use `tfc:player_data` to access a wrapper for all of TFC's attached data.

This wrapper has several methods to read and modify the state of TFC's additional data

## getChiselMode()
Returns the player's chisel mode
## setChiselMode(ChiselMode)
Sets the player's chisel mode, accepts `smooth`, `stair`, and `slab`
## getIntoxicatedTicks()
Returns the number of remaining ticks the player is intoxicated for
## addIntoxicationTicks(number)
Increases the player's intoxicated ticks by the amount provided
## getLastDrinkTick()
Returns the tick the player last drank
## setLastDrinkTick(number)
Sets the tick the player last drank
## playerEat(ItemStackJS)
Makes the player eat the provided stack
## getFoodLevel()
Returns the player's food level
## needsFood()
Returns true if the player is less than full hunger
## addExhaustion(number)
Adds the exhaustion provided
## getSaturationLevel()
Returns the player's saturation level
## setFoodLevel(integer)
Sets the player's food level
## setSaturationlevel(number)
Sets the player's saturation elvel
## getThirstModifier()
Returns the total thirst lost per tick for the player on a scale 0f [0, 100], with 100 being a full bar
## getThirstContributionFromTemperature()
Returns the thirst the player loses from ambient temperature on top of regular loss
## getThirst()
Returns the player's thirst level
## setThirst(number)
Sets the player's thirst level
## addThirst(number)
Adds the specified amount of thirst to the player
## getAverageNutrition()
Returns the average nutrition of the player
## getNutrient(Nutrient)
Returns the nutrient value in the range [0, 1]. accepts `grain`, `fruit`, `vegetables`, `protein`, and `dairy`
## getNutrients()
Returns a number array representing the nutrient values, in the order `grain`, `fruit`, `vegetables`, `protein`, `dairy`

## Example
```js
/*
 * @param {Internal.PlayerJS} player
 */
function doThing(player) {
    let data = player.data['tfc:player_data']

    if (data.needsFood() && data.thirstModifier > 3) {
        // Do the thing idk
    }
}
```