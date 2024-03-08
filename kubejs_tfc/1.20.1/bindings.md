---
layout: page
title: Bindings
permalink: /kubejs_tfc/1.20.1/bindings/
parent: 1.20.1
grand_parent: KubeJS TFC
has_children: true
has_toc: false
---

# Bindings

In 1.20, there was a major restructuring to how bindings/wrappers are handled in KubeJS TFC, now everything is centered under a singular `TFC` object accessible in any script at any time

This provides access to various objects and methods that can be used throughout your scripts

- [Methods](#methods)
    - [Alloy Part](#alloy-part)
    - [Block Ingredient](#block-ingredient)
    - [Fluid Ingredient](#fluid-ingredient)
    - [Fluid Stack Ingredient](#fluid-stack-ingredient)
- [Sub-Bindings](#sub-bindings)
    - [Calendar](#calendar)
    - [Climate](#climate)
    - [Ingredient](#ingredient)
    - [Item Stack Provider](#item-stack-provider)

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

In json:

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

In json:

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/common-types/#fluid-stack-ingredients)!

Method signatures:

```ts
TFC.fluidStackIngredient(fluidIngredient: FluidIngredient, amount: number)
TFC.fluidStackIngredient(fluidStackIngredient: (string | Fluid | TagKey<fluid> | FluidStackJS | List<(string | Fluid | tagKey<Fluid> | FluidStackJS)> | FluidIngredient | FluidStackIngredient))
```

Creates a `FluidStackIngredient` representing the fluids/tags given with the provided amount or with a default amount of 1000 if no amount can be assumed from the given object.

Examples:

```js
TFC.fluidStackIngredient('minecraft:water', 10)
TFC.fluidStackIngredient(Fluid.of('minecraft:lava', 30))
TFC.fluidStackIngredient(['minecraft:water', '#minecraft:lava'], 3)
TFC.fluidStackIngredient(['tfc:lye','#tfc:metal'])
```

In json:

```json
{
    "ingredient": {
        "fluid": "minecraft:water"
    },
    "amount": 10
}
```

```json
{
    "ingredient": {
        "fluid": "minecraft:lava"
    },
    "amount": 30
}
```

```json
{
    "ingredient": [
        {
            "fluid": "minecraft:water"
        },
        {
            "tag": "minecraft:lava"
        }
    ],
    "amount": 3
}
```

```json
{
    "ingredient": [
        {
            "fluid": "tfc:lye"
        },
        {
            "tag": "tfc:metal"
        }
    ],
    "amount": 1000
}
```

## Sub-Bindings

These are bindings which provide access to more methods in a grouped manner

### [Calendar](../bindings/calendar/)

The central place for dealing with TFC's calendar system in your scripts

### [Climate](../bindings/climate/)

The central place for interacting with TFC's climate system in your scripts

### [Ingredient](../bindings/ingredient/)

The central place for creating TFC's different [ingredient types](https://terrafirmacraft.github.io/Documentation/1.20.x/data/ingredients/) in your scripts

### [Item Stack Provider](../bindings/isp/)

The central place for dealing with TFC's [item stack provider](https://terrafirmacraft.github.io/Documentation/1.20.x/data/common-types/#item-stack-providers)s in your scripts

### [Miscellaneous](../bindings/misc/)

A collection of various miscellaneous things that may be used in scripts
