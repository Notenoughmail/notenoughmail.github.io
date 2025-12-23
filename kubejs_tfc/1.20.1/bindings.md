---
layout: page
title: Bindings
permalink: /kubejs_tfc/1.20.1/bindings/
parent: 1.20.1
grand_parent: KubeJS TFC
has_children: true
desc: Documentation on the methods available under the `TFC` object in scripts
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
    - [Misc. Bindings](#miscellaneous)

## Methods

These are methods which can be accessed directly from the `TFC` object

{: #alloy-part}

### AlloyPart

This defines an object which defines the values used in an [alloy recipe]({% link kubejs_tfc/1.20.1/recipes.md %}#alloy)'s input contents

Method signature:

```js-20
TFC.alloyPart(metal: String, min: number, max: number, keepOriginalBounds?: boolean): AlloyPart
```

- `metal: String`{: .language-kube-20 }: The metal
- `min: number`{: .language-kube-20 }: The minimum percent, {% in_range 0,1 %}, of the metal
- `max: number`{: .language-kube-20 }: The maximum percent, {% in_range 0,1 %}, of the metal
- `keepOriginalBounds?: boolean`{: .language-kube-20 }: When [replacing]({% link kubejs_tfc/1.20.1/misc.md %}#recipe-replacement-alloy-part) an alloy part, if the bounds should stay as they were originally in the recipe. Defaults to `true`{:.p}

Creates an `AlloyPart` for use in [alloying recipes]({% link kubejs_tfc/1.20.1/recipes.md %}#alloy)

Example:

```js-20
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

{: #block-ingredient }

### BlockIngredient

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/common-types/#block-ingredients)!

Method signature:

```js-20
TFC.blockIngredient(blockIngredient: (String | Block | BlockState | TagKey<Block> | Regex | List<(String | Block | BlockState | tagKey<Block> | Regex)> | BlockIngredient)): BlockIngredient
```

Creates a `BlockIngredient` representing the blocks/tags given. If provided a string, a `#` at the beginning will cause it to be interpreted as a tag

Examples:

```js-20
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

{: #fluid-ingredient }

### FluidIngredient

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/common-types/#fluid-ingredients)!

Method signature:

```js-20
TFC.fluidIngredient(fluidIngredient: (String | Fluid | TagKey<Fluid> | FluidStackJS | Regex | List<(String | Fluid | TagKey<Fluid> | FluidStackJS | Regex)> | FluidIngredient | FluidStackIngredient)): FluidIngredient
```

Creates a `FluidIngredient` representing the fluids/tags given. If provided a string, a `#` at the beginning will cause it to be interpreted as a tag

Examples:

```js-20
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

{: #fluid-stack-ingredient }

### FluidStackIngredient

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/common-types/#fluid-stack-ingredients)!

Method signatures:

```js-20
TFC.fluidStackIngredient(fluidIngredient: FluidIngredient, amount: number): FluidStackIngredient
TFC.fluidStackIngredient(fluidStackIngredient: (String | Fluid | TagKey<fluid> | FluidStackJS | Regex | List<(String | Fluid | tagKey<Fluid> | FluidStackJS | Regex)> | FluidIngredient | FluidStackIngredient)): FluidStackIngredient
```

Creates a `FluidStackIngredient` representing the fluids/tags given with the provided amount or with a default amount of 1000 if no amount can be assumed from the given object.

Examples:

```js-20
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

### [Calendar]({% link kubejs_tfc/1.20.1/bindings/calendar.md %})

The central place for dealing with TFC's calendar system in your scripts

### [Climate]({% link kubejs_tfc/1.20.1/bindings/climate.md %})

The central place for interacting with TFC's climate system in your scripts

### [Ingredient]({% link kubejs_tfc/1.20.1/bindings/ingredient.md %})

The central place for creating TFC's different [ingredient types](https://terrafirmacraft.github.io/Documentation/1.20.x/ingredients/) in your scripts

### [Item Stack Provider]({% link kubejs_tfc/1.20.1/bindings/isp.md %})

The central place for dealing with TFC's [item stack provider](https://terrafirmacraft.github.io/Documentation/1.20.x/common-types/#item-stack-providers)s in your scripts

### [Miscellaneous]({% link kubejs_tfc/1.20.1/bindings/misc.md %})

A collection of various miscellaneous things that may be used in scripts

{% comment %}

### calendar

### climate

### ingredient

### item stack provider

### miscellaneous

### alloy part

### block ingredient

### fluid ingredient

### fluid stack ingredient

{% endcomment %}
