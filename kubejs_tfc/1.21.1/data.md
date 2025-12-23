---
layout: page
title: Data
permalink: /kubejs_tfc/1.21.1/data/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation on Creating TFC's data types in scripts
---

# Data

TFC's data types can be created through the `TFCEvents.data` event in the `server_scripts` folder

- [Climate Range](#climate-range)
- [Deposit](#deposit)
- [Drinkable](#drinkable)
- [Entity Damage Resistance](#entity-damage-resistance)
- [Fauna](#fauna)
- [Fertilizer](#fertilizer)
- [Fluid Heat](#fluid-heat)
- [Food](#food)
- [Fuel](#fuel)
- [Heat](#heat)
- [Item Damage Resistance](#item-damage-resistance)
- [Item Size](#item-size)
- [Knapping Type](#knapping-type)
- [Lamp Fuel](#lamp-fuel)
- [Support](#support)

{: .notice #general-notice }
> Most of these methods have an optional final argument which specifies the id of the virtual json file the data will be placed in. For instance, if an id of `fish:get_pierced` was used for an entity damage resistance, the resulting file would effectively be at `data/fish/tfc/entity_damage_restances/get_pierced.json`{: .language-fs }; the `tfc/<data_type>`{: .language-fs } folders do not need to be provided
>
> If no id is provided, one will automatically be generated with the namespace `kubejs` and, unless other wise noted, a path matching the base 16 hash of the (usually) 1st argument's `.toString()`{: .language-kube-21 } value
>
> Additionally, for data types that use ingredients, if there are multiple definitions with the same valid item/block/fluid/entity, then there is no guarantee as to which will take precedence. This situation can be confirmed by using the [search command]({% link kubejs_tfc/1.21.1/commands.md %}#search) and fixed by either overriding the existing definition or changing the entries in the tag it uses

## Climate Range

Defines the values of an existing, registered climate range, does not create new ones

{: #climate-range-method }

### Method Signature

```js-21
event.climateRange(
    range: ClimateRange,
    id: ResourceLocation
)
```

- 1st argument: The climate range, a map of parameters to values
    - `minHydration: int`{:.language-kube-21}: The minimum hydration the plant can grow in
    - `maxHydration: int`{:.language-kube-21}: The maximum hydration the plant can grow in
    - `hydrationWiggleRange`{:.language-kube-21}: Additional hydration range in which the plant can survive, but not necessarily grow, in
    - `minTemperature: number`{:.language-kube-21}: The minimum temperature, in °C, the plant can grow in
    - `maxTemperature: number`{:.language-kube-21}: The maximum temperature, in °C, the plant can grow in
    - `temperatureWiggleRange: number`{:.language-kube-21}: Additional temperature range in which the plant can survive, but not necessarily grow, in
- 2nd argument: The registered id of the climate range being defined

{: #climate-range-example }

### Example

```js-21
TFCEvents.data(event => {
    event.climateRange({
        minHydration: 15,
        maxHydration: 75,
        minTemperature: -2,
        maxTemperature: 26
    }, 'kubejs:circada_crop')
})
```

## Deposit

Add a deposit definition, which allows an item to processed in a pan or sluice

{: #deposit-method }

### Method Signature

```js-21
event.deposit(
    ingredient: Ingredient,
    lootTable: ResouceKey<LootTable>,
    modelStages: List<ResourceLocation>,
    id?: ResourceLocation
)
```

- 1st argument: An item ingredient, the items the deposit applies to
- 2nd argument: The id of a loot table, the result of panning/sluicing the item
- 3rd argument: The models to display in sequence while panning
- *Optional 4th argument*:  A `ResourceLocation`{:.language-kube-21}, the id of the deposit

{: #deposit-example }

### Example

```js-21
TFCEvents.data(event => {
    event.deposit(
        '#minecraft:flowers',
        'kubejs:flower_loot',
        [
            'minecraft:block/poppy',
            'minecraft:block/daisy',
            'minecraft:block/cornflower'
        ]
    )
})
```

## Drinkable

Add a drinkable definition, allows a fluid to be drunk for thirst, nutrients, and even effects

{: #drinkable-method }

### Method Signature

```js-21
event.drinkable(
    drinkable: Drinkable,
    id?: ResourceLocation
)
```

- 1st argument: The drinkable data, a map of parameters to values
    - `ingredient: FluidIngredient`{:.language-kube-21}: The fluids the drink data applies to
    - `consumeChance?: number`{:.language-kube-21}: The chance, {% in_range 0,1 %}, a block of fluid will be consumed when drinking from in-world
    - `mayDrinkWhenFull?: boolean`{:.language-kube-21}: If the player can drink this with a full thirst bar,
    - `food?: FoodData`{:.language-kube-21}: Additional food and nutrient data, can be specified as a map of
        - `hunger: int`{:.language-kube-21}: The amount of hunger to add. A full hunger bar is 20
        - `water: number`{:.language-kube-21}: The amount of thirst to restore. A full thirst bar is 100
        - `saturation: number`{:.language-kube-21}: The amount of saturation to provide
        - `intoxication: int`{:.language-kube-21}: The number of ticks of intoxication to add to the player
        - `nutrients: number[5]`{:.language-kube-21}: The nutrient amounts to add to the player, ordered as `grain`{:.e}, `fruit`{:.e}, `vegetables`{:.e}, `protein`{:.e}, and `dairy`{:.e}
    - `effects?: List<Effect>`{:.language-kube-21}: A list of effects to apply, an effect can be specified as a map of
        - `type: Holder<ModEffect>`{:.language-kube-21}: The effect to apply
        - `duration: int`{:.language-kube-21}: How many ticks the effect should be active for
        - `amplifier?: int`{:.language-kube-21}: The level of the effect
        - `chance?: number`{:.language-kube-21}: The chance, {% in_range 0,1 %}, the effect is added
- *Optional 2nd argument*:  A `ResourceLocation`{:.language-kube-21}, the id of the drinkable

{: #drinkable-example }

### Example

```js-21
TFCEvents.data(event => {
    event.drinkable({
        ingredient: Fluid.of('lava', 500),
        mayDrinkWhenFull: true,
        food: {
            nutrients: [
                0,
                0,
                0,
                500,
                0
            ]
        },
        effects: [
            {
                type: 'minecraft:wither',
                duration: 500,
                amplifier: 3,
                chance: 1
            }
        ]
    })
})
```

## Entity Damage Resistance

Add an entity damage resistance

{: #entity-damage-resistance-method }

### Method Signature

```js-21
event.entityDamageResistance(
    entity: TagKey<EntityType<?>>,
    resistance: PhysicalDamage,
    id?: ResourceLocation
)
```

- 1st argument: The entities the resistances applies to
- 2nd argument: The resistance data, a map of types to values
    - `piercing?: number`{:.language-kube-21}: The piercing resistance, may be negative to make the entity weak to piercing
    - `slashing?: number`{:.language-kube-21}: The slashing resistance, may be negative to make the entity weak to slashing
    - `crushing?: number`{:.language-kube-21}: The crushing resistance, may be negative to make the entity weak to crushing
- *Optional 3rd argument*: A `ResourceLocation`{:.language-kube-21}, the id of the resistance

{: #entity-damage-resistance-example }

```js-21
TFCEvents.data(event => {
    event.entityDamageResistance(
        'minecraft:fish', 
        {
            piercing: -800
        },
        'fish:get_pierced'
    )
})
```

## Fauna

Defines the values of an existing, registered fauna, does not create new ones. See [the relevant event]({% link kubejs_tfc/1.21.1/events.md %}#fauna-spawns) for doing so

{: #fauna-method }

### Method Signature

```js-21
event.fauna(
    builder: Consumer<FaunaBuilder>,
    id: ResourceLocation
)
```

- 1st argument: A consumer with several methods
    - `.minTemperature(min: number)`{:.language-kube-21}: Sets the minimum temperature (and the maximum temperature to infinity)
    - `.maxTemperature(max: number)`{:.language-kube-21}: Sets the maximum temperature (and the minimum temperature to negative infinity)
    - `.temperature(min: number, max: number)`{:.language-kube-21}: Sets the maximum and minimum temperature
    - `.minGroundwater(min: number)`{:.language-kube-21}: Sets the minimum temperature (and the maximum groundwater to infinity)
    - `.maxGroundwater(max: number)`{:.language-kube-21}: Sets the maximum temperature (and the minimum groundwater to negative infinity)
    - `.groundwater(min: number, max: number)`{:.language-kube-21}: Sets the maximum and minimum groundwater
    - `.minRainVariance(min: number)`{:.language-kube-21}: Sets the minimum rain variance (and maximum rain variance to `1`{:.n} and absolute rain variance to `false`{:.p})
    - `.maxRainVariance(max: number)`{:.language-kube-21}: Sets the maximum rain variance (and minimum rain variance to `-1`{:.n} and absolute rain variance to `false`{:.p})
    - `rainVariance(min: number, max: number, absolute: boolean)`{:.language-kube-21}: Sets the permissible rain variance, {% in_range -1,1 %} and if the sign of the rain variance should be ignored
    - `.minForest(min: int)`{:.language-kube-21}: Sets the minimum forest density (and maximum forest density to `4`{:.n})
    - `.maxForest(max: int)`{:.language-kube-21}: Sets the maximum forest density (and minimum forest density to `0`{:.n})
    - `.forest(min: int, max: int)`{:.language-kube-21}: Sets the permissible forest density, {% in_range 0,4 %}
    - `.forestType(types...: ForestType[])`{:.language-kube-21}: Restricts spawning to within the given [`ForestType`{:.e}s]({% link kubejs_tfc/1.21.1/type-explanations.md %}#forest-type-enum){:.preserve-color}
    - `.minElevation(min: int)`{:.language-kube-21}: Sets the minimum elevation (and maximum elevation to `320`{:.n})
    - `.maxElevation(max: int)`{:.language-kube-21}: Sets the maximum elevation (and minimum elevation to `-64`{:.n})
    - `.elevation(min: int, max: int)`{:.language-kube-21}: Sets the permissible elevation range
    - `.months(months: List<Month>)`{:.language-kube-21}: Set the [`Month`{:.e}s]({% link kubejs_tfc/1.21.1/type-explanations.md %}#month-enum) during which spawning is valid
    - `.chance(value: int)`{:.language-kube-21}: Sets the spawn chance
    - `.distanceBelowSeaLevel(value: int)`{:.language-kube-21}: Sets the distance below sea level required to spawn
    - `.maxBrightness(value: int)`{:.language-kube-21}: Sets the maximum light level spawning can occur under
    - `.fuzzy()`{:.language-kube-21}: Makes the temperature, groundwater, and rain variance limits fuzzy when evaluating
    - `.solid()`{:.language-kube-21}: Makes it so spawning can only occur on blocks tagged `minecraft:valid_sapwn`
    - `.ignoreRivers()`{:.language-kube-21}: Makes river contributions to groundwater are ignored
- 2nd argument: A `ResourceLocation`, the id of the fauna

{: #fauna-example }

### Example

```js-21
TFCEvents.data(event => {
    event.fauna(fauna => {
        fauna.temperature(-20, 5)
        fauna.forest(1, 3)
        fauna.fuzzy()
        fauna.solid()
    }, 'tfc:fox')
})
```

## Fertilizer

## Fluid Heat

## Food

## Fuel

## Heat

## Item Damage Resistance

Add an item damage resistance

{: .item-damage-resistance-method }

### Method Signature

```js-21
event.itemDamageResistance(
    ingredient: Ingredient,
    resistance: PhysicalDamage,
    id?: ResourceLocation
)
```

- 1st argument: The items the resistance applies to
- 2nd argument: The resistance data, a map of types to values
    - `piercing?: number`{:.language-kube-21}: The piercing resistance, may be negative to make the entity weak to piercing
    - `slashing?: number`{:.language-kube-21}: The slashing resistance, may be negative to make the entity weak to slashing
    - `crushing?: number`{:.language-kube-21}: The crushing resistance, may be negative to make the entity weak to crushing
- *Optional 3rd argument*: A `ResourceLocation`{:.language-kube-21}, the id of the resistance

{: #item-damage-resistance-example }

### Example

```js-21
TFCEvents.data(event => {
    event.itemDamageResistance(
        '#kubejs:weak_to_slashing',
        {
            slashing: -30,
            piercing: -2,
            crushing: 5
        }
    )
})
```

## Item Size

## Knapping Type

## Lamp Fuel

## Support
