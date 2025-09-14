---
layout: page
title: Data
permalink: /kubejs_tfc/1.20.1/data/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Data

KubeJS TFC allows users to easily write TFC's [custom data](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/) types in the `TFCEvents.data` event

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

<a id="firmalife"></a>If *FirmaLife* {% include mr.html link='firmalife' %} {% include cf.html link='firmalife' %} is installed, the following are also available

- [Greenhouse Type](#firmalife-greenhouse-type)
- [Planter](#firmalife-planter)

<a id="beneath"></a>If *Beneath* {% include mr.html link='beneath' %} {% include cf.html link='beneath' %} is installed, the following are also available

- [Nether Fertilizer](#beneath-nether-fertilizer)
- [Lost Page](#beneath-lost-page)

This event goes in the `server_evetns` folder.

Additionally, the ability to access and manipulate some of TFC's non-datapack accessible data TFC adds to the player is accessible form a `Player` object in scripts. See [Attached TFC Data](#attached-tfc-data) for specifics

{: .notice #general-notice }
> Most of these methods have an optional final argument which specifies the 'name' of the definition
>
> This refers to the directory location of the virtual json file, for instance if, for a entity resistance, you gave it the name `kubejs:fish_get_pierced`, the resulting file would act as if it had been placed in `data/kubejs/tfc/entity_damage_resistances/fish_get_pierced.json`{:.language-fs}, the `tfc/<dataType>`{:.language-fs} folders do not need to be provided
>
> If no name is provided, one will be automatically generated with the namespace `kubejs_tfc` and, unless otherwise noted, a path matching a base 16 hash of the (usually) 1st argument's `.toString()`{: .language-kube } value
>
> Additionally, for definitions that use ingredients, if there are multiple definitions that have the same valid item/block/fluid, then there is no guarantee your custom definition will take precedence. This can be fixed by overriding the existing definition or modifying the tag that is used for it

## Climate Ranges

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#climate-ranges)!

{: .notice #climate-range-notice }
Climate ranges cannot be added through this, only existing, registered ones can be modified

### Method Signature

```js
event.climateRange(
    climateRange: Consumer<BuildClimateRangeData>,
    name: ResourceLocation
)
```

- 1st argument: A consumer with several additional methods:
    - `.minHydration(i: number)`{: .language-kube #climate-min-hydro }: Accepts a number, in the range [0, 100], specifying the minimum hydration, defaults to `0`{:.n}
    - `.maxHydration(i: number)`{: .language-kube #climate-max-hydro }: Accepts a number, in the range [0, 100], specifying the maximum hydration, defaults to `100`{:.n}
    - `.hydrationWiggle(i: number)`{: .language-kube #climate-hydro-wiggle }: Accepts a number, specifying the wiggle range for hydration when consulting wiggliness is enabled, defaults to `0`{:.n}
    - `.minTemperature(f: number)`{: .language-kube #climate-min-temp }: Accepts a number, in the range [-100, 100], specifying the minimum temperature, defaults to `-100`{:.n}
    - `.maxTemperature(f: number)`{: .language-kube #climate-max-temp }: Accepts a number, in the range [-100, 100], specifying the maximum temperature, defaults to `100`{:.n}
    - `.temperatureWiggle(f: number)`{: .language-kube #climate-temp-wiggle }: Accepts a number specifying the wiggle range for temperature when consulting wiggliness is enabled, defaults to `0`{:.n}
- 2nd argument: A `ResourceLocation`, the name of the climate range

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#damage-resistances)!

### Method Signatures

```js
event.itemDamageResistance(
    ingredient: Ingredient,
    piercing: @Nullable number,
    slashing: @Nullable number,
    crushing: @Nullable number,
    name?: ResourceLocation
)
event.entityDamageResistance(
    entityTag: String,
    piercing: @Nullable number,
    slashing: @Nullable number,
    crushing: @Nullable number,
    name?: ResourceLocation
)
```

- 1st argument:
    - For items: An ingredient, the armor items the resistance applies to
    - For entities: A string, the entity tag to be given the resistance
- 2nd argument: A number, the piercing resistance, may be `null`{:.p} to not specify a resistance
- 3rd argument: A number, the slashing resistance, may be `null`{:.p} to not specify a resistance
- 4th argument: A number, the crushing resistance, may be `null`{:.p} to not specify a resistance
- *Optional 5th argument*: A `ResourceLocation`, the name of the resistance

### Examples

```js
TFCEvents.data(event => {
    event.itemDamageResistance(
        'minecraft:iron_helmet',
        300,
        2,
        null
    )
    event.entityDamageResistance(
        'tfc:small_fish',
        -500,
        null,
        3,
        'kubejs:fish_get_pierced'
    )
})
```

## Drinkables

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#drinkables)!

### Method Signature

```js
event.drinkable(
    fluidIngredient: FluidIngredient,
    drinkableData: Consumer<BuildDrinkableData>,
    name?: ResourceLocation
)
```

- 1st argument: A [fluid ingredient]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-ingredient) which defines which fluids the drinkable applies to
- 2nd argument: A consumer with several additional methods:
    - `.consumeChance(f: number)`{: .language-kube #drinkable-consume-chance }: Accepts a number, in the range [0, 1], and sets the chance that a source block will be removed when drank from, defaults to `0`{:.n}
    - `.thirst(i: number)`{: .language-kube #drinkable-thirst }: Accepts a number, in the range [0, 100], the amount of thirst the drinkable consumes per 25mB drank, defaults to `0`{:.n}
    - `.intoxication(i: number)`{: .language-kube #drinkable-intoxication }: Accepts a number, ≥ 0, and sets the number of ticks the player will be intoxicated for per 25mB drank, defaults to `0`{:.n}
    - `.effect(effect: String, effectData?: Consumer<BuildEffectData>)`{: .language-kube #drinkable-effect }: Accepts a string, the name of the effect[^1] to be applied, and an optional consumer with several additional methods:
        - `.duration(i: number)`{: .language-kube }: Accepts a number specifying the number of ticks the effect is applied for, defaults to `20`{:.n}
        - `.amplifier(i: number)`{: .language-kube }: Accepts a number specifying the level of the potion effect applied, defaults to `0`{:.n}
        - `.chance(f: number)`{: .language-kube }: Accepts a number, in the range [0, 1], specifying the chance the effect will be applied per 25mB drank, defaults to `1`{:.n}
    - `.food(foodData: Consumer<BuildFoodItemData>)`{: .language-kube #drinkable-food }: Accepts a consumer with the same methods as the one in [food items](#food-items)
- *Optional 3rd argument*: A `ResourceLocation`, the name of the drinkable

[^1]: A full list of all effects can be attained by running the command `/kubejs dump_registry minecraft:mob_effect`{:.language-command} in-game

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#fauna)!

{: .notice #fauna-notice }
> Faunas cannot be added through this, only existing, registered ones can be modified
>
> To register a fauna definition see the [event]({% link kubejs_tfc/1.20.1/events.md %}#register-fauna-definitions) for registering them

### Method Signature

```js
event.fauna(
    climateData: Consumer<PlacedFeatureProperties$Climate>,
    faunaData: Consumer<BuildFaunaData>,
    name: ResourceLocation
)
```

- 1st argument: A consumer with methods matching those of the placed feature [climate decorator]({% link kubejs_tfc/1.20.1/worldgen.md %}#climate)
- 2nd argument: A consumer with several additional methods:
    - `.chance(i: number)`{: .language-kube #fauna-chance }: Accepts a number, sets the chance in `1/N`{: .language-kube } chunks that something will spawn, defaults to `1`{:.n}
    - `.distanceBelowSeaLevel(i: number)`{: .language-kube #fauna-distance-below-sea-level }: Accepts a number, sets the distance below sea level something must spawn, should only be set for underwater creatures
    - `.solidGround(b: boolean)`{: .language-kube #fauna-solid-ground }: Accepts a boolean, determines if the mob is required to spawn on a block tagged `minecraft:valid_spawn`, defaults to `false`{:.p}
    - `.maxBrightness(i: number)`{: .language-kube #fauna-max-brightness }: Accepts a number, sets the maximum light level the mob may spawn in
- 3rd argument: A `ResourceLocation`, the name of the fauna

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#fertilizers)!

### Method Signature

```js
event.fertilizer(
    ingredient: Ingredient,
    nitrogen: @Nullable number,
    hosphorus: @Nullable number,
    potassium: @Nullable number,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the items the fertilizer applies to
- 2nd argument: A number, sets the nitrogen value of the fertilizer, may be `null`{:.p} to not set a value, defaults to `0`{:.n}
- 3rd argument: A number, sets the phosphorus value of the fertilizer, may be `null`{:.p} to not set a value, defaults to `0`{:.n}
- 4th argument: A number, sets the potassium value of the fertilizer, may be `null`{:.p} to not set a value, defaults to `0`{:.n}
- *Optional 5th argument*: A `ResourceLocation`, the name of the fertilizer

### Example

```js
TFCEvents.data(event => {
    event.fertilizer(
        'minecraft:rooted_dirt',
        0.2,
        null,
        0.1,
        'kubejs:root_fertilizer'
    )
})
```

## Food Items

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#food-items)!

{: .notice #food-notice }
Items with food data still require vanilla's food properties in order for the game to know they are consumable

### Method Signature

```js
event.foodItem(
    ingredient: Ingredient,
    foodItemData: Consumer<BuildFoodItemData>,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the items to which the food item definition applies to
- 2nd argument: A consumer with several additional methods:
    - `.type(type: String)`{: .language-kube #food-item-type }: Accepts a string, sets the food definition to be a special type, accepts either `dynamic` or `dynamic_bowl`. See the main page for specifications on what this is used for. If this is set, other values should not be set
    - `.hunger(i: number)`{: .language-kube #food-item-hunger }: Accepts a number, sets how much hunger the food restores, defaults to `4`{:.n}. A full hunger bar is `20`{:.n}
    - `.saturation(f: number)`{: .language-kube #food-item-saturation }: Accepts a number, sets how much saturation the food restores, defaults to `0`{:.n}
    - `.water(f: number)`{: .language-kube #food-item-water }: Accepts a number, sets how much water the food restores, defaults to `0`{:.n}. A full water bar is equal to `100`{:.n}
    - `.decayModifier(f: number)`{: .language-kube #food-item-decay-mod }: Accepts a number, sets how quickly the food decays, defaults to `1`{:.n}. A higher number indicates a faster decay rate
    - `.grain(f: number)`{: .language-kube #food-item-grain }: Accepts a number, sets the amount of grain nutrient the food restores, defaults to `0`{:.n}
    - `.fruit(f: number)`{: .language-kube #food-item-fruit }: Accepts a number, sets the amount of fruit nutrient the food restores, defaults to `0`{:.n}
    - `.vegetables(f: number)`{: .language-kube #food-item-veg }: Accepts a number, sets the amount of vegetable nutrient the food restores, defaults to `0`{:.n}
    - `.protein(f: number)`{: .language-kube #food-item-protein }: Accepts a number, sets the amount of protein nutrient the food restores, defaults to `0`{:.n}
    - `.dairy(f: number)`{: .language-kube #food-item-dairy }: Accepts a number, sets the amount of dairy nutrient the food restores, defaults to `0`{:.n}
- *Optional 3rd argument*: A `ResourceLocation`, the name of the food definition

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#fuels)!

### Method Signature

```js
event.fuel(
    ingredient: Ingredient,
    temperature: number,
    duration: number,
    purity: @Nullable number,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the items the fuel applies to
- 2nd argument: A number, the temperature °C that the fuel burns at
- 3rd argument: A number, the number of ticks the fuel burns for
- 4th argument: A number, the purity of the fuel, may be `null`{:.p} to not specify a value
- *Optional 5th argument*: A `ResourceLocation`, the name of the fuel

### Example

```js
TFCEvents.data(event => {
    event.fuel('minecraft:coal_block', 1575, 3500, 0.95)
})
```

## Item Heats

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#item-heats)!

### Method Signature

```js
event.itemHeat(
    ingredient: Ingredient,
    heatCapacity: number,
    forgingTemperature: @Nullable number,
    weldingTemperature: @Nullable number,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the items the heat definition applies to
- 2nd argument: A number, specifies how fast the the item heats up relative to others, measured in Energy / °C
- 3rd argument: A number, specifies the temperature at which the item can be worked, may be `null`{:.p} to allow working at any temperature
- 4th argument: A number, specifies the temperature at which the item can be welded, may be `null`{:.p} to allow welding at any temperature
- *Optional 5th argument*: A `ResourceLocation`, the name of the heat definition

### Example

```js
TFCEvents.data(event => {
    event.itemHeat('minecraft:netherite_ingot', 0.7, null, 1700)
})
```

## Item Size

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#item-sizes)!

### Method Signature

```js
event.itemSize(
    ingredient: Ingredient,
    size: @Nullable Size,
    weight: @Nullable Weight,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the items the size applies to
- 2nd argument: A `Size`{:.e}, sets the size of the item, may be `tiny`{:.e}, `very_small`{:.e}, `small`{:.e}, `normal`{:.e}, `large`{:.e}, `very_large`{:.e}, `huge`{:.e}, or `null`{:.p} to not specify a size
- 3rd argument: A `Weight`{:.e}, sets the weight of the item, may be `very_light`{:.e}, `light`{:.e}, `medium`{:.e}, `heavy`{:.e}, `very_heavy`{:.e}, or `null`{:.p} to not specify a weight
- *Optional 4th argument*: A `ResourceLocation`, the name of the size definition

### Example

```js
TFCEvents.data(event => {
    event.itemSize('minecraft:gold_ingot', 'huge', 'very_heavy')
})
```

## Knapping Types

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#knapping-types)!

{: .notice #knapping-type-notice }
> Knapping ingredients *must* have the `tfc:any_knapping` tag. While this tag can be reloaded at runtime, a game restart is required for any changes to affect knapping interactions
>
> Additionally, the textures used by the screen itself should be placed in `/assets/tfc/textures/gui/knapping/<item_path>.png`{:.language-fs} and `/assets/tfc/textures/gui/knapping/<item_path>_disabled.png`{:.language-fs} if a disabled texture is used

### Method Signature

```js
event.knappingType(
    ingredient: Ingredient,
    ingredientCount: number,
    amountToConsume: number,
    clickSound: String,
    consumeAfterComplete: boolean,
    useDisabledTexture: boolean,
    spawnsParticles: boolean,
    jeiIconItem: ItemStack,
    name: ResourceLocation
)
```

- 1st argument: An item ingredient, the ingredient for what item has to be knapped, must be part of the `tfc:any_knapping` tag to work. You may also need to restart the MC instance for the game to recognize the item has been added to the tag
- 2nd argument: A number, the minimum number of items matching the ingredient that must be held in order open the knapping menu
- 3rd argument: A number, the number of items that gets used by a recipe
- 4th argument: A string, the registry name of a sound event that plays when knapping occurs[^2]
- 5th argument: A boolean, determines if the inputs should be consumed when the first square is clicked or when the result is removed
- 6th argument: A boolean, if true, a clicked spot will show a different texture rather than nothing
- 7th argument: A boolean, determines if the screen should spawn small particles when clicking buttons
- 8th argument: An `ItemStack`, the icon item for the JEI recipe category
- 9th argument: A `ResourceLocation`, the name of the knapping type

[^2]: A full list of all sound events can be attained by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game

### Example

```js
TFCEvents.data(event => {
    event.knappingType(
        'minecraft:deepslate',
        1,
        5,
        'minecraft:entity.warden.roar',
        false,
        true,
        true,
        'minecraft:deepslate',
        'kubejs:deepslate'
    )
})
```

## Lamp Fuels

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#lamp-fuels)!

### Method Signature

```js
event.lampFuel(
    fluidIngredient: FluidIngredient,
    blockIngredient: BlockIngredient,
    burnRate: number,
    name?: ResourceLocation
)
```

- 1st argument: A [FluidIngredient]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-ingredient), determines which fluids the lamp fuel applies to
- 2nd argument: A [BlockIngredient]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredinet), determines what (lamp) blocks are valid for this fuel to be added to
- 3rd argument: A number, represents how fast the fuel is consumed, in ticks per mB
- *Optional 4th argument*: A `ResourceLocation`, the name of the lamp fuel

### Example

```js
TFCEvents.data(event => {
    event.lampFuel('tfc:salt_water', '#tfc:lamps', 1)
})
```

## Metals

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#metals)!

### Method Signature

```js
event.metal(
    fluid: Fluid,
    meltTemperature: number,
    heatCapacity: number,
    ingot: @Nullable Ingredient,
    doubleIngot: @Nullable Ingredient,
    sheet: @Nullable Ingredient,
    tier: number,
    name?: ResourceLocation
)
```

- 1st argument: A `Fluid`, the fluid this metal is built upon
- 2nd argument: A number, the melting temperature of the metal
- 3rd argument: A number, specifies how fast the metal heats up relative to others, measured in Energy / (mB * °C)
- 4th argument: An item ingredient, defines the ingots of the metal, may be `null`{:.p} to indicate the metal does not have any ingots. The item also requires the `tfc:pileable_ingots` tag in order to be placeable
- 5th argument: An item ingredient, defines the double ingots of the metal, may be `null`{:.p} to indicate the metal does not have any double ingots. The item also requires the `tfc:pileable_double_ingots` tag in order to be placeable
- 6th argument: An item ingredient, defines the sheets of the metal, may be `null`{:.p} to indicate the metal does not have any sheets. The item also requires the `tfc:pileable_sheets` tag in order to be placeable
- 7th argument: A number, the tier of the metal
- *Optional 8th argument*: A `ResourceLocation`, the name of the metal

{: .notice #metal-notice }
> If no name is provided, one will be automatically generated from the fluid
>
> The name is generated like so:
>
> - The namespace becomes `kubejs_tfc`
> - the path becomes the name of the fluid with the following applied:
>     - All non `a-z0-9` characters are replaced with `_`
>     - All repeating `_`s are shortened to just one `_`
>     - Any preceding or trailing `_`s are removed
>     - The string is limited to its first 65 characters if applicable

### Example

```js
TFCEvents.data(event => {
    event.metal(
        'minecraft:lava',
        2000,
        0.5,
        null,
        null,
        'kubejs:lava_sheet',
        3,
        'kubejs:lava' // If the name had not be specified, it would have been 'kubejs_tfc:minecraft_lava'
    )
})
```

## Supports

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#supports)!

### Method Signature

```js
event.support(
    blockIngredient: BlockIngredient,
    up: number,
    down: number,
    horizontal: number,
    name?: ResourceLocation
)
```

- 1st argument: A [BlockIngredient]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient), determines what blocks the support applies to
- 2nd argument: A number, the number of blocks up the block supports
- 3rd argument: A number, the number of blocks down the block supports
- 4th argument: A number, the number of blocks horizontally the block supports
- *Optional 5th argument*: A `ResourceLocation`, the name of the support

### Example

```js
TFCEvents.data(event => {
    event.support('minecraft:cobblestone_wall', 3, 4, 10)
})
```

## Sluicing

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#sluicing)!

### Method Signature

```js
event.sluicing(
    ingredient: Ingredient,
    lootTable: String,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the items the sluicing definition applies to
- 2nd argument: A string, the location of a loot table to be dropped for this item
- *Optional 3rd argument*: A `ResourceLocation`, the name of the sluicing definition

### Example

```js
TFCEvents.data(event => {
    event.sluicing('minecraft:rooted_dirt', 'kubejs:roots')
})
```

## Panning

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/custom/#panning)!

### Method Signature

```js
event.panning(
    blockIngredient: BlockIngredient,
    lootTable: String,
    models: String[],
    name?: ResourceLocation
)
```

- 1st argument: A [BlockIngredient]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient), the blocks that will go into the pan
- 2nd argument: A string, the location of a loot table to be dropped for the ingredient
- 3rd argument: A list of strings which are model locations to be iterated through as panning progresses
- *Optional 4th argument*: A `ResourceLocation`, the name of the panning definition

### Example

```js
TFCEvents.data(event => {
    event.panning(
        'minecraft:gravel',
        'kubejs:gravel_panning',
        [
            'tfc:item/pan/native_gold/quartzite_full',
            'tfc:item/pan/native_gold/result'
        ]
    )
})
```

## Firmalife Greenhouse Type

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```js
event.firmalifeGreenhouseType(
    ingredient: BlockIngredient,
    tier: number,
    name?: ResourceLocation
)
```

- 1st argument: A [BlockIngredient]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient), the blocks that will be accepted by the greenhouse type
- 2nd argument: A number, the tier of the greenhouse, values for the default types are as follows:
    - Wood: 5
    - Copper: 10
    - Iron: 15
    - Stainless Steel: 20
- *Optional 3rd argument*: A `ResourceLocation`, the name of the greenhouse type

### Example

```js
TFCEvents.data(event => {
    event.firmalifeGreenhouseType('#kubejs:greenhouse_glass', 7)
})
```

## Firmalife Planter

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```js
event.firmalifePlantable(
    ingredient: Ingredient,
    planterType: @Nullable PlanterType,
    tier: @Nullable number,
    stages: @Nullable number,
    extraSeedChance: @Nullable number,
    seed: @Nullable ItemStack,
    crop: ItemStack,
    nutrient: @Nullable NutrientType,
    textures: String[],
    special: @Nullable String,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the seed items to be used for the plantable definition
- 2nd argument: The planter type to use, may be `quad`{:.e}, `large`{:.e}, `hanging`{:.e}, `trellis`{:.e}, `bonsai`{:.e}, or `hydroponic`{:.e}, may be `null`{:.p} to default to `quad`{:.e}
- 3rd argument: The minimum greenhouse tier needed for the plant to grow, defaults to `0`{:.n}
- 4th argument: How many stages the planter has, one less than the number of textures the planter must cycle through, may be `null`{:.p} for `trellis`{:.e}, and `bonsai`{:.e} planter types
- 5th argument: A number, in the range [0, 1], determines the chance of getting an extra seed stack back when harvesting, may be `null`{:.p} to default to `0.5`{:.n}
- 6th argument: An item stack, the seed item returned when harvested, may be `null`{:.p} to not drop a seed item
- 7th argument: An item stack, the product of the crop
- 8th argument: A `NutrientType`{:.e}, the nutrient the crop consumes, may be `nitrogen`{:.e}, `phosphorous`{:.e}, or `potassium`{:.e}, may be `null`{:.e} to default to `nitrogen`{:.e}
- 9th argument: An array of strings, the path of textures to use. Has different rules for different planter types
    - For `large`{:.e}, `quad`{:.e}, `hydroponic`{:.e}, and `hanging`{:.e} planter types: Order the textures in the same order as the growth order
    - For the `trellis`{:.e} planter type: Order the textures in the order growing, dry, flowering, fruiting
    - For the `bonsai`{:.e} planter type: Order the textures in the order fruiting, dry, flowering, branch, leaves
- 10th argument: A string, the extra texture used by `hanging`{:.e} planter types. Pass in the fruit texture if the planter type is `hanging`{:.e} else pass in `null`{:.p}
- *Optional 11th argument*: A `ResourceLocation`, the name of the planter definition

### Example

```js
TFCEvents.data(event => {
    event.firmalifePlantable(
        'minecraft:beetroot_seeds',
        'bonsai',
        15,
        null,
        0.1,
        'minecraft:beetroot_seeds',
        'minecraft:beetroots',
        'potassium',
        [
            'kubejs:block/planter/beet_fruiting',
            'kubejs:block/planter/beet_dry',
            'kubejs:block/planter/beet_flowering',
            'kubejs:block/planter/beet_branch',
            'kubejs:block/planter/beet_leaves'
        ],
        null
    )
})
```

## Beneath Nether Fertilizer

Defines a new nether fertilizer

### Method Signature

```js
event.beneathNetherFertilizer(
    ingredient: Ingredient,
    death: @Nullable number,
    destruction: @Nullable number,
    decay: @Nullable number,
    sorrow: @Nullable number,
    flame: @Nullable number,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the items this definition applies to
- 2nd argument: A number, in the range [0, 1], sets the `death`{:.v} value of the fertilizer, may be `null`{:.p} to omit specifying a value
- 3rd argument: A number, in the range [0, 1], sets the `destruction`{:.v} value of the fertilizer, may be `null`{:.p} to omit specifying a value
- 4th argument: A number, in the range [0, 1], sets the `decay`{:.v} value of the fertilizer, may be `null`{:.p} to omit specifying a value
- 5th argument: A number, in the range [0, 1], sets the `sorrow`{:.v} value of the fertilizer, may be `null`{:.p} to omit specifying a value
- 6th argument: A number, in the range [0, 1], sets the `flame`{:.v} value of the fertilizer, may be `null`{:.p} to omit specifying the value
- *optional 7th argument*: A `ResourceLocation`, the name of the nether fertilizer definition

### Example

```js
TFCEvents.data(event => {
    event.beneathNetherFertilizer(
        'minecraft:nether_wart',
        0.1,
        null,
        null,
        0.25,
        null,
        'kubejs:sorrow_wart'
    )
})
```

## Beneath Lost Page

Defines a new lost page ritual, added to the pool of possible rituals that may be acquired when a lost page is 'activated'

### Method Definition

```js
event.beneathLostPage(
    ingredient: Ingredient,
    reward: Item,
    costs: number[],
    rewards: number[],
    punishments: Punishment[],
    langKey: @Nullable String,
    name?: ResourceLocation
)
```

- 1st argument: An item ingredient, the ingredient required to perform the ritual
- 2nd argument: A item, the reward for completing the ritual
- 3rd argument: A number array, must contain at least one value. When a lost page is 'activated', one of these numbers will be chosen and used as the number of ingredients required
- 4th argument: A number array, must contain at least one value. When a lost page is 'activated', one of these numbers will be chosen and used as the number of reward items the ritual gives
- 5th argument: A `Punishment`{:.e} array, must contain at least one value. When a lost page is 'activated', one of these punishments will be chosen and for application on ritual completion. The available punishments are as follows
    - `none`{:.e}: Does nothing
    - `levitation`{:.e}: Makes nearby living entities levitate briefly
    - `drunkenness`{:.e}: Makes the player drunk and nauseous
    - `blaze_inferno`{:.e}: Spawns a handful of blazes nearby and alights the ground
    - `infestation`{:.e}: Spawns a handful of silverfish nearby
    - `withering`{:.e}: Spawns a handful of wither skeletons nearby and gives the player withering
    - `slime`{:.e}: Spawns a handful of slimes nearby, drops some slimeballs on the ground, and replaces certain blocks nearby with slimed netherrack
    - `unknown`{:.e}: Randomly selects one of the other punishments to enact
- 6th argument: A string, the lang key to use instead of the ingredients when a 'activated' lost page's info screen is present. Useful for ingredients that are not single items. may be `null`{:.p} to default to the ingredient's first valid item
- *optional 7th argument*: A `ResourceLocation`, the name of the lost page definition

### Example

```js
TFCEvents.data(event => {
    event.beneathLostPage(
        '#forge:cobblestone',
        'minecraft:blackstone',
        [
            50,
            89,
            32,
            78,
            65,
            120
        ],
        [
            20,
            45,
            8
        ],
        [
            'withering'
        ],
        'block.minecraft.cobblestone'
    )
})
```

## Attached TFC data

In order to add nutrition, the chisel mode, and a few other things TFC attaches some extra data to the player. This can be accessed through a `Player` object through the `.getData()`{: .language-kube } method which returns a `Map<String, Object>`{: .language-kube }. TFC's data can be accessed through `tfc:player_data`

There are several methods to access and modify the state of TFC's additional data

### Method Signatures

```js
data.getChiselMode(): ChiselMode
data.setChiselMode(mode: ChiselMode): void
data.getIntoxicatedTicks(): number
data.addIntoxicatedTicks(ticks: number): void
data.getLastDrinkTick(): number
data.setLastDrinkTick(tick: number): void
data.playerEat(item: ItemStack): void
data.getFoodLevel(): number
data.setFoodLevel(i: number): void
data.needsFood(): boolean
data.addExhaustion(f: number): void
data.getSaturationLevel(): number
data.setSaturationLevel(f: number): void
data.getThirstModifier(): number
data.getThirstContributionFromTemperature(): number
data.getThirst(): number
data.setThirst(f: number): void
data.addThirst(f: number): void
data.getAverageNutrition(): number
data.getNutrient(nutrient: NutrientType): number
data.getNutrients(): number[]
```

- `.getChiselMode()`{: .language-kube #player-data-chisel }: Returns the player's current `ChiselMode`{:.e}, will be either `smooth`{:.e}, `stair`{:.e}, or `slab`{:.e}
- `.setChiselMode(mode: ChiselMode)`{: .language-kube #player-data-set-chisel }: Sets the player's current chisel mode, will accept `smooth`{:.e}, `stair`{:.e}, or `slab`{:.e}
- `.getIntoxicatedTicks()`{: .language-kube #player-data-intoxication-ticks }: Returns the number of ticks the player is intoxicated for
- `.addIntoxicatedTicks(ticks: number)`{: .language-kube #player-data-add-intoxication-ticks }: Adds to the player's intoxicated ticks
- `.getLastDrinkTick()`{: .language-kube #player-data-last-drink-tick }: Returns the last tick the player drank something
- `.setLastDrinkTick(tick: number)`{: .language-kube #player-data-set-last-drink-tick }: Sets the last tick the player drank something
- `.playerEat(item: ItemStack)`{: .language-kube #player-data-eat }: Makes the player eat the provided `ItemStack`
- `.getFoodLevel()`{: .language-kube #player-data-food-level }: Returns the player's current food level
- `.setFoodLevel(i: number)`{: .language-kube #player-data-set-food-level }: Sets the player's current food level
- `.needsFood()`{: .language-kube #player-data-needs-food }: Returns true if the player needs food
- `.addExhaustion(f: number)`{: .language-kube #player-data-add-exhaustion }: Adds the given exhaustion to the player
- `.getSaturationLevel()`{: .language-kube #player-data-saturation-level }: Returns the player's saturation level
- `.setSaturationLevel(f: number)`{: .language-kube #player-data-set-saturation-level }: Sets the player's saturation level
- `.getThirstModifier()`{: .language-kube #player-data-thirst-modifier }: Returns the player's total thirst loss per tick, on a scale of [0, 100]
- `.getThirstContributionFromTemperature()`{: .language-kube #player-data-thirst-contribution-temp }: Returns the player's total thirst lost per tick from ambient temperature in addition to regular loss
- `.getThirst()`{: .language-kube #player-data-thirst }: Returns the player's thirst
- `.setThirst(f: number)`{: .language-kube #player-data-set-thirst }: Sets the player's thirst
- `.addThirst(f: number)`{: .language-kube #player-data-add-thirst }: Adds the provided thirst the the player's thirst
- `.getAverageNutrition()`{: .language-kube #player-data-avg-nutrition }: Returns the average nutrition level of the player
- `.getNutrient(nutrient: NutrientType)`{: .language-kube #player-data-nutrient }: Returns the player's nutrition level for the given nutrient, accepts `grain`{:.e}, `fruit`{:.e}, `vegetables`{:.e}, `protein`{:.e}, and `dairy`{:.e}
- `.getNutrients()`{: .language-kube #player-data-nutrients }: Returns an array of 5 numbers, corresponding to each nutrient in the order `grain`{:.e}, `fruit`{:.e}, `vegetables`{:.e}, `protein`{:.e}, `dairy`{:.e}

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
