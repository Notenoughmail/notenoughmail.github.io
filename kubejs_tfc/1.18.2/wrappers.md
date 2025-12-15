---
layout: page
title: Wrappers
permalink: /kubejs_tfc/1.18.2/wrappers/
parent: 1.18.2
grand_parent: KubeJS TFC
---

# Wrappers

KubeJS TFC has three wrappers present to help with writing TFC recipes

- [Block Ingredient](#block-ingredient)
- [Fluid Stack Ingredient](#fluid-stack-ingredient)
- [Item Stack Provider](#item-stack-provider)

## Block Ingredient

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/common-types/#block-ingredients)!

A block ingredient is made up of a list of strings representing a block, or if prepended with #, a block tag.

`BlockIngredient` and `BlockIng` are interchangeable when declaring a block ingredient.

### Method

Block ingredients only have one method available:

#### Of

This accepts a list of strings or regular expressions and creates a block ingredient

```js-18
// returns block ingredient which accepts either an oak log or a dark oak log
BlockIngredient.of(['minecraft:oak_log', 'minecraft:dark_oak_sapling'])
```

**Note:** Due to TFC's current implementation of their block ingredient parser, block ingredients cannot have multiple tags or mix tags and blocks

## Fluid Stack Ingredient

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/common-types/#fluid-stack-ingredients)!

A fluid stack ingredient is a list of strings representing a fluid, or if prepended with a #, a fluid tag and an integer representing the amount of fluid in mB. In most cases, KubeJS's native `Fluid` wrapper will be accepted where ever a fluid stack ingredient is required.

`FluidStackIngredient` and `FluidIngredient` are interchangeable when declaring a fluid stack ingredient.

### Methods

#### Of

This accepts a list of strings or regular expressions and optionally an integer and creates a fluid stack ingredient

```js-18
// returns fluid stack ingredient which represents 1000mB of light blue dye
FluidStackIngredient.of('tfc:light_blue_dye')
// returns fluid stack ingredient which represents 20mB of lime or green dye
FluidIngredient.of(['tfc:lime_dye', 'tfc:green_dye'], 20)
```

#### Water

Creates a fluid stack ingredient representing water, optionally add an integer to specify the amount in mB

```js-18
// returns a fluid stack ingredient representing 1000mB of water
FluidIngredient.water()
// returns a fluid stack ingredient representing 50mB of water
FluidIngredient.water(50)
```

#### Forge Water

Creates a fluid stack ingredient representing the `forge:water` fluid tag, optionally add an integer to specify the amount in mB

```js-18
// returns a fluid stack ingredient representing 1000mB of forge:water
FluidStackIngredient.forgeWater()
// returns a fluid stack ingredient representing 40mB of forge:water
FluidIngredient.forgeWater(40)
```

## Item Stack Provider

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/common-types/#item-stack-providers)!

Item stack providers are used for outputs of recipes, specifically for applying [modifiers](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/) to the output stack. If you don't care about modifiers, there is no need to specifically declare an item stack provider, `'5x minecraft:oak_log'` will work fine.

An item stack provider consists of an item stack and a list of modifiers which can be added onto using the provided methods.

`ItemStackProvider` and `ItemProvider` are interchangeable when declaring an item stack provider

### Methods

#### Of

This accepts an item stack in json or string form, a modifier list in json array form, or an item stack in json or string form and a modifier list in string, json object, or json array form. If given only a json array it will provide a modifier list with no item stack, this is not recommended to do. If providing both an item stack and modifier list, the modifier list must be the second argument

```js-18
// returns an item stack provider for one steak with the tfc:copy_food modifier applied
// These examples are equivalent
ItemStackProvider.of('minecraft:steak', {type:'tfc:copy_food'})
ItemStackProvider.of('minecraft:steak', 'tfc:copy_food')
ItemStackProvider.of('minecraft:steak').copyFood() // See below
ItemStackProvider.of('minecraft:steak').simpleModifier('tfc:copy_food')
ItemStackProvider.of('minecraft:steak').jsonModifier({type:'tfc:copy_food'})
```

If the provided modifier is just a string it will be added to the modifier list as an object representing `{ "type": String }`

#### Convenience Methods

In addition to `of` there are several in-built methods to easily add [modifiers](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#add-heat) without having to write json

##### empty()

Returns an empty item stack provider

##### addHeat(int)

Adds an [add heat](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#add-heat) modifier with the provided integer.

##### addTrait(String)

Adds an [add trait](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#add-trait) modifier with the [trait](https://terrafirmacraft.github.io/Documentation/1.18.x/data/common-types/#food-traits) defined by the provided string

##### removeTrait(String)

Adds a [remove trait](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#remove-trait) modifier with the [trait](https://terrafirmacraft.github.io/Documentation/1.18.x/data/common-types/#food-traits) defined by the provided string

##### copyForgingBonus()

Adds a [copy forging bonus](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#copy-forging-bonus) modifier

##### copyHeat()

Adds a [copy heat](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#copy-heat) modifier

##### copyInput()

Adds a [copy input](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#copy-input) modifier, recommended if using an empty item stack

##### meal(consumer, *optional consumer...*)

Adds a [meal](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#meal) modifier, used for defining the food values of `dynamic` and `dynamic_bowl` food definitions

The first argument is a consumer and is the same as the one used to define a [food item](https://github.com/Notenoughmail/KubeJS-TFC/wiki/Data#food-items), however the available methods are here for convenience

- `.hunger(integer)`{: .language-kube-18 }: Accepts an integer and defines how much hunger the ingredient restores, defaults to 4
    - The player's full hunger bar is equal to 20
- `.saturation(number)`{: .language-kube-18 }: Accepts a number and defines how much saturation the ingredient restores, defaults to 0
- `.water(number)`{: .language-kube-18 }: Accepts a number and defines how much water the ingredient restores, defaults to 0
    - The player's full water bar is equal to 100
- `.decayModifier(number)`{: .language-kube-18 }: Accepts a number and defines how quickly the ingredient decays, defaults to 1
    - A higher value means a faster decay and shorter expiration time
- `.grain(number)`{: .language-kube-18 }: Accepts a number and defines how much of the grain nutrient the ingredient provides, defaults to 0
- `.fruit(number)`{: .language-kube-18 }: Accepts a number and defines how much of the fruit nutrient the ingredient provides, defaults to 0
- `.vegetables(number)`{: .language-kube-18 }: Accepts a number and defines how much of the vegetables nutrient the ingredient provides, defaults to 0
- `.protein(number)`{: .language-kube-18 }: Accepts a number and defines how much of the protein nutrient the ingredient provides, defaults to 0
- `.dairy(number)`{: .language-kube-18 }: Accepts a number and defines how much of the dairy nutrient the ingredient provides, defaults to 0

The second argument is an optional array of portion consumers which have four optional methods available

- `.ingredient(ingredient)`{: .language-kube-18 }: Accepts an ingredient, sets the ingredient to be used for this portion, if not specified this will match all foods
- `.nutrientModifier(number)`{: .language-kube-18 }: Accepts a number and multiplies the nutrition from the food of this portion, defaults to 1.0
- `.waterModifier(number)`{: .language-kube-18 }: Accepts a number and multiples the water from the food of this portion, defaults to 1.0
- `.saturationModifier(number)`{: .language-kube-18 }: Accepts a number and multiples the saturation from the food of this portion, defaults to 1.0

For an example of usage see the advanced shapeless crafting recipe [example](https://github.com/Notenoughmail/KubeJS-TFC/wiki/Recipes#advanced-shapeless-crafting)

##### dyeLeather(String)

Adds a `tfc:dye_leather` modifier with the color defined by the string provided, must match a dye color (red, cyan, etc.)

##### emptyBowl()

Adds an [empty bowl](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#empty-bowl) modifier

##### addBait()

Adds an [add bait](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#add-bait-to-rod) modifier

##### sandwich()

Adds a [sandwich](https://terrafirmacraft.github.io/Documentation/1.18.x/data/item-stack-modifiers/#sandwich) modifier

##### copyOldestFood()

Adds a `tfc:copy_oldest_food` modifier

##### simpleModifier(String)

Adds a modifier with the type defined by the provided string

##### jsonModifier(json element)

Adds a modifier defined by the provided json element

If *FirmaLife* {% include mr.html link='firmalife' %} {% include cf.html link='firmalife' %} is installed the following are also available

##### burrito()

Adds a `firmalife:burrito` modifier

##### pie()

Adds a `firmalife:pie` modifier

##### pizza()

Adds a `firmalife:pizza` modifier

##### copyDynamicFood()

Adds a `firmalife:copy_dynamic_food` modifier

##### emptyPan()

Adds a `firmalife:empty_pan` modifier

If *TFC Casting with Channels*' {% include cf.html link='tfc-casting-with-channels' %} is installed the following are also available

##### conditional(consumer, consumer, *optional consumer*)

Adds a `tfcchannelcasting:conditional` modifier

The first consumer has several methods

- `.type(String)`{: .language-kube-18 }: Sets the type of condition, may either be `has_trait` or `date_range`
- `.trait(String)`{: .language-kube-18 }: Specifies the trait the conditional looks for, only applicable for the `has_trait` type
- `.minDay(integer)`{: .language-kube-18 }: Sets the minimum day of the month the conditional looks for, only applicable for the `date_range` type
- `.maxDay(integer)`{: .language-kube-18 }: Sets the maximum day of the month the conditional looks for, only applicable for the `date_range` type
- `.minMonth(integer)`{: .language-kube-18 }: Sets the minimum month of the year the conditional looks for, only applicable for the `date_range` type
- `.maxMonth(integer)`{: .language-kube-18 }: Sets the maximum month of the year the conditional looks for, only applicable for the `date_range` type

The second consumer will accept any item stack provider modifiers, these will be applied to the item if the conditional passes

The optional third consumer will accept any item stack provider modifiers, these will be applied to the item if the conditional fails

##### setFoodData(consumer)

Adds a `tfcchannelcasting:set_food_data` modifier

Accepts a consumer with methods of the [food item data]({% link kubejs_tfc/1.18.2/data.md %}#food-items) consumer
