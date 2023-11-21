---
layout: page
title: Recipes
permalink: /kubejs_tfc/1.20.1/recipes/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Recipes

{: .notice }
Work In Progress!

The following recipes (currently) are supported by KubeJS TFC:
- [Alloy](#alloy)
- [Landslide/Collapse](#collapse-landslide)

## Alloy

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#alloy)!

### Method Signature

```js
event.recipes.tfc.alloy(result: string, contents: AlloyPart[])
```

- 1st argument: A string representing the name of a metal
- 2nd argument: An array of [AlloyPart](../bindings/#alloy-part)s defining the components and their percentage ranges for the recipe

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.alloy('tfc:metal', [
        TFC.alloyPart('tfc:copper', 0.2, 0.3),
        TFC.alloyPart('tfc:rose_gold', 0.4, 0.8),
        TFC.alloyPart('tfc:black_steel', 0.2, 0.5)
    ])
})
```

## Landslide/Collapse

See the [collapse](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#collapse) and [landslide](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#landslide) main pages! **Note**: The syntax is exactly the same for both of these recipes, thus they shown together

### Method Signature

```js
event.recipes.tfc.collaspe(result?: BlockState, ingredient: BlockIngredient)
event.recipes.tfc.landslide(result?: BlockState, ingredient: BlockIngredient)
```

- *optional 1st argument*: A `BlockState`, the result of the recipe, if not provided, the `copy_input` property of the recipe will be implicitly set to `true`
- 2nd argument: A [BlockIngredient](../bindings/#block-ingredient), the ingredient of the recipe

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.collapse('minecraft:grass[snowy=true]', TFC.blockIngredient(['minecraft:dirt', '#forge:unstable_dirts']))
    event.recipes.tfc.landslide(TFC.blockIngredient('#kubejs:landslides_to_self'))
})
```