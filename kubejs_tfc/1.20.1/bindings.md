---
layout: page
title: Bindings
permalink: /kubejs_tfc/1.20.1/bindings/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Bindings

{: .notice }
Work In Progress!

In 1.20, there was a major restructuring to how bindings/wrappers are handled in KubeJS TFC, now everything is centered under a singular `TFC` object accessible in any script at any time

This provides access to various objects and methods that can be used throughout your scripts

## Methods

These are methods which can be accessed directly from the `TFC` object 

### Alloy Part

This defines an object which defines the values used in an [alloy recipe](../recipes/#alloy)'s input contents

Method signature:
```ts
TFC.alloyPart(metal: string, min: number, max: number)
```

Creates an `AlloyPart` which can be converted to and from json easily. Only values in the range [0, 1] are valid for the `min` and `max` arguments

Example:
```js
TFC.alloyPart('tfc:steel', 0.1, 0.5)
```
in json:
```json
{
    "metal": "tfc:steel",
    "min": 0.1,
    "max": 0.5
}
```

### Block Ingredient

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/common-types/#block-ingredients)!

Method signature:
```ts
TFC.blockIngredient(blockIngredient: (string | Block | BlockState | TagKey<Block> | List<(string | Block | BlockState | tagKey<Block>)> | BlockIngredient))
```

Creates a `BlockIngredient` representing the blocks/tags given. If provided a string, a `#` at the beginning will cause it to be interpreted as a tag

Examples:
```js
TFC.blockIngredient('minecraft:dirt')
TFC.blockIngredient(['tfc:rock/cobble/dacite', '#forge:stones'])
```
In json:
```json
{
    "block": "minecraft:dirt"
}
```
```json
[
    {
        "block": "tfc:rock/cobble/dacite"
    },
    {
        "tag": "forge:stones"
    }
]
```

### Fluid Ingredient

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/common-types/#fluid-ingredients)!

Method signature:
```ts
TFC.fluidIngredient(fluidIngredient: (string | Fluid | TagKey<Fluid> | FluidStackJS | List<(string | Fluid | TagKey<Fluid> | FluidStackJS)> | FluidIngredient | FluidStackIngredient))
```

Creates a `FluidIngredient` representing the fluids/tags given. If provided a string, a `#` at the beginning will cause it to be interpreted as a tag

Examples:
```js
TFC.fluidIngredient('minecraft:water')
TFC.fluidIngredient(['minecraft:lava', '#tfc:usable_in_ingot_mold'])
```
in json:
```json
{
    "fluid": "minecraft:water"
}
```
```json
[
    {
        "fluid": "minecraft:lava"
    },
    {
        "tag": "tfc:usable_in_ingot_mold"
    }
]
```

### Fluid Stack Ingredient

Method signatures:
```ts
TFC.fluidStackIngredient(fluidIngredient: FluidIngredient, amount: number)
TFC.fluidStackIngredient(fluidStackIngredient: (string | Fluid | TagKey<fluid> | FluidStackJS | List<(string | Fluid | tagKey<Fluid> | FluidstackJS)> | FluidIngredient | FluidStackIngredient))
```

## Sub-Bindings

These are bindings which provide access to more methods in a grouped manner

### Calendar

### Climate

### Ingredient

The cental place for creating TFC's different [ingredient types](https://terrafirmacraft.github.io/Documentation/1.20.x/data/ingredients/) in your scripts

#### Heatable

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/ingredients/#heatable)!

Method signature:
```js
TFC.ingredient.heatable(delegate?: Ingredient, min: @Nullable number, max: @Nullable number)
```

Creates an ingredient of type `tfc:heatable` with the minimum and maximum temperatures defined by the `min` and `max` arguments, and the ingredient defined by the `delegate` argument

Examples:
```js
TFC.ingredient.heatable('minecraft:iron_ingot', null, 673)
TFC.ingredient.heatable(750, 895)
```
In json:
```json
{
    "type": "tfc:heatable",
    "ingredient": {
        "item": "minecraft:iron_ingot"
    },
    "max_temp": 673
}
```
```json
{
    "type": "tfc:heatable",
    "min_temp": 750,
    "max_temp": 865
}
```

### Item Stack Provider