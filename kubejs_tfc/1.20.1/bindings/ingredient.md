---
layout: page
title: Ingredient Bindings
permalink: /kubejs_tfc/1.20.1/bindings/ingredient/
parent: Bindings
grand_parent: 1.20.1
---

# Ingredient Bindings

TFC has several [ingredient types](https://terrafirmacraft.github.io/Documentation/1.20.x/ingredients/) that it uses in its recipes

- [Fluid Item](#fluid-item)
- [Has Trait](#has-trait)
- [Heatable](#heatable)
- [Lacks Trait](#lacks-trait)
- [Not](#not)
- [Not Rotten](#not-rotten)

## Fluid Item

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/ingredients/#fluid-item)!

### Method Signature

```ts
TFC.ingredient.fluid(delegate?: Ingredient, fluid: FluidStackIngredient)
```

- *Optional 1st argument*: An item ingredient to which this ingredient applies to
- 2nd argument: A [fluid stack ingredient](/kubejs_tfc/1.20.1/bindings/#fluid-stack-ingredient), the fluid(s) this ingredient matches

Creates an ingredient of type `tfc:fluid_item` with the fluid ingredient defined by the `fluid` argument and the item ingredient defined by the `delegate` argument

### Examples

```js
TFC.ingredient.fluid('#tfc:molds', TFC.fluidStackIngredient(['minecraft:water', '#minecraft:lava'], 50))
TFC.ingredient.fluid(TFC.fluidStackIngredient('tfc:metal/zinc', 40))
```

In json:

```json
{
    "type": "tfc:fluid_item",
    "ingredient": {
        "tag": "tfc:molds"
    },
    "fluid_ingredient": {
        "ingredient": [   
            {
                "fluid": "minecraft:water"
            },
            {
                "tag": "minecraft:lava"
            }
        ],
        "amount": 50
    }
}
```

```json
{
    "type": "tfc:fluid_item",
    "fluid_ingredient": {
        "ingredient": {
            "fluid": "tfc:metal/zinc"
        },
        "amount": 40
    }
}
```

## Has Trait

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/ingredients/#has-trait)!

### Method Signature

```ts
TFC.ingredient.hasTrait(delegate?: Ingredient, trait: string)
```

- *Optional 1st argument*: An item ingredient to which this ingredient applies to
- 2nd argument: The name of the food trait which must be present

Creates an ingredient of type `tfc:has_trait` with the trait defined by the `trait` argument and the item ingredient defined by the `delegate` ingredient

### Examples

```js
TFC.ingredient.hasTrait('#tfc:fruits', 'tfc:brined')
TFC.ingredient.hasTrait('tfc:in_vinegar')
```

In json:

```json
{
    "type": "tfc:has_trait",
    "ingredient": {
        "tag": "tfc:fruits"
    },
    "trait": "tfc:brined"
}
```

```json
{
    "type": "tfc:has_trait",
    "trait": "tfc:in_vinegar"
}
```

## Heatable

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/ingredients/#heatable)!

### Method Signature

```ts
TFC.ingredient.heatable(delegate?: Ingredient, min: @Nullable number, max: @Nullable number)
```

- *Optional 1st argument*: An item ingredient, limits the items to which this ingredient applies to
- **Nullable** 2nd argument: A number, the minimum temperature of the ingredient, may be null to not specify a minimum temperature
- **Nullable** 3rd argument: A number, the maximum temperature of the ingredient, may be null to not specify a maximum temperature

Creates an ingredient of type `tfc:heatable` with the minimum and maximum temperatures defined by the `min` and `max` arguments, and the ingredient defined by the `delegate` argument

### Examples

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

## Lacks Trait

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/ingredients/#lacks-trait)!

### Method Signature

```ts
TFC.ingredient.lacksTrait(delegate?: Ingredient, trait: string)
```

- *Optional 1st argument*: An item ingredient, limits the items to which this ingredient applies
- 2nd argument: The name of the food trait which must not be present

Creates an ingredient of type `tfc:lacks_trait` with the trait defined by the `trait` argument and the ingredient defined by the `delegate` argument

### Examples

```js
TFC.ingredient.lacksTrait('tfc:food/green_apple', 'tfc:brined')
TFC.ingredient.lacksTrait('tfc:burnt')
```

In json:

```json
{
    "type": "tfc:lacks_trait",
    "ingredient": {
        "item": "tfc:food/green_apple"
    },
    "trait": "tfc:brined"
}
```

```json
{
    "type": "tfc:lacks_trait",
    "trait": "tfc:burnt"
}
```

## Not

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/ingredients/#not)!

### Method Signature

```ts
TFC.ingredient.not(delegate?: Ingredient)
```

- *Optional 1st argument*: An item ingredient to which the ingredient is applied

Creates an ingredient of type `tfc:not` with the ingredient defined by the `delegate` argument

### Examples

```js
TFC.ingredient.not('#minecraft:flowers')
TFC.ingredient.not()
```

In json:

```json
{
    "type": "tfc:not",
    "ingredient": {
        "tag": "minecraft:flowers"
    }
}
```

```json
{
    "type": "tfc:not"
}
```

## Not Rotten

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/ingredients/#not-rotten)!

### Method Signature

```ts
TFC.ingredient.notRotten(delegate?: Ingredient)
```

- *Optional 1st argument*: An item ingredient to which the ingredient is applied to

Creates an ingredient of type `tfc:not_rotten` with the ingredient defined by the `delegate` argument

### Examples

```js
TFC.ingredient.notRotten('minecraft:cooked_porkchop')
TFC.ingredient.notRotten()
```

In json:

```json
{
    "type": "tfc:not_rotten",
    "ingredient": {
        "item": "minecraft:cooked_porkchop"
    }
}
```

```json
{
    "type": "tfc:not_rotten"
}
```
