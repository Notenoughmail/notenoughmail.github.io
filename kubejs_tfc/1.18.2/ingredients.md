---
layout: page
title: Ingredients
permalink: /kubejs_tfc/1.18.2/ingredients/
parent: 1.18.2
grand_parent: KubeJS TFC
---

# Ingredients

KubeJS TFC adds the ability to write TFC's [ingredient types](https://terrafirmacraft.github.io/Documentation/1.18.x/data/ingredients/) in your scripts

- [Not Rotten](#not-rotten)
- [Has Trait](#has-trait)
- [Lacks Trait](#lacks-trait)
- [Heatable](#heatable)
- [Not](#not)
- [Fluid Item](#fluid-item)
- [Shortcuts](#shortcuts)

**Note**: These ingredient types have an optional internal ingredient which is used to specify their item ingredient, the count of this internal ingredient will be ignored when parsing, so if you want to have multiple of these ingredients without repeating yourself, use `.withCount(int)` after specifying the ingredient. See not rotten's [example](<#examples>)

## Not Rotten

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/ingredients/#not-rotten)!

This specifies an ingredient which only accepts food items if they are not rotten

- *optional 1st argument*: An ingredient, if omitted, this will accept all non-rotten items

### Examples

```js
Ingredient.notRotten() // 1 non-rotten item
Ingredient.notRotten('5x #tfc:foods/fruits') // 1 non-rotten fruit
Ingredient.notRotten('#tfc:foods/fruits').withCount(3) // 3 non-rotten fruits
```

## Has Trait

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/ingredients/#has-trait)!

This specifies an ingredient which only accepts food items if they have a specific [trait](https://terrafirmacraft.github.io/Documentation/1.18.x/data/common-types/#food-traits)

- 1st argument: Accepts a string representing the registry name of a food trait which must be present
- *optional 2nd argument*: An ingredient, if omitted, this will accept all items with the provided trait

### Examples

```js
Ingredient.hasTrait('tfc:salted') // An item with the 'tfc:salted' trait
Ingredient.hasTrait('tfc:pickled', 'minecraft:cooked_beef') // A steak with the 'tfc:pickled' trait
```

## Lacks Trait

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/ingredients/#lacks-trait)!

This specifies an ingredient which only accepts food items if they do not have a specific [trait](https://terrafirmacraft.github.io/Documentation/1.18.x/data/common-types/#food-traits)

- 1st argument: Accepts a string representing the registry name of a food trait which must no be present
- *optional 2nd argument*: An ingredient, if omitted, this will accept all items without the provided trait

### Examples

```js
Ingredient.lacksTrait('tfc:preserved') // An item without the 'tfc:preserved' trait
Ingredient.lacksTrait('tfc:wood_grilled', '#tfc:foods/cooked_meats') // A cooked meat without the 'tfc:wood_grilled' trait
```

## Heatable

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/ingredients/#heatable)!

This specifies an ingredient which only accepts items if they are heatable and optionally within a temperature range

- *optional 1st argument*: An ingredient, if omitted, this will accept all items with the provided heat
- *optional 2nd and 3rd argument*: Integers which represent the minimum and maximum temperature of the ingredient

### Extra Methods

- `.minTemp(integer)`{: .language-javascript }: Sets the minimum temperature of the ingredient
- `.maxTemp(integer)`{: .language-javascript }: Sets the maximum temperature of the ingredient
- `.temps(integer, integer)`{: .language-javascript }: Sets the minimum and maximum temperatures of the ingredient

### Examples

```js
Ingredient.heatable() // Accepts any item that are heatable
Ingredient.heatable('tfc:metal/ingot/wrought_iron') // Accepts wrought iron ingots
Ingredient.heatable('tfc:metal/rod/brass', 200, 900) // Accepts brass rods between 200 and 900 degrees Celsius
Ingredient.heatable('tfc:metal/double_sheet/zinc').minTemp(400) // Accepts zinc double sheets above 400 degrees Celsius
```

## Not

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/ingredients/#not)!

This specifies an ingredient which inverts an existing ingredient

- *optional 1st argument*: An ingredient which this ingredient applies to

**Note**: KubeJS also has its own `not` ingredient type, but this is still provided for completeness

### Example

```js
Ingredient.tfcNot(Ingredient.notRotten()) // Accepts any rotten food
```

## Fluid Item

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/data/ingredients/#fluid-item)!

This specifies an item which is expected to contain a fluid

- 1st argument: A [fluid stack ingredient]({% link kubejs_tfc/1.18.2/wrappers.md %}#fluid-stack-ingredient), which specified the fluid(s) required
- *optional 2nd argument*: An ingredient, if omitted this will accept any item

### Extra Method

- `.withFluidAmount(integer)`{: .language-javascript }: Sets the amount of the fluid required, defaults to the amount defined by the fluid stack ingredient itself

### Examples

```js
Ingredient.fluidItem(Fluid.water()) // Any item containing 1000mB of water
Ingredient.fluidItem(FluidIngredient.of('#tfc:alcohols', 50), 'tfc:ceramic/jug') // A jug containing 50mB of an alcohol
```

## Shortcuts

These ingredient types can also be swapped between and from regular ingredients

### Examples

```js
Ingredient.of('tfc:metal/ingot/wrought_iron').asHeatable() // The same as ↙
Ingredient.heatable('tfc:metal/ingot/wrought_iron')

Ingredient.of('tfc:metal/ingot/wrought_iron').asHeatable(200, 900) // The same as ↙
Ingredient.heatable('tfc:metal/ingot/wrought_iron', 200, 900)

Ingredient.notRotten().asTFCNot() // The same as ↙
Ingredient.tfcNot(Ingredient.notRotten())

Ingredient.of('#tfc:foods/cooked_meats').asNotRotten() // The same as ↙
Ingredient.notRotten('#tfc:foods/cooked_meats')

Ingredient.hasTrait('tfc:pickled').asLacksTrait('tfc:brined') // The same as ↙
Ingredient.lacksTrait('tfc:brined', Ingredient.hasTrait('tfc:pickled'))

Ingredient.notRotten().asHasTrait('tfc:wood_grilled') // The same as ↙
Ingredient.hasTrait('tfc:wood_grilled', Ingredient.notRotten())

Ingredient.of('tfc:ceramic/jug').asFluidItem(Fluid.of('tfc:salt_water', 75)) // The same as ↙
Ingredient.fluidItem(Fluid.of('tfc:salt_water', 75), 'tfc:ceramic/jug')
```
