---
layout: page
title: Data
permalink: /kubejs_tfc/1.20.1/data/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Data

KubeJS TFC allows users to easily write TFC's [custom data](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/) types in the `TFCEvents.data` event

- [Climate Ranges](#climate-ranges)
- [Damage Resistances](#damage-resistances)
- [Drinkables](#drinkables)
- [Fauna](#fauna)
- [Fertilizers](#fertilizers)
- [Food Items](#food-items)
- [Fuels](#fuels)
- [Item Heats](#item-heats)
- [Item Size](#item-size)
- [Knapping Types](#knapping-types)
- [Lamp Fuels](#lamp-fuels)
- [Metals](#metals)
- [Supports](#supports)
- [Sluicing](#sluicing)
- [Panning](#panning)

Additionally, the ability to access and manipulate some of TFC's non-datapack accessable data TFC adds to the player is accessable form a `Player` object in scripts. See [here](#attached-tfc-data) for specifics

{: .notice }
> Most of these methods have an optional final argument which specifies the 'name' of the definition
>
> This refers to the directory location of the virtual json file, for instance if, for a entity resistance, you gave it the name `kubejs:fish_get_pierced`, the resulting file would act as if it had been placed in `data/kubejs/tfc/entity_damage_resistances/fish_get_pierced.json`, the `tfc/<dataType>` folders do not need to be provided
>
> If no name is provided, one will be automatically generated with the namespace `kubejs_tfc` and, unless otherwise noted, a path matching a base 16 hash of the (usually) 1st argument's `toString()` value

## Climate Ranges

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#climate-ranges)!

### Method Signature

```ts
event.climateRange(climateRange: Consumer<BuildClimateRangeData>, name: string)
```

- 1st argument: A consumer with several additional methods:
    - `.minHydration(i: number)`: Accepts a number, in the range [0, 100], specifying the minimum hydration, defaults to 0
    - `.maxHydration(i: number)`: Accepts a number, in the range [0, 100], specifying the maximum hydration, defaults to 100
    - `.hydrationWiggle(i: number)`: Accepts a number, specifying the wiggle range for hydration when consulting wiggliness is enabled, defaults to 0
    - `.minTemperature(f: number)`: Accepts a number, in the range [-100, 100], specifying the minimum temperature, defaults to -100
    - `.maxTemperature(f: number)`: Accepts a number, in the range [-100, 100], specifying the maximum temperature, defaults to 100
    - `.temperatureWiggle(f: number)`: Accepts a number specifying the wiggle range for temperature when consulting wiggliness is enabled, defaults to 0
- 2nd argument: A string, the name of the climate range

{: .notice }
Climate ranges cannot be added through this, only existing, registered ones can be modified

### Example

```js
TFCEvents.data(event => {
    event.climateRange(climate => {
        climate.maxHydration(45)
        climate.minHydration(30)
        climate.minTemperature(50)
    }, 'tfc:barley')
})
```

## Damage Resistances

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#damage-resistances)!

### Method Signatures

```ts
event.itemDamageResistance(ingredient: Ingredient, piercing: @Nullable number, slashing: @Nullable number, crushing: @Nullable number, name?: string)
event.entityDamageResistance(entityTag: string, piercing: @Nullable number, slashing: @Nullable number, crushing: @Nullable number, name?: string)
```

- 1st argument:
    - For items: An ingredient, the armor items the resistance applies to
    - For entities: A string, the entity tag to be given the resistance
- 2nd argument: A number, the piercing resistance, may be null to not specify a resistance
- 3rd argument: A number, the slashing resistance, may be null to not specify a resistance
- 4th argument: A number, the crushing resistance, may be null to not specify a resistance
- *Optional 5th argument*: A string, the name of the resistance

### Examples

```js
TFCEvents.data(event => {
    event.itemDamageResistance('minecraft:iron_helmet', 300, 2, null)
    event.entityDamageResistance('minecraft:fish', -500, null, 3, 'kubejs:fish_get_pierced')
})
```

## Drinkables

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#drinkables)!

### Method Signature

```ts
event.drinkable(fluidIngredient: FluidIngredient, drinkableData: Consumer<BuildDrinkableData>, name?: string)
```

- 1st argument: A [fluid ingredient](../bindings/#fluid-ingredient) which defines which fluids the drinkable applies to
- 2nd argument: A consumer with several additional methods:
    - `.consumeChance(f: number)`: Accepts a number, in the range [0, 1], and sets the chance that a source block will be removed when drank from, defaults to 0
    - `.thirst(i: number)`: Accepts a number, in the range [0, 100], the amount of thirst the drinkable consumes per 25mB drank, defaults to 0
    - `.intoxication(i: number)`: Accepts a number, ≥ 0, and sets the number of ticks the player will be intoxicated for per 25mB drank, defaults to 0
    - `.effect(effect: string, effectData?: Consumer<BuildEffectData>)`: Accepts a string, the name of the effect[^1] to be applied and an optional consumer with several additional methods:
        - `.duration(i: number)`: Accepts a number specifying the number of ticks the effect is applied for, defaults to 20
        - `.amplifier(i: number)`: Accepts a number specifying the level of the potion effect applied, defaults to 0
        - `.chance(f: number)`: Accepts a number, in the range [0, 1], specifying the chance the effect will be applied per 25mB drank, defaults to 1
    - `.food(foodData: Consumer<BuildFoodItemData>)`: Accepts a consumer with the same methods as the one in [food items](#food-items)
- *Optional 3rd argument*: A string, the name of the drinkable

[^1]: A full list of all effects can be attained by running the command `/kubejs dump_registry minecraft:mob_effect` in-game

### Example

```js
TFCEvents.data(event => {
    event.drinkable('minecraft:lava', data => {
        data.thirst(25)
        data.effect('minecraft:wither', effect => {
            effect.amplifier(5)
            effect.duration(200)
        })
        data.food(food => {
            food.protein(3)
            food.hunger(2)
        })
    })
})
```

## Fauna

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#fauna)!

### Method Signature

```ts
event.fauna(climateData: Consumer<PlacedFeatureProperties$Climate>, faunaData: Consumer<BuildFaunaData>, name: string)
```

- 1st argument: A consumer with methods matching those of the placed feature [climate decorator](../worldgen/#climate)
- 2nd argument: A consumer with several additional methods:
    - `.chance(i: number)`: Accepts a number, sets the chance in 1/N chunks that something will spawn, defaults to 1
    - `.distanceBelowSeaLevel(i: number)`: Accepts a number, sets the distance below sea level something must spawn, should only be set for underwater creatures
    - `.solidGround(b: boolean)`: Accepts a boolean, determines if the mob is required to spawn on a block tagged `minecraft:valid_spawn`, defaults to `false`
    - `.maxBrightness(i: number)`: Accepts a number, sets the maximum light level the mob may spawn in
- 3rd argument: A string, the name of the fauna

{: .notice }
Faunas cannot be added through this, only existing, registered ones can be modified

### Example

```js
TFCEvents.data(event => {
    event.fauna(climate => {
        climate.minTemp(90)
    }, fauna => {
        fauna.chance(30)
        fauna.maxBrightness(4)
    }, 'tfc:pufferfish')
})
```

## Fertilizers

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#fertilizers)!

### Method Signature

```ts
event.fertilizer(ingredient: Ingredient, nitrogen: @Nullable number, phosphorus: @Nullable number, potassium: @Nullable number, name?: string)
```

- 1st argument: An item ingredient, the items the fertilizer applies to
- 2nd argument: A number, sets the nitrogen value of the fertilizer, may be null to not set a value, defaults to 0
- 3rd argument: A number, sets the phosphorus value of the fertilizer, may be null to not set a value, defaults to 0
- 4th argument: A number, sets the potassium value of the fertilizer, may be null to not set a value, defaults to 0
- *Optional 5th argument*: A string, sets the name of the fertilizer

### Example

```js
TFCEvents.data(event => {
    event.fertilizer('minecraft:rooted_dirt', 0.2, null, 0.1, 'kubejs:root_fertilizer')
})
```

## Food Items

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#food-items)!

### Method Signature

```ts
event.foodItem(ingredient: Ingredient, foodItemData: Consumer<BuildFoodItemData>, name?: string)
```

- 1st argument: An item ingredient, the items the to which the food item definition applies to
- 2nd argument: A consumer with several additional methods:
    - `.type(type: string)`: Accepts a string, sets the food definition to be a special type, accepts either `dynamic` or `dynamic_bowl`. See the main page for specifications on what this is used for. If this is set, other values should not be set
    - `.hunger(i: number)`: Accepts a number, sets how much hunger the food restores, defaults to 4. A full hunger bar is 20
    - `.saturation(f: number)`: Accepts a number, sets how much saturation the food restores, defaults to 0
    - `.water(f: number)`: Accepts a number, sets how much water the food restores, defaults to 0. A full water bar is equal to 100
    - `.decayModifier(f: number)`: Accepts a number, sets how quickly the food decays, defaults to 1. A higher number indicates a faster decay rate
    - `.grain(f: number)`: Accepts a number, sets the amount of grain nutrient the food restores, defaults to 0
    - `.fruit(f: number)`: Accepts a number, sets the amount of fruit nutrient the food restores, defaults to 0
    - `.vegetables(f: number)`: Accepts a number, sets the amount of vegetable nutrient the food restores, defaults to 0
    - `.protein(f: number)`: Accepts a number, sets the amount of protein nutrient the food restores, defaults to 0
    - `.dairy(f: number)`: Accepts a number, sets the amount of dairy nutrient the food restores, defaults to 0
- *Optional 3rd argument*: A string, sets the name of the food definition

### Example

```js
TFCEvents.data(event => {
    event.foodItem('minecraft:cooked_porkchop', food => {
        food.hunger(3)
        food.protein(1.3)
        food.decayModifier(1.5)
    })
})
```

## Fuels

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#fuels)!

### Method Signature

```ts
event.fuel(ingredient: Ingredient, temperature: number, duration: number, purity: @Nullable number, name?: string)
```

- 1st argument: An item ingredient, the items the fuel applies to
- 2nd argument: A number, the temperature °C that the fuel burns at
- 3rd argument: A number, the number of ticks the fuel burns for
- 4th argument: A number, the purity of the fuel, may be null to not specify a value
- *Optional 5th argument*: A string, the name of the fuel

### Example

```js
TFCEvents.data(event => {
    event.fuel('minecraft:coal_block', 1575, 3500, 0.95)
})
```

## Item Heats

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#item-heats)!

### Method Signature

```ts
event.itemHeat(ingredient: Ingredient, heatCapacity: number, forgingTemperature: @Nullable number, weldingTemperature: @Nullable number, name?: string)
```

- 1st argument: An item ingredient, the items the heat definition applies to
- 2nd argument: A number, specifies how fast the the item heats up relative to others, measured in Energy / °C
- 3rd argument: A number, specifies the temperature at which the item can be worked, may be null to allow working at any temperature
- 4th argument: A number, specifies the temperature at which the item can be welded, may be null to allow welding at any temperature
- *Optional 5th argument*: A string, the name of the heat definition

### Example

```js
TFCEvents.data(event => {
    event.itemHeat('minecraft:netherite_ingot', 0.7, null, 1700)
})
```

## Item Size

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#item-sizes)!

### Method Signature

```ts
event.itemSize(ingredient: Ingredient, size: @Nullable Size, weight: @Nullable Weight, name?: string)
```

- 1st argument: An item ingredient, the items the size applies to
- 2nd argument: A `Size`, sets the size of the item, may be `tiny`, `very_small`, `small`, `normal`, `large`, `very_large`, `huge`, or null to not specify a size
- 3rd argument: A `Weight`, sets the weight of the item, may be `very_light`, `light`, `medium`, `heavy`, `very_heavy`, or null to not specify a weight
- *Optional 4th argument*: A string, the name of the size definition

### Example

```js
TFCEvents.data(event => {
    event.itemSize('minecraft:gold_ingot', 'huge', 'very_heavy')
})
```

## Knapping Types

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#knapping-types)!

### Method Signature

```ts
event.knappingType(
    ingredient: Ingredient,
    ingredientCount: number,
    amountToConsume: number,
    clickSound: string,
    consumeAfterComplete: boolean,
    useDisabledTexture: boolean,
    spawnsParticles: boolean,
    jeiIconItem: ItemStack,
    name: string
)
```

- 1st argument: An item ingredient, the ingredient for what item has to be knapped, must be part of the `tfc:any_knapping` tag to work
- 2nd argument: A number, the minimum number of items matching the ingredient that must be held in order open the knapping menu
- 3rd argument: A number, the number of items that gets used by a recipe
- 4th argument: A string, the registry name of a sound event that plays when knapping occurs[^2]
- 5th argument: A boolean, determines if the inputs should be consumed when the first square is clicked or when the result is removed
- 6th argument: A boolean, if true, a clicked spot will show a different texture rather than nothing
- 7th argument: A boolean, determines if the screen should spawn small particles when clicking buttons
- 8th argument: An `ItemStack`, the icon item for the JEI recipe category
- 9th argument: A string, the name of the knapping type

[^2]: A full list of all sound events can be attained by running the command `/kubejs dump_registry minecraft:sound_event` in-game

### Example

```js
TFCEvents.data(event => {
    event.knappingType('minecraft:deepslate', 1, 5, 'minecraft:entity.warden.roar', false, true, true, 'minecraft:deepslate', 'kubejs:deepslate')
})
```

## Lamp Fuels

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#lamp-fuels)!

### Method Signature

```ts
event.lampFuel(fluidIngredient: FluidIngredient, blockIngredient: BlockIngredient, burnRate: number, name?: string)
```

- 1st argument: A [FluidIngredient](../bindings/#fluid-ingredient), determines which fluids the lamp fuel applies to
- 2nd argument: A [BlockIngredient](../bindings/#block-ingredinet), determines what (lamp) blocks are valid for this fuel to be added to
- 3rd argument: A number, represents how fast the fuel is consumed, in ticks per mB
- *Optional 4th argument*: A string, the name of the lamp fuel

### Example

```js
TFCEvents.data(event => {
    event.lampFuel('tfc:salt_water', '#tfc:lamps', 1)
})
```

## Metals

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#metals)!

### Method Signature

```ts
event.metal(
    fluid: string,
    meltTemperature: number,
    heatCapacity: number,
    ingot: @Nullable Ingredient,
    doubleIngot: @Nullable Ingredient,
    sheet: @Nullable Ingredient,
    tier: number,
    name?: string)
```

- 1st argument: A string, the registry name of a fluid which corresponds to this metal
- 2nd argument: A number, the melting temperature of the metal
- 3rd argument: A number, specifies how fast the metal heats up relative to others, measured in Energy / (mB * °C)
- 4th argument: An item ingredient, defines the ingots of the metal, may be null to indicate the metal does not have any ingots
- 5th argument: An item ingredient, defines the double ingots of the metal, may be null to indicate the metal does not have any double ingots
- 6th argument: An item ingredient, defines the sheets of the metal, may be null to indicate the metal does not have any sheets
- 7th argument: A number, the tier of the metal
- *Optional 8th argument*: A string, the name of the metal

{: .notice }
> If no name is provided, one will be automatically generated from the fluid
>
> The name is generated like so:
>
> - The name space becomes `kubejs_tfc`
> - the path becomes the name of the fluid with the following applied:
>   - All non `a-z0-9` characters are replaced with `_`
>   - All repeating `_`s are shortened to just one `_`
>   - Any preceding or trailing `_`s are removed
>   - The string is limited to its first 65 characters if applicable

### Example

```js
TFCEvents.data(event => {
    event.metal('minecraft:lava', 2000, 0.5, null, null, 'kubejs:lava_sheet', 3, 'kubejs:lava') // If the name had not be specified it would have been 'kubejs_tfc:minecraft_lava'
})
```

## Supports

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#supports)!

### Method Signature

```ts
event.support(blockIngredient: BlockIngredient, up: number, down: number, horizontal: number, name?: string)
```

- 1st argument: A [BlockIngredient](../bindings/#block-ingredient), determines what blocks the support applies to
- 2nd argument: A number, the number of blocks up the block supports
- 3rd argument: A number, the number of blocks down the block supports
- 4th argument: A number, the number of blocks horizontally the block supports
- *Optional 5th argument*: A string, the name of the support

### Example

```js
TFCEvents.data(event => {
    event.support('minecraft:cobblestone_wall', 3, 4, 10)
})
```

## Sluicing

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#sluicing)!

### Method Signature

```ts
event.sluicing(ingredient: Ingredient, lootTable: string, name?: string)
```

- 1st argument: An item ingredient, the items the sluicing definition applies to
- 2nd argument: A string, the location of a loot table to be dropped for this item
- *Optional 3rd argument*: A string, the name of the sluicing definition

### Example

```js
TFCEvents.data(event => {
    event.sluicing('minecraft:rooted_dirt', 'kubejs:roots')
})
```

## Panning

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/custom/#panning)!

### Method Signature

```ts
event.panning(blockIngredient: BlockIngredient, lootTable: string, models: List<string>, name?: string)
```

- 1st argument: A [BlockIngredient](../bindings/#block-ingredient), the blocks that will go into the pan
- 2nd argument: A string, the location of a loot table to be dropped for the ingredient
- 3rd argument: A list of strings which are model locations to be iterated through as panning progresses
- *Optional 4th argument*: A string, the name of the panning definition

### Example

```js
TFCEvents.data(event => {
    event.panning('minecraft:gravel', 'kubejs:gravel_panning', ['tfc:item/pan/native_gold/quartzite_full', 'tfc:item/pan/native_gold/result'])
})
```

## Attached TFC data

In order to add nutrition, the chisel mode, and a few other things TFC attaches some extra data to the player. This can be accessed through a `Player` object through the `getData()` method which returns a `Map<String, Object>`. TFC's data can be accessed through `tfc:player_data`

There are several methods to access and modify the state of TFC's additional data

### Method Signatures

```ts
declare class TFCPlayerDataJS {
    constructor(player: Player)
    getChiselMode(): ChiselMode
    setChiselMode(mode: ChiselMode): void
    getIntoxicatedTicks(): number
    addIntoxicatedTicks(ticks: number): void
    getLastDrinkTick(): number
    setLastDrinkTick(tick: number): void
    playerEat(item: ItemStack): void
    getFoodLevel(): number
    setFoodLevel(i: number): void
    needsFood(): boolean
    addExhaustion(f: number): void
    getSaturationLevel(): number
    setSaturationLevel(f: number): void
    getThirstModifier(): number
    getThirstContributionFromTemperature(): number
    getThirst(): number
    setThirst(f: number): void
    addThirst(f: number): void
    getAverageNutrition(): number
    getNutrient(nutrient: Nutrient): number
    getNutrients(): number[]
}
```

- `.getChiselMode()`: Returns the player's current `ChiselMode`, will be either `smooth`, `stair`, or `slab`
- `.setChiselMode(mode: ChiselMode)`: Sets the player's current chisel mode, will accept `smooth`, `stair`, or `slab`
- `.getIntoxicatedTicks()`: Returns the number of ticks the player is intoxicated for
- `.addIntoxicatedTicks(ticks: number)`: Adds to the player's intoxicated ticks
- `.getLastDrinkTick()`: Returns the last tick the player drank something
- `.setLastDrinkTick(tick: number)`: Sets the last tick the player drank something
- `.playerEat(item: ItemStack)`: Makes the player eat the provided `ItemStack`
- `.getFoodLevel()`: Returns the player's current food level
- `.setFoodLevel(i: number)`: Sets the player's current food level
- `.needsFood()`: Returns true if the player needs food
- `.addExhaustion(f: number)`: Adds the given exhaustion to the player
- `.getSaturationLevel()`: Returns the player's saturation level
- `.setSaturationLevel(f: number)`: Sets the player's saturation level
- `.getThirstModifier()`: Returns the player's total thirst loss per tick, on a scale of [0, 100]
- `.getThirstContributionFromTemperature()`: Returns the player's total thirst lost per tick from ambient temperature in addition to regular loss
- `.getThirst()`: Returns the player's thirst
- `.setThirst(f: number)`: Sets the player's thirst
- `.addThirst(f: number)`: Adds the provided thirst the the player's thirst
- `.getAverageNutrition()`: Returns the average nutrition level of the player
- `.getNutrient(nutrient: Nutrient)`: Returns the player's nutrition level for the given nutrient, accepts `grain`, `fruit`, `vegetables`, `protein`, and `dairy`
- `.getNutrients()`: Returns an array of 5 numbers, corresponding to each nutrient in the order `grain`, `fruit`, `vegetables`, `protein`, `dairy`

### Example

```js
/*
 * @ param {Internal.Player} player
 */
function doThing(player) {
    let tfcData = player.data['tfc:player_data']
    if (tfcData.thirst < 20 && tfcData.averageNutrition < 0.3) {
        tfcData.addExhaustion(12)
    }
}
```
