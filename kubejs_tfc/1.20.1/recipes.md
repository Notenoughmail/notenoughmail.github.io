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
- [Anvil Welding](#welding)
- [Anivl Working](#working)
- [Barrel Instant Fluid](#barrel-instant-fluid)
- [Barrel Instant](#barrel-instant)
- [Barrel Sealed](#barrel-sealed)
- [Landslide/Collapse](#collapselandslide)

## Alloy

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#alloy)!

### Method Signature

```ts
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

## Welding

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#anvil-welding)!

### Method signature

```ts
event.recipes.tfc.welding(result: ItemstackProviderJS, firstInput: Ingredient, secondInput: Ingredient, tier?: number)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient
- 3rd argument: An item ingredient
- *optional 4th arguemnt*: A number, the minimum tier of anvil the recipe may be completed on, defaults to `-1`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.welding('minecraft:brick', 'tfc:rock/cobble/dacite', 'minecraft:clay')
})
```

## Working

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#anvil-working)!

### Method Signature

```ts
event.recipes.tfc.anvil(result: ItemStackProviderJS, input: Ingredient, rules: ForgeRule[])
    // Additional methods
    .tier(tier: number)
    .bonus(applyBonus: boolean)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient
- 3rd argument: An array of up to 3 `ForgeRule`s, see the main page for a full list

- Tier: Accepts a number and sets the minimum anvil tier the recipe can be performed on, defaults to `-1`
- Bonus: Accepts a boolean and sets if the recipe will apply a forging bonus, defaults to `false`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.anvil('kubejs:my_cool_shears', 'kubejs:unworked_shears', ['hit_not_last', 'upset_any']).bonus(true)
})
```

## Barrel Instant Fluid

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#barrel-instant-fluid)!

### Method Signature

```ts
event.recipes.tfc.barrelInstantFluid(outputFluid: FluidStack, primayFluid: FluidStackIngredient, addedFluid: FluidStackIngredient, sound?: string)
```

- 1st argument: A `FluidStack`, the resutl of the recipe
- 2nd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient), the input fluid in the barrel
- 3rd argument: A [FluidStackIngredinet](../bindings/#fluid-stack-ingredoent), the input fluid added via a fluid container
- *optional 4th argument*: A string, the registry name of a sound event, defaults to `minecraft:block.brewing_stand.brew`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.barrelinstantFluid(Fluid.of('minecraft:water', 50), TFC.fluidStackIngredient('#forge:milk', 30), TFC.fluidStackIngredient('minecraft:lava', 20))
})
```

## Barrel Instant

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#barrel-instant)!

### Method Signature

```ts
event.recipes.tfc.barrelInstant()
    // Additional methods
    .outputItem(outputItem: ItemStackProviderJS)
    .outputFluid(outputFluid: FluidStack)
    .outputs(ouputItem: ItemStackProvider, outputFluid: FluidStack)
    .inputItem(inputItem: Ingredient)
    .inputFluid(inputFluid: FluidStackIngredient)
    .inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)
    .sound(sound: string)
```

- OutputItem: Accepts an [ItemStackProviderJS](../bindings/#item-stack-provider) and sets the recipe's output item, defautls to empty
- OutputFluid: Accepts a `FluidStack` and sets the recipe's output fluid, defaults to empty
- Outputs: A convienence method for setting both outputs, identical to `.outputItem().outputFluid()`
- InputItem: Accepts an item ingredient and sets the recipe's input item, will accept counts greater than 1, defaults to empty
- InputFluid: Accepts a [FluidStackIngredient](../bindings/#fluid-stack-ingredient) and sets the recipe's input fluid, defaults to empty
- Inputs: A convience method for setting both inputs, identical to `.inputItem().inputFluid()`
- Sound: Accepts a string, representing the registry name of a sound event whihc is played when a recipe finishes, defaults to `minecraft:block.brewing_stand.brew`

**Note**: A recipe must have at least one input item or fluid

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.barrelinstant()
        .outputs(TFC.itemStackProvider.of('minecraft:cooked_porkchop').copyFood(), TFC.fluidStackIngredient('kubejs:grease', 50))
        .inputItem('4x minecraft:cooked_beef')
})
```

## Barrel Sealed

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#barrel-sealed)!

### Method Signature

```ts
event.recipes.tfc.barrelSealed(duration: number)
    // Additional methods
    .outputItem(outputItem: ItemStackProviderJS)
    .outputFluid(outputFluid: FluidStack)
    .outputs(outputItem: ItemStackProviderJS, outputFluid: FluidStack)
    .inputItem(inputItem: Ingredient)
    .inputFluid(inputFluid: FluidStackIngredient)
    .inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)
    .sound(sound: string)
    .onSeal(onSeal: ItemStackProviderJS)
    .onUnseal(onUnseal: ItemStackProviderJS)
    .seal(onSeal: ItemStackProviderJS, onUnseal: ItemStackProviderJS)
```

- 1st argument: A number, sets the duration in ticks the barrel must be sealed for, a duration of `-1` will make the recipe **infinite**, one or both of the seal types should be defined

- OutputItem: Accepts an [ItemStackProviderJS](../bindings/#item-stack-provider) and sets the recipe's output item, defaults to empty
- OutputFluid: Accepts a `FluidStack` and sets the recipe's output fluid, defaults to empty
- Outputs: A convience method for setting both outputs, identical to `.outputItem().outputFluid()`
- InputItem: Accepts an item ingredient and sets the recipe's input item, will accept counts greater than 1, defaults to empty
- InputFluid: Accepts a [FluidStackIngredient](../bindings/#fluid-stack-ingredient) amd sets the recipe's input fluid, defautls to empty
- Inputs: A convience method for setting both inputs, identical to `.inputItem().inputFluid()`
- Sound: Accepts a string, representing the registry name of a sound event whihc is played when a recipe finishes, defaults to `minecraft:block.brewing_stand.brew`
- OnSeal: Accepts an [ItemStackProviderJS](../bindings/#item-stack-provider) which will be applied when the barrel is sealed
- OnUnsel: Accepts an [ItemStackProviderJS](../bindings/#item-stack-provider) which will be applied whe nthe barrel is unsealed
- Seal: A convience method for setting both seals, identica lto `.onSeal().onUnseal()`

### Example

```js
SeverEvents.recipes(event => {
    event.recipes.tfc.barrelSealed(5000)
        .outputItem('8x minecraft:mud')
        .inputs('8x #tfc:dirt', TFC.fluidStackIngredient('#minecraft:water', 1000))
})
```

## Landslide/Collapse

See the [collapse](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#collapse) and [landslide](https://terrafirmacraft.github.io/Documentation/1.20.x/data/recipes/#landslide) main pages! **Note**: The syntax is exactly the same for both of these recipes, thus they shown together

### Method Signature

```ts
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