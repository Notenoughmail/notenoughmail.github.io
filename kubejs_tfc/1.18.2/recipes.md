---
layout: page
title: Recipes
permalink: /kubejs_tfc/1.18.2/recipes/
parent: 1.18.2
grand_parent: KubeJS TFC
---

# Recipes

The following recipes are supported by KubeJS TFC

- [Alloy](#alloy)
- [Anvil Welding](#anvil-welding)
- [Anvil Working](#anvil-working)
- [Barrel Instant Fluid](#barrel-instant-fluid)
- [Barrel Instant](#barrel-instant)
- [Barrel Sealed](#barrel-sealed)
- [Blast Furnace](#blast-furnace)
- [Bloomery](#bloomery)
- [Casting](#casting)
- [Chiseling](#chiseling)
- [Collapse/Landslide](#collapselandslide)
- [Heating](#heating)
- [Knapping (clay/fire clay/leather)](#knapping)
- [Loom](#loom)
- [Simple Pot](#simple-pot)
- [Quern](#quern)
- [Rock Knapping](#rock-knapping)
- [Scraping](#scraping)
- [Advanced Shaped Crafting](#advanced-shaped-crafting)
- [Advanced Shapeless Crafting](#advanced-shapeless-crafting)
- [Damage Inputs Shaped Crafting](#damage-inputs-shaped-crafting)
- [Damage Inputs Shapeless Crafting](#damage-inputs-shapeless-crafting)
- [Extra Products Shaped Crafting](#extra-products-shaped-crafting)
- [Extra Products Shapeless Crafting](#extra-products-shapeless-crafting)

If you have [FirmaLife](https://www.curseforge.com/minecraft/mc-mods/firmalife) installed, the following recipes are also supported

- [Drying](#drying)
- [Smoking](#smoking)
- [Mixing Bowl](#mixing-bowl)
- [Pumpkin Knapping](#pumpkin-knapping)
- [Oven](#oven)
- [Vat](#vat)

Take a look through its [docs](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation/#recipes)

if you have [TFC Rosia](https://legacy.curseforge.com/minecraft/mc-mods/tfc-rosia) installed, the following recipes are also supported

- [Auto Quern](#auto-quern)
- [Extruding Machine](#extruding-machine)
- [Rolling Machine](#rolling-machine)

if you have [ArborFirmaCraft](https://www.curseforge.com/minecraft/mc-mods/arborfirmacraft) installed, the following recipes are also supported

- [Tree Tapping](#tree-tapping)

KubeJS TFC also adds three type [wrappers]({% link kubejs_tfc/1.18.2/wrappers.md %}) for easier building of recipes, they will be linked in each recipe just like TFC's [Official Docs](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#heating) do. In addition the appropriate recipe page will be linked from each recipe.

{: .notice #general-notice }
>
> - Have a look over TFC's [tags](https://terrafirmacraft.github.io/Documentation/1.18.x/data/tags/), in many places they are used to determine if an ingredient is allowed to perform the recipe or even go in the recipe's container. If you find you've made a recipe and it isn't working, check the linked list for any related tags.
> - In several places TFC will take ingredients of tool items. Normally when writing json recipes, this would be no problem, however due to the way KubeJS processes ingredient items, items with durability automatically have nbt attached to them specifying that their damage be 0. This can be stopped by using `Item.of()` and the `.ignoreNBT()` method. However this does not apply to tags, so this would not be needed for an ingredient of `#tfc:saws`

---

## Alloy

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#alloy)!

- 1st argument: A string representing the registry name of a metal
- 2nd argument: A list of contents, each containing three variables:
    - A string representing the registry name of the required metal
    - A number, in the range [0, 1], representing the minimum portion needed in the mixture
    - A number, in the range [0, 1], representing the maximum portion needed in the mixture

### Example

```js
// copper, rose gold, and black steel mix to become steel
event.recipes.tfc.alloy('tfc:steel', [
    ['tfc:copper', 0.2, 0.3],
    ['tfc:rose_gold', 0.4, 0.8],
    ['tfc:black_steel', 0.2, 0.5]
])
```

In order to use a custom metal as an output, a metal needs to be defined, see [the relevant page](https://github.com/Notenoughmail/KubeJS-TFC/wiki/Data#metals) for how to do so.

## Anvil Welding

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#anvil-welding)

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider)) representing the result of the recipe
- 2nd argument: A list of two item ingredients

### Extra Methods

- `.tier(int)`{: .language-kube }: Makes it so the recipe can only be performed on an anvil equal to or greater than the tier provided, defaults to -1
- `.combineForgingBonus()`{: .language-kube }: Sets the `combine_forging_bonus` property to `true`

### Example

```js

// weld together black bronze and bismuth bronze ingots to get two bronze ingots
event.recipes.tfc.welding('2x tfc:metal/ingot/bronze', ['tfc:metal/ingot/black_bronze', 'tfc:metal/ingot/bismuth_bronze']).tier(2)
```

## Anvil Working

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#anvil-working)!

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) representing the result of the recipe
- 2nd argument: An item ingredient
- 3rd argument: An array of up to three forge rules, see the main page for a full list

### Extra Methods

- `.tier(int)`{: .language-kube }: Makes it so the recipe can only be performed on an anvil equal to or greater than the tier provided, defaults to -1
- `.applyBonus()`{: .language-kube }: Sets the `apply_forging_bonus` property to `true`

### Example

```js
// work a bismuth bronze rod into a bronze ingot with an added modifier of 4000 heat and applying a bonus
event.recipes.tfc.anvil(ItemStackProvider.of('tfc:metal/ingot/bronze', {type:'tfc:add_heat', temperature:4000}), 'tfc:metal/rod/bismuth_bronze', ['draw_not_last', 'shrink_any']).applyBonus()
```

## Barrel Instant Fluid

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#barrel-instant-fluid)!

- 1st argument: The result fluid
- 2nd argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient)
- 3rd argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient)

### Extra Method

- `.sound(String)`{: .language-kube }: A string, representing the registry name of a sound event, which is played when the recipe finishes, defaults to `minecraft:block.brewing_stand.brew`

### Example

```js
// combine 50mB of water and 5mB of zinc to make 50mB of milk
event.recipes.tfc.barrel_instant_fluid(Fluid.of('minecraft:milk', 50), FluidStackIngredient.water(50), Fluid.of('tfc:metal/zinc', 5))
```

## Barrel Instant

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#barrel-instant)!

- 1st argument: A result list containing either a fluid, an [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), or both
- 2nd argument: An ingredient item
- 3rd argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient)

### Extra Method

- `.sound(String)`{: .language-kube }: A string, representing the registry name of a sound event, which is played when the recipe finishes, defaults to `minecraft:block.brewing_stand.brew`

### Examples

```js
// get 5 oak logs for every 2 diamond blocks and 200mB of anything in the tfc:sterling_silver fluid tag
event.recipes.tfc.barrel_instant('5x minecraft:oak_log', '2x minecraft:diamond_block', FluidStackIngredient.of('#tfc:sterling_silver', 200))
// get 3 diamond blocks and 20mB of corn whiskey for every 3 dark oak logs and 1000mB of water
event.recipes.tfc.barrel_instant(['3x minecraft:diamond_block', Fluid.of('tfc:corn_whiskey', 20)], '3x minecraft:dark_oak_log', Fluid.water())
```

## Barrel Sealed

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#barrel-sealed)!

- 1st argument: A result list containing either a fluid, an [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), or both
- 2nd argument: An ingredient list containing a [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient), an item ingredient, or both
- 3rd argument: An integer, representing the number of ticks that the barrel must be sealed for. A duration of -1 will be considered infinite, doing so should be accompanied either an onSeal or onUnseal, or both method(s)

### Extra Methods

- `.sound(String)`{: .language-kube }: A string, representing the registry name of a sound event, which is played when the recipe finishes, defaults to `minecraft:block.brewing_stand.brew`
- `.onSeal(item stack provider)`{: .language-kube }: An object representing an [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), sets the `on_seal` property to an equal item stack provider
- `.onUnseal(item stack provider)`{: .language-kube }: An object representing an [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), sets the `on_unseal` property to an equal item stack provider

### Example

```js
// get 20mB of milk and 3 oak logs when 3 oak logs and 200mB of water are sealed together for 200 ticks
event.recipes.tfc.barrel_sealed([Fluid.of('minecraft:milk', 20), '3x minecraft:oak_log'], [Fluid.of('minecraft:water', 200), '3x minecraft:oak_log'], 200)
```

### Further Necessities

When sealed, a translatable component describing the recipe will appear in the UI. The structure of the lang key is `'tfc.recipe.barrel.' + <recipe_id namespace> + '.' + <recipe_id path>` with all backslashes (/) replaced with periods. Alternatively, just try the recipe in-game and translate the lang key seen.

## Blast Furnace

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#blast-furnace)!

- 1st argument: A result fluid
- 2nd argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient)
- 3rd argument: The catalyst, an item ingredient

### Example

```js
// 1mB of zinc for 1mB of bismuth bronze catalyzed by a bucket
event.recipes.tfc.blast_furnace(Fluid.of('tfc:metal/bismuth_bronze', 1), Fluid.of('tfc:metal/zinc', 1), 'minecraft:bucket')
```

## Bloomery

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#bloomery)!

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) representing the result
- 2nd argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient) representing the input fluid
- 3rd argument: The catalyst, an item ingredient
- 4th argument: An integer, representing the duration in ticks until the bloomery is complete

### Example

```js
// 2mB of bismuth bronze becomes an oak log when catalyzed by a bucket for 20 ticks
event.recipes.tfc.bloomery('minecraft:oak_log', Fluid.of('tfc:metal/bismuth_bronze', 2), 'minecraft:bucket', 20)
```

## Casting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#casting)!

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient, this only matches the mold item itself
- 3rd argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient)
- *optional 4th argument*: A number, in the range [0, 1], representing the chance that the mold will break upon completion of this recipe

### Example

```js
// 100mB of sterling silver in a saw head mold produces an oak log; the mold has a 50% chance of breaking
event.recipes.tfc.casting('minecraft:oak_log', 'tfc:ceramic/saw_head_mold', FluidStackIngredient.of('#tfc:sterling_silver', 100), 0.5)
```

## Chiseling

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#chiseling)!

- 1st argument: A string representing the block state result
- 2nd argument: A [block ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#block-ingredient)
- *optional 3rd argument*: A string representing the chiseling mode, 'smooth', 'slab', or 'stair' are accepted, defaults to 'smooth'

### Extra Methods

- `.extraDrop(item stack provider)`{: .language-kube }: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) specifying an item to be dropped upon chiseling
- `.itemIngredients(ingredients...)`{: .language-kube }: A list of ingredients specifying the chisel, ingredients must be in the `tfc:chisels` tag

### Example

```js
// get five brass rods and a diamond block when chiseling a sapling in slab mode using either a copper or blue steel chisel
event.recipes.tfc.chisel('minecraft:diamond_block', '#minecraft:saplings', 'slab').extraDrop('5x tfc:metal/rod/brass').itemIngredients('tfc:metal/chisel/copper', 'tfc:metal/chisel/blue_steel')
```

## Collapse/Landslide

See the [collapse](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#collapse) and [landslide](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#landslide) main pages! **Note:** The syntax is exactly the same for collapse and landsliding recipes, thus they are shown together

- 1st argument: One of two options:
    - A boolean representing the `copy_input` property, defaults to false. *Only use this with the value **true***
    - A string representing the block state result
- 2nd argument: A [block ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#block-ingredient)

### Examples

```js
// a gold block collapse into a diamond block
event.recipes.tfc.collapse('minecraft:diamond_block', 'minecraft:gold_block')
// a log collapse into itself, preserving its block state
event.recipes.tfc.collapse(true, '#minecraft:logs')
// an oak log landslides into a dark oak log with a block state matching axis=y
event.recipes.tfc.landslide('minecraft:dark_oak_log[axis=y]', 'minecraft:oak_log')
```

## Heating

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#heating)!

- *optional 1st argument*: A list of either, a fluid result, an [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), both, or neither
- 2nd[^1] argument: An ingredient item. **Note: an [item heat]({% link kubejs_tfc/1.18.2/data.md %}#heats) must be defined in order for the provided ingredient to be usable in recipes**
- 3rd[^2] argument: A number, representing the temperature above which this item will convert to its outputs

[^1]: If the argument list is only two long (for instance when there is no result) this is the first argument

[^2]: If the argument list is only two long (for instance when there is no result) this is the second argument

### Extra Method

- `.useDurability()`{: .language-kube }: sets the `use_durability` property to true

### Examples

```js
// get 50mB of water when a clay block is raised to 50℃
event.recipes.tfc.heating(Fluid.of('minecraft:water', 50), 'minecraft:clay', 50)
//get nothing when fire clay is raised to 50℃
event.recipes.tfc.heating('tfc:fire_clay', 50)
```

## Knapping

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#knapping)! **Note:** The syntax is exactly the same for clay, fire clay, and leather knapping recipes, thus they are shown together

- 1st argument: An item stack, the result
- 2nd argument: A pattern

### Extra Method

- `.outsideSlotNotRequired()`{: .language-kube }: Sets the `outside_slot_required` property to false

### Examples

```js
// get a large prepared hide for removing a single square
event.recipes.tfc.clay_knapping('tfc:large_prepared_hide', ['XXX', 'X X', 'XXX'])
// get a large prepared hide for having an 'I' shaped are of fire clay, ignoring the area around it
event.recipes.tfc.fire_clay_knapping('tfc:large_prepared_hide', ['XXX', ' X ', 'XXX']).outsideSlotNotRequired()
// knap leather into an x shaped to get a large prepared hide
event.recipes.tfc.leather_knapping('tfc:large_prepared_hide', ['X   X', ' X X ', '  X  ', ' X X ', 'X   X'])
```

## Loom

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#loom)!

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider), representing the result item
- 2nd argument: An item stack ingredient
- *optional 3rd argument*: An integer which determines how many steps of the loom's working animation need to be completed to produce the result, defaults to the stack size of the item stack ingredient

### Extra Method

- `.inProgressTexture(String)`{: .language-kube }: The texture used in the loom when rendering this recipe, defaults to `minecraft:block/white_wool`

### Example

```js
// get one oak log from one oak plank after working the loom fifty times
event.recipes.tfc.loom('minecraft:oak_log', 'minecraft:oak_planks', 50)
```

## Simple Pot

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes-pot/#simple-pot)!

- 1st argument: A list of results containing:
    - Up to one fluid stack
    - Up to five item stacks
- 2nd argument: A list of ingredients containing:
    - A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient)
    - Up to five item ingredients
- 3rd argument: An integer, representing the number of ticks the pot must boil for
- 4th argument: A number, representing the temperature the pot must reach to begin boiling

### Example

```js
// boil 60mB of water and a cornflower at 50℃ for 20 ticks and get 50mB of light blue dye
event.recipes.tfc.pot(Fluid.of('tfc:light_blue_dye', 50), [Fluid.of('minecraft:water', 60), 'minecraft:cornflower'], 20, 50)
```

## Quern

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#quern)!

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) representing the output of the recipe
- 2nd argument: An item ingredient

### Example

```js
// grind one bone meal into 3 bones
event.recipes.tfc.quern('3x minecraft:bone', 'minecraft:bone_meal')
```

## Rock Knapping

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#rock-knapping)!

- 1st argument: An item stack, the result
- 2nd argument: A pattern
- 3rd argument: An item ingredient

### Extra Method

- `.outsideSlotNotRequired()`{: .language-kube }: Sets the `outside_slot_required` property to false

### Example

```js
// knap sedimentary rocks into large prepared hide
event.recipes.tfc.rock_knapping('tfc:large_prepared_hide', ['XX', 'XX', 'XX'], '#tfc:sedimentary_rock')
```

## Scraping

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/recipes/#scraping)!

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) representing the output of the recipe
- 2nd argument: An item ingredient

### Extra Methods

- `.inputTexture(String)`{: .language-kube }: Sets the `input_texture` property, defaults to 'tfc:item/hide/large/soaked'
- `.outputTexture(String)`{: .language-kube }: Sets the `output_texture` property, defaults to 'tfc:item/hide/large/scraped'

### Example

```js
// scrape a rose gold double sheet into 5 oak logs
event.recipes.tfc.scraping('5x minecraft:oak_log', 'tfc:metal/double_sheet/rose_gold')
```

## Advanced Shaped Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/crafting/#advanced-shaped-crafting)!

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider)
- 2nd argument: A pattern, the same as KubeJS's native crafting recipe
- 3rd argument: A pattern key, the same as KubeJS's native crafting recipe
- 4th argument: An integer, representing the row (0 indexed) of the pattern. Used to determine the input item of the item stack provider
- 5th argument: An integer, representing the column (0 indexed) of the pattern. Used to determine the input item of the item stack provider

### Extra Methods

Advanced Shaped Crafting inherits any extra methods which vanilla/KubeJS shaped crafting has, including `.noMirror()` and `.noShrink()`

### Example

```js
// Craft a hammer and a copper ingot together to get two copper rods with the same heat as the copper ingot
event.recipes.tfc.advanced_shaped_crafting(ItemProvider.of('2x tfc:metal/rod/copper').copyHeat(), [
  'A', 
  'B'
], {
  A: '#tfc:hammers',
  B: 'tfc:metal/ingot/copper'
}, 1, 0)
```

## Advanced Shapeless Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/crafting/#advanced-shapeless-crafting)!

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider)
- 2nd argument: A list of item ingredients, the first ingredient will be treated as the input item for the item stack provider

### Example

```js
// Craft a knife, two fruits, and three breads together to get a vanilla porkchop
// For the purposes of this example assume the porkchop has a food definition with type 'dynamic'
// And that the recipe is also wrapped in a damage inputs shapeless recipe so the knife is damaged
event.recipes.tfc.advanced_shapeless_crafting(ItemProvider.of('minecraft:porkchop').meal(food => {
    // Sets the base food for the object
    food.protein(2)
    food.hunger(3)
}, portion => {
    // Sets the additional nutrient/water/saturation for the fruits
    portion.ingredient('#tfc:foods/fruits')
    portion.waterModifier(0)
    portion.nutrientModifier(0.8)
}, portion => {
    // Sets the additional nutrient/water/saturation for the rest of the items
    portion.nutrientModifier(0.6)
    portion.saturationModifier(1.1)
}), [
    '2x #tfc:foods/fruits',
    '3x tfc:foods/breads'
    '#tfc:knives'
])
```

## Damage Inputs Shaped Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/crafting/#damage-inputs)!

This recipe has two possible syntaxes.

The first:

- 1st argument: A KubeJS shaped crafting recipe, including [advanced shaped crafting](#advanced-shaped-crafting), [extra products shaped crafting](#extra-products-shaped-crafting), and KubeJS's default shaped crafting

The second matches the syntax of KubeJS's default shaped crafting recipes, see their [wiki](https://wiki.latvian.dev/books/kubejs-legacy/page/recipeeventjs) for specifics

### Extra Methods

Damage inputs shaped crafting inherits any extra methods which vanilla/KubeJS shaped crafting has, including `.noMirror()` and `.noShrink()`

### Examples

```js
// The crafting recipe of a chest but a saw in the center

// First syntax style
event.recipes.tfc.damage_inputs_shaped_crafting(event.shaped('minecraft:chest', [
  'AAA',
  'ABA',
  'AAA'
], {
  A: '#minecraft:planks',
  B: '#tfc:saws'
}))

// Second syntax style
event.recipes.tfc.damage_inputs_shaped_crafting('minecraft:chest', [
  'AAA',
  'ABA',
  'AAA'
], {
  A: '#minecraft:planks',
  B: '#tfc:saws'
})
```

## Damage Inputs Shapeless Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/crafting/#damage-inputs)!

This recipe has two possible syntaxes

The first:

- 1st argument: A KubeJS Shapeless crafting recipe, including [advanced shapeless crafting](#advanced-shapeless-crafting), [extra products shapeless crafting](#extra-products-shapeless-crafting), and KubeJS's default shapeless crafting

The second matches the syntax of KubeJS's default shapeless crafting recipes, see their [wiki](https://wiki.latvian.dev/books/kubejs-legacy/page/recipeeventjs) for specifics

### Examples

```js
// Craft a hammer and a bone to get 5 bone meal

// First syntax style
event.recipes.tfc.damage_inputs_shapeless_crafting(event.shapeless('5x minecraft:bone_meal', [
  'minecraft:bone',
  '#tfc:hammers'
]))

// Second syntax style
event.recipes.tfc.damage_inputs_shapeless_crafting('5x minecraft:bone_meal', [
  'minecraft:bone',
  '#tfc:hammers'
])
```

## Extra Products Shaped Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/crafting/#extra-products)!

- 1st argument: A list of item stacks representing the extra products of the recipe
- 2nd argument: A KubeJS shaped crafting recipe, including [advanced shaped crafting](#advanced-shaped-crafting), [damage inputs shaped crafting](#damage-inputs-shaped-crafting), and KubeJS's default shaped crafting

### Example

```js
// Get an oak log as an extra product of crafting two bones together to get a piece of coal
event.recipes.tfc.extra_products_shaped_crafting('minecraft:oak_log', event.shaped('minecraft:coal', [
  'A',
  'A'
], {
  A: 'minecraft:bone'
}))
```

## Extra Products Shapeless Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/crafting/#extra-products)!

- 1st argument: A list of item stacks representing the extra products of the recipe
- 2nd argument: A KubeJS shapeless crafting recipe, including [advanced shapeless crafting](#advanced-shapeless-crafting), [damage inputs shapeless crafting](#damage-inputs-shapeless-crafting), and KubeJS's default shapeless crafting

### Example

```js
// Get an oak log as an extra product of crafting three sticks together to get a diamond block
event.recipes.tfc.extra_products_shapeless_crafting('minecraft:oak_log', event.shapeless('minecraft:diamond_block', [
  '3x minecraft:stick'
]))
```

## Drying

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) representing the output of the recipe
- 2nd argument: An item ingredient

### Example

```js
// Dry a log into sticks
event.recipes.firmalife.drying('4x minecraft:stick', '#minecraft:logs')
```

## Smoking

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) representing the output of the recipe
- 2nd argument: An item ingredient

### Example

```js
// Smoke raw beef into cooked beef
event.recipes.firmalife.smoking('minecraft:cooked_beef', 'minecraft:raw_beef')
```

## Mixing Bowl

- 1st argument: A list of results containing:
    - Up to one fluid stack
    - Up to five item stacks
- 2nd argument: A list of ingredients containing:
    - Up to one [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient)
    - Up to five item ingredients

### Example

```js
// Mix 1000mB of water and 3 bone meal to get 1 glue and 50mB of limewater
event.recipes.firmalife.mixing_bowl(['tfc:glue', Fluid.of('tfc:limewater', 50)], ['3x minecraft:bone_meal', Fluid.water()])
```

## Pumpkin Knapping

- 1st argument: An item stack, the result
- 2nd argument: A pattern

### Extra Method

- `.outsideSlotNotRequired()`{: .language-kube }: Sets the `outside_slot_required` property to false

### Examples

```js
// get a pumpkin seed by removing a two by one area
event.recipes.firmalife.pumpkin_knapping('minecraft:pumpkin_seed', ['X X', 'X X'])
```

## Oven

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider)
- 2nd argument: An ingredient
- 3rd argument: An integer, representing the duration of the recipe in ticks
- 4th argument: A number, representing the temperature the recipes requires to complete

### Example

```js
// Bake hardened andesite for 2000 ticks at 15℃ into andesite cobble 
event.recipes.firmalife.oven('tfc:rock/cobble/andesite', 'tfc:rock/hardened/andesite', 2000, 15);
```

## Vat

- 1st argument: A list of results containing:
    - Up to one fluid stack
    - Up to one [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider)
- 2nd argument: A list of ingredients containing:
    - Up to one [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient)
    - Up to one item stack ingredient
- *optional 3rd argument*: An integer, representing how long the recipe takes to process. Defaults to 600 ticks
- *optional 4th argument*: A number, representing the temperature requires for the recipe to process. Defaults to 300℃

### Extra Methods

- `.jar(object)`{: .language-kube }: An item stack. Only used for operations that produce `firmalife:fruity_fluid` in conjunction with the jarring station.

### Example

```js
// Boil an oak log for 8000 ticks and get 30mB of water
event.recipes.firmalife.vat(Fluid.water(30), 'minecraft:oak_log', 8000)
```

## Auto Quern

- 1st argument: An item stack, the result of the recipe
- 2nd argument: An item ingredient

### Example

```js
// Grind one bone meal into 3 bones
event.recipes.rosia.auto_quern('3x minecraft:bone', 'minecraft:bone_meal')
```

## Extruding Machine

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) representing the result of the recipe
- 2nd argument: An item ingredient

### Example

```js
// Extrude a bismuth ingot into a dirt block
event.recipes.rosia.extruding_machine('minecraft:dirt', 'tfc:metal/ingot/bismuth')
```

## Rolling Machine

- 1st argument: An [item stack provider]({% link kubejs_tfc/1.18.2/wrappers.md %}#item-stack-provider) representing the result of the recipe
- 2nd argument: An item ingredient

### Example

```js
// Roll a dirt block into 5 oak logs
event.recipes.rosia.rolling_machine('5x minecraft:oak_log', 'minecraft:dirt')
```

## Tree Tapping

- 1st argument: A fluid stack, the result of the recipe
- 2nd argument: A [block ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#block-ingredient), the block the tree tap needs to be attached to
- *optional 3rd argument*: A boolean, determines if the recipe will only work if the block has the `natural=true` blockstate, defaults to true

*Note*: The block(s) that are tapped need the `afc:tappable_logs` block tag

### Extra Methods

- `.minTemp(number)`{: .language-kube }: Sets the minimum ambient temperature the recipe can be completed at, defaults to -50°C
- `.maxTemp(number)`{: .language-kube }: Sets the maximum ambient temperature the recipe can be completed at, defaults to 50°C
- `.requiresNatural(boolean)`{: .language-kube }: See 3rd argument above
- `.onlyInSpring(boolean)`{: .language-kube }: Determines if the recipe can only be completed during spring, defaults to false
- `.onlyInSpring()`{: .language-kube }: equivalent to `.onlyInSpring(true)`

### Example

```js
event.recipes.afc.tree_tapping(Fluid.of('minecraft:milk', 5), 'minecraft;stone', false).minTemp(3).maxTemp(18)
```
