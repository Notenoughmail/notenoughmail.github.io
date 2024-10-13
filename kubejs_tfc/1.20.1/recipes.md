---
layout: page
title: Recipes
permalink: /kubejs_tfc/1.20.1/recipes/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Recipes

The following recipes are supported by KubeJS TFC:

- [Alloy](#alloy)
- [Anvil Welding](#welding)
- [Anvil Working](#working)
- [Barrel Instant Fluid](#barrel-instant-fluid)
- [Barrel Instant](#barrel-instant)
- [Barrel Sealed](#barrel-sealed)
- [Blast Furnace](#blast-furnace)
- [Bloomery](#bloomery)
- [Casting](#casting)
- [Chisel](#chisel)
- [Collapse/Landslide](#collapselandslide)
- [Glassworking](#glassworking)
- [Heating](#heating)
- [Knapping](#knapping)
- [Loom](#loom)
- [Jam Pot](#jam-pot)
- [Simple Pot](#simple-pot)
- [Soup Pot](#simple-pot)
- [Quern](#quern)
- [Scraping](#scraping)
- [Sewing](#sewing)
- [Advanced Shaped Crafting](#advanced-shaped-crafting)
- [Advanced Shapeless Crafting](#advanced-shapeless-crafting)
- [Damage Inputs Crafting](#damage-inputs-crafting)
- [Extra Products Crafting](#extra-products-crafting)
- [No Remainder Crafting](#no-remainder-crafting)

If [FirmaLife](https://modrinth.com/mod/firmalife) is installed, the following recipes are supported:

- [Drying](#firmalife-drying)
- [Smoking](#firmalife-smoking)
- [Mixing Bowl](#firmalife-mixing-bowl)
- [Oven](#firmalife-oven)
- [Stinky Soup](#firmalife-stinky-soup)
- [Vat](#firmalife-vat)
- [Stomping](#firmalife-stomping)
- [Bowl Pot](#firmalife-bowl-pot)
- [Press](#firmalife-press)

If [ArborFirmaCraft](https://modrinth.com/mod/arborfirmacraft-(afc)) is installed, the following recipes are supported:

- [Tree Tap](#afc-tree-tap)

## Alloy

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#alloy)!

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#anvil-welding)!

### Method signature

```ts
event.recipes.tfc.welding(result: ItemStackProviderJS, firstInput: Ingredient, secondInput: Ingredient, tier?: number)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient
- 3rd argument: An item ingredient
- *Optional 4th argument*: A number, the minimum tier of anvil the recipe may be completed on, defaults to `-1`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.welding('minecraft:brick', 'tfc:rock/cobble/dacite', 'minecraft:clay')
})
```

## Working

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#anvil-working)!

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

<br>

- Tier: Accepts a number and sets the minimum anvil tier the recipe can be performed on, defaults to `-1`
- Bonus: Accepts a boolean and sets if the recipe will apply a forging bonus, defaults to `false`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.anvil('kubejs:my_cool_shears', 'kubejs:unworked_shears', ['hit_not_last', 'upset_any']).bonus(true)
})
```

## Barrel Instant Fluid

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#barrel-instant-fluid)!

### Method Signature

```ts
event.recipes.tfc.barrel_instant_fluid(outputFluid: FluidStack, primaryFluid: FluidStackIngredient, addedFluid: FluidStackIngredient, sound?: string)
```

- 1st argument: A `FluidStack`, the result of the recipe
- 2nd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient), the input fluid in the barrel
- 3rd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient), the input fluid added via a fluid container
- *Optional 4th argument*: A string, the registry name of a sound event, defaults to `minecraft:block.brewing_stand.brew`[^1]

{: .notice }
Barrels will not accept fluids that are not tagged `tfc:usable_in_barrel`, make sure that both the output fluid and the input fluid(s) are tagged as such

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.barrel_instant_fluid(Fluid.of('minecraft:water', 50), TFC.fluidStackIngredient('#forge:milk', 30), TFC.fluidStackIngredient('minecraft:lava', 20))
})
```

## Barrel Instant

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#barrel-instant)!

### Method Signature

```ts
event.recipes.tfc.barrel_instant()
    // Additional methods
    .outputItem(outputItem: ItemStackProviderJS)
    .outputFluid(outputFluid: FluidStack)
    .outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)
    .inputItem(inputItem: Ingredient)
    .inputFluid(inputFluid: FluidStackIngredient)
    .inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)
    .sound(sound: string)
```

- OutputItem: Accepts an [ItemStackProviderJS](../bindings/#item-stack-provider) and sets the recipe's output item, defaults to empty
- OutputFluid: Accepts a `FluidStack` and sets the recipe's output fluid, defaults to empty
- Outputs: A convenience method for setting both outputs, identical to `.outputItem().outputFluid()`
- InputItem: Accepts an item ingredient and sets the recipe's input item, will accept counts greater than 1, defaults to empty
- InputFluid: Accepts a [FluidStackIngredient](../bindings/#fluid-stack-ingredient) and sets the recipe's input fluid, defaults to empty
- Inputs: A convenience method for setting both inputs, identical to `.inputItem().inputFluid()`
- Sound: Accepts a string, representing the registry name of a sound event which is played when a recipe finishes, defaults to `minecraft:block.brewing_stand.brew`[^1]

{: .notice }
> An instant barrel recipe must have an input item, input fluid, or both
>
> Barrels will not accept fluids that are not tagged `tfc:usable_in_barrel`, make sure that the input/output fluid(s) are tagged as such

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.barrel_instant()
        .outputs(TFC.itemStackProvider.of('minecraft:cooked_porkchop').copyFood(), TFC.fluidStackIngredient('kubejs:grease', 50))
        .inputItem('4x minecraft:cooked_beef')
})
```

## Barrel Sealed

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#barrel-sealed)!

### Method Signature

```ts
event.recipes.tfc.barrel_sealed(duration: number)
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
- Outputs: A convenience method for setting both outputs, identical to `.outputItem().outputFluid()`
- InputItem: Accepts an item ingredient and sets the recipe's input item, will accept counts greater than 1, defaults to empty
- InputFluid: Accepts a [FluidStackIngredient](../bindings/#fluid-stack-ingredient) amd sets the recipe's input fluid, defaults to empty
- Inputs: A convenience method for setting both inputs, identical to `.inputItem().inputFluid()`
- Sound: Accepts a string, representing the registry name of a sound event which is played when a recipe finishes, defaults to `minecraft:block.brewing_stand.brew`[^1]
- OnSeal: Accepts an [ItemStackProviderJS](../bindings/#item-stack-provider) which will be applied when the barrel is sealed
- OnUnseal: Accepts an [ItemStackProviderJS](../bindings/#item-stack-provider) which will be applied when the barrel is unsealed
- Seal: A convenience method for setting both seals, identical to `.onSeal().onUnseal()`

{: .notice }
> A sealed barrel recipe must have an input item, input fluid, or both
>
> Barrels will not accept fluids that are not tagged `tfc:usable_in_barrel`, make sure that the input/output fluid(s) are tagged as such

[^1]: A full list of all sound events can be attained by running the command `/kubejs dump_registry minecraft:sound_event` in-game

### Example

```js
SeverEvents.recipes(event => {
    event.recipes.tfc.barrel_sealed(5000)
        .outputItem('8x minecraft:mud')
        .inputs('8x #tfc:dirt', TFC.fluidStackIngredient('#minecraft:water', 1000))
})
```

## Blast Furnace

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#blast-furnace)!

### Method Signature

```ts
event.recipes.tfc.blast_furnace(result: FluidStack, catalyst: Ingredient, fluid: FluidStackIngredient)
```

- 1st argument: A `FluidStack`, the output fluid of the recipe
- 2nd argument: An item ingredient specifying the catalyst item
- 3rd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient)

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.blast_furnace(Fluid.of('tfc:metal/zinc', 5), 'kubejs:magic_catalyst', TFC.fluidStackIngredient(['tfc:metal/copper', 'tfc:metal/nickel'], 90))
})
```

## Bloomery

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#bloomery)!

### Method Signature

```ts
event.recipes.tfc.bloomery(result: ItemStackProviderJS, catalyst: Ingredient, fluid: FluidStackIngredient, duration: number)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient, the ingredient which catalysts match, will accept amounts greater than 1
- 3rd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient)
- 4th argument: A number, the number of ticks until the recipe is complete

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.bloomery('3x minecraft:dirt', '#kubejs:dirt_makers', Fluid.of('kubejs:dirt_fluid', 50), 5000)
})
```

## Casting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#casting)!

### Method Signature

```ts
event.recipes.tfc.casting(result: ItemStackProviderJS, mold: Ingredient, fluid: FluidStackIngredient, breakChance: number)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the output of the recipe
- 2nd argument: An item ingredient, used to match the mold item
- 3rd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient)
- 4th argument: A number in the range [0, 1], the probability that the mold will break upon completion of the recipe, a higher number means a higher chance

{: .notice }
> All input fluids for the recipe must have the appropriate fluid tag in order for the mold item to accept them, typically this is either `tfc:usable_in_ingot_mold` or `tfc:usable_in_tool_head_mold`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.casting('8x ae2:skystone', 'kubejs:block_mold', TFC.fluidStackIngredient('minecraft:lava', 4000), 1)
})
```

## Chisel

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#chiseling)!

### Method Signature

```ts
event.recipes.tfc.chisel(result: BlockState, ingredient: BlockIngredient, mode: ChiselMode)
    // Additional methods
    .itemIngredient(itemIngredient: Ingredient)
    .extraDrop(extraDrop: ItemStackProviderJS)
```

- 1st argument: A `BlockState`, the result of the recipe
- 2nd argument: A [BlockIngredient](../blindings/#block-ingredient), the block to be chiseled for the recipe
- 3rd argument: A `ChiselMode`, the chisel mode for the recipe, either `smooth`, `stair`, or `slab`

<br>

- ItemIngredient: An ingredient specifying the chisel, must be in the `tfc:chisels` tag, defaults to `#tfc:chisels`
- ExtraDrop: An [ItemStackProviderJS](../bindings/#item-stack-provider) specifying an extra item to be dropped after chiseling, defaults to empty

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.chisel('minecraft:grass_block[snowy=true]', '#minecraft:flowers', 'smooth')
        .extraDrop('4x minecraft:blue_dye')
})
```

## Collapse/Landslide

See the [collapse](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#collapse) and [landslide](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#landslide) main pages! **Note**: The syntax is exactly the same for both of these recipes, thus they shown together

### Method Signature

```ts
event.recipes.tfc.collapse(result?: BlockState, ingredient: BlockIngredient)
event.recipes.tfc.landslide(result?: BlockState, ingredient: BlockIngredient)
```

- *Optional 1st argument*: A `BlockState`, the result of the recipe, if not provided, the `copy_input` property of the recipe will be implicitly set to `true`
- 2nd argument: A [BlockIngredient](../bindings/#block-ingredient), the ingredient of the recipe

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.collapse('minecraft:grass[snowy=true]', TFC.blockIngredient(['minecraft:dirt', '#forge:unstable_dirts']))
    event.recipes.tfc.landslide(TFC.blockIngredient('#kubejs:landslides_to_self'))
})
```

## Glassworking

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#glassworking)!

### Method Signature

```ts
event.recipes.tfc.glassworking(result: ItemStack, batch: Ingredient, operations: GlassOperation[])
```

- 1st argument: An item stack, the result of the recipe
- 2nd argument: An item ingredient, the required item that must be attached to the blowpipe, needs the `tfc:glass_batches` tag in order to be attached to the blowpipe
- 3rd argument: An array of `GlassOperation`s, see the main page for a list of all possible operations

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.glassworking('3x minecraft:red_stained_glass_pane', 'minecraft:red_stained_glass', ['blow', 'stretch', 'stretch'])
})
```

## Heating

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#heating)!

### Method Signature

```ts
event.recipes.tfc.heating(ingredient: Ingredient, temperature: number)
    // Additional methods
    .resultItem(resultItem: ItemStackProviderJS)
    .resultFluid(resultFluid: FluidStack)
    .results(resultItem: ItemStackProviderJS, resultFluid: FluidStack)
    .useDurability(useDurability: boolean)
    .chance(chance: number)
```

- 1st argument: An item ingredient, the input of the recipe
- 2nd argument: A number, the temperature °C at which the inputs will convert to the outputs (if any)

<br>

- ResultItem: Accepts an [ItemStackProviderJS](../bindings/#item-stack-provider) and sets the result item of the recipe, defaults to empty
- ResultFluid: Accepts a `FluidStack` and sets the result fluid of the recipe, defaults to empty
- Results: A convenience method for setting both results, identical to `.resultItem().resultFluid()`
- useDurability: Accepts a boolean, determines if the recipe should consider the durability of the item when melting into a fluid
- Chance: Accepts a number, in the range [0, 1], sets the chance of the item output

{: .notice }
> The ingredient needs to have an [item heat](../data/#item-heats) added to it
>
> The recipe may define an item result, a fluid result, both, or neither
>
> If the recipe has a fluid result, the fluid *must* have a matching [metal](../data/#metals) definition to work with crucibles

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.heating('minecraft:cobblestone', 1500)
        .results('minecraft:stone', Fluid.of('minecraft:lava', 1))
})
```

## Knapping

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#knapping)!

### Method Signature

```ts
event.recipes.tfc.knapping(result: ItemStack, knappingType: string, pattern: string[])
    //Additional methods
    .ingredient(ingredient: Ingredient)
    .outsideSlotRequired(required: boolean)
```

- 1st argument: An item stack, the result of the recipe
- 2nd argument: A string, the id of the [knapping type](../data/#knapping-types) of the recipe
- 3rd argument: An array of strings representing the knapping grid, may be up to 5 x 5. Spaces are empty spots while any other character are a filled spot

<br>

- Ingredient: Accepts an item ingredient, used to restrict the recipe input even further from the knapping type's ingredient, defaults to empty
- OutsideSlotRequired: For recipes with grids less than 5 x 5, defines if the slots outside the grid are required to be filled or not, defaults to `true`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.knapping('minecraft:clay', 'tfc:clay', ['XXX', 'X X', 'XXX'])
        .outsideSlotRequired(false)
})
```

## Loom

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#loom)!

### Method Signature

```ts
event.recipes.tfc.loom(result: ItemStackProviderJS, ingredient: Ingredient, requiredSteps: number, inProgressTexture: string)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result produced by this recipe
- 2nd argument: An item ingredient, will accepts counts greater than 1
- 3rd argument: A number, the number of times the loom must be interacted with to complete the recipe
- 4th argument: A string, the texture the loom uses to render the recipe while in progress

### Example

```js
ServerEvent.recipes(event => {
    event.recipes.tfc.loom('4x minecraft:red_wool', '4x minecraft:blue_wool', 4, 'minecraft:block/purple_wool')
})
```

## Jam Pot

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes-pot/#jam-pot)!

### Method Signature

```ts
event.recipes.tfc.pot_jam(result: ItemStack, ingredients: Ingredient[], fluidIngredient: FluidStackIngredient, duration: number, temperature: number, texture: string)
```

- 1st argument: The item given to the the player when the pot is clicked with an empty jar
- 2nd argument: An array of item ingredients that the recipe consumes
- 3rd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient), the fluid needed in the pot
- 4th argument: A number, the number of ticks the pot must boil for
- 5th argument: A number, the temperature °C that the pot must be above to start boiling
- 6th argument: A string, the texture location that is rendered in the pot when it is complete and still has output

{: .notice }
Pots will not accept any fluids not tagged `tfc:usable_in_pot`, make sure the input fluid(s) are tagged as such

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.pot_jam('3x tfc:jar/banana', ['minecraft:stick', TFC.ingredient.notRotten('minecraft:cooked_porkchop')], Fluid.of('kubejs:sweet_water', 500), 50, 400, 'tfc:block/jar/banana')
})
```

## Simple Pot

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes-pot/#simple-pot)!

### Method Signature

```ts
event.recipes.tfc.pot(ingredients: Ingredient[], fluidIngredient: FluidStackIngredient, duration: number, temperature: number)
    // Additional methods
    .itemOutput(itemOutput: ItemStackProviderJS[])
    .fluidOutput(fluidOutput: FluidStack)
    .outputs(itemOutput: ItemStackProviderJS[], fluidOutput: FluidStack)
```

- 1st argument: An array of item ingredients that the recipe consumes
- 2nd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient)
- 3rd argument: A number, the number of ticks the pot must boil for
- 4th argument: A number, the temperature °C that the pot must be above to start boiling

<br>

- ItemOutput: An array of [ItemStackProviderJS](../bindings/#item-stack-provider)s indicating what items should be left in the pot
- FluidOutput: A `FluidStack` that the pot produces at the completion of the recipe
- Outputs: A convenience method for setting both outputs, identical to `.itemOutput().fluidOutput()`

{: .notice }
Pots will not accept any fluids not tagged `tfc:usable_in_pot`, make sure the input/output fluid(s) are tagged as such

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.pot(['minecraft:grass', 'minecraft:stone'], Fluid.of('minecraft:lava', 750), 100, 750)
        .outputs(['minecraft:dirt', 'minecraft:red_stained_glass'], Fluid.of('minecraft:water', 50))
})
```

## Soup Pot

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes-pot/#soup-pot)!

### Method Signature

```ts
event.recipes.tfc.pot_soup(ingredients: Ingredient[], fluidIngredient: FluidStackIngredient, duration: number, temperature: number)
```

- 1st argument: An array of item ingredients that the recipe consumes
- 2nd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient) that the recipe requires
- 3rd argument: A number, the number of ticks that the pot must boil for
- 4th argument: A number, the temperature °C that the pot must be above to start boiling

{: .notice }
Pots will not accept any fluids not tagged `tfc:usable_in_pot`, make sure the input fluid(s) are tagged as such

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.pot_soup(['minecraft:red_stained_glass', '#minecraft:flowers'], TFC.fluidStackIngredient('#kubejs:soupy', 750), 845, 300)
})
```

## Quern

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#quern)!

### Method Signature

```ts
event.recipes.tfc.quern(result: ItemStackProviderJS, ingredient: Ingredient)
```

- 1st argument: An [ItemStackProviderJS](..bindings/#item-stack-provider), the output of the recipe
- 2nd argument: An item ingredient, the input for the recipe

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.quern('minecraft:gravel', 'minecraft:cobblestone')
})
```

## Scraping

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#scraping)!

### Method Signature

```ts
event.recipes.tfc.scraping(result: ItemStackProviderJS, ingredient: Ingredient, outputTexture: string, inputTexture: string, extraDrop?: ItemStackProviderJS)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result of the recipe
- 2nd argument: an item ingredient, the input of the recipe
- 3rd argument: A string, the texture of the scraped item
- 4th argument: A string, the texture of the unscraped item
- *Optional 5th argument*: An [ItemStackProviderJS](../bindings/#item-stack-provider), an optional extra drop, only applicable to TFC 3.1.3-beta and above

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.scraping('4x minecraft:paper', '#minecraft:flowers', 'minecraft:block/dirt', 'minecraft:block/red_stained_glass')
})
```

## Sewing

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#sewing)! (may not yet exist)

### Method Signature

```ts
event.recipes.tfc.sewing(result: ItemStack, stitches: number[45], squares: number[32])
```

- 1st argument: An `ItemStack`, the result of the recipe
- 2nd argument: An array of *45* numbers, a value of `0` indicates the position does not have a stitch, a value of `1` indicates the position does have a stitch
- 3rd argument: An array of *32* numbers, a value of `-1` indicates the position does not have a cloth, a value of `0` indicates the position has a dark cloth, a value of `1` indicates the position has a light cloth

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.sewing('6x minecraft:dirt', [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 
        1, 0, 0, 0, 1, 0, 0, 0, 1,
        0, 1, 1, 1, 0, 1, 1, 1, 0,
        1, 0, 0, 0, 1, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0
    ], [
        -1, -1, 0, -1, -1, 0, -1, -1,
        0, 0, 1, 0, 0, 1, 0, 0,
        0, 0, 1, 0, 0, 1, 0, 0,
        -1, -1, 0, -1, -1, 0, -1, -1
    ])
})
```

## Advanced Shaped Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/crafting/#advanced-shaped-crafting)!

### Method Signature

```ts
event.recipes.tfc.advanced_shaped_crafting(result: ItemStackProviderJS, pattern: string[], key: Map<Character, Ingredient>, row: number, column: number)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the output of the recipe
- 2nd argument: The pattern for the crafting grid, spaces can be used to indicate an empty slot
- 3rd argument: A `Character` to ingredient map, associates the pattern to ingredients
- 4th argument: A number, the row of the input ingredient the output uses if it is dependent on its inputs
- 5th argument: A number, the column of the input ingredient the output uses if it is dependent on its inputs

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.advanced_shaped_crafting(TFC.itemStackProvider.of('tfc:food/red_apple').addTrait('kubejs:fruity'), [
        'FLK',
        'KLF'
    ], {
        F: '#minecraft:flowers',
        L: 'minecraft:dirt',
        K: 'tfc:food/red_apple'
    }, 0, 0)
})
```

## Advanced Shapeless Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/crafting/#advanced-shapeless-crafting)!

### Method Signature

```ts
event.recipes.tfc.advanced_shapeless_crafting(result: ItemStackProviderJS, ingredients: Ingredient[], primaryIngredient?: Ingredient)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the output of the recipe
- 2nd argument: An array of item ingredients, the inputs of the recipe
- *Optional 3rd argument*: An item ingredient, which identifies the which slot of the recipe is used as the 'input' if the output is input-dependent

### Examples

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.advanced_shapeless_crafting('minecraft:dirt', ['minecraft:stone', 'minecraft:cobblestone'])
    event.recipes.tfc.advanced_shapeless_crafting(TFC.itemStackProvider.copyInput().addTrait('kubejs:with_added_stones'), ['tfc:food/red_apple', 'tfc:rock/loose/dacite'], 'tfc:food/red_apple')
})
```

## Damage Inputs Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/crafting/#damage-inputs)!

### Method Signatures

```ts
event.recipes.tfc.damage_inputs_shaped_crafting(recipe: ShapedCraftingRecipe)
event.recipes.tfc.damage_inputs_shapeless_crafting(recipe: ShapelessCraftingRecipe)
```

- 1st argument: A crafting recipe, must be the same shaped/shapeless type as the type of the damage inputs recipe

### Examples

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.damage_inputs_shaped_crafting(event.recipes.minecraft.crafting_shaped('minecraft:dirt', [
        'MMN'
    ], {
        M: 'minecraft:stone',
        N: '#tfc:knives'
    }))
    event.recipes.tfc.damage_inputs_shapeless_crafting(event.recipes.minecraft.crafting_shapeless('minecraft:stone', ['#minecraft:flowers', '#minecraft:axes']))
})
```

## Extra products Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/crafting/#extra-products)!

### Method Signatures

```ts
event.recipes.tfc.extra_products_shaped_crafting(extraProducts: ItemStack[], recipe: ShapedCraftingRecipe)
event.recipes.tfc.extra_products_shapeless_crafting(extraProducts: ItemStack[], recipe: ShapelessCraftingRecipe)
```

- 1st argument: An array of `ItemStack`s, the extra products of the recipe
- 2nd argument: A crafting recipe, must be the same shaped/shapeless type as the type of the extra products recipe

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.extra_products_shaped_crafting('3x minecraft:red_stained_glass', event.recipes.minecraft.crafting_shaped('minecraft:dirt', [
        'GHJ'
    ], {
        G: '#minecraft:flowers',
        H: 'minecraft:stone',
        J: 'tfc:rock/raw/diorite'
    }))
    event.recipes.tfc.extra_products_shapeless_crafting('4x minecraft:green_stained_glass_pane', event.recipes.minecraft.crafting_shapeless('minecraft:red_stained_glass', ['minecraft:dirt', '#minecraft:flowers']))
})
```

## No Remainder Crafting

This is a crafting recipe type that prevents any remainders from being left after crafting

### Method Signatures

```ts
event.recipes.tfc.no_remainder_shaped_crafting(recipe: ShapedCraftingRecipe)
event.recipes.tfc.no_remainder_shapeless_crafting(recipe: ShapelessCraftingRecipe)
```

- 1st argument: A crafting recipe, must be the same shaped/shapeless type as the type of the no remainder recipe

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.tfc.no_remainder_shaped_crafting(event.recipes.minecraft.crafting_shaped('minecraft:ice', [
        'SAS'
    ], {
        S: 'kubejs:super_cooler',
        A: 'minecraft:water_bucket'
    }))
    event.recipes.tfc.no_remainder_shapeless_crafting(event.recipes.minecraft.crafting_shapeless('minecraft:obsidian', ['minecraft:water_bucket', 'minecraft:lava_bucket']))
})
```

## FirmaLife Drying

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```ts
event.recipes.firmalife.drying(result: ItemStackProviderJS, ingredient: Ingredient)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.firmalife.drying('kubejs:jerky', TFC.ingredient.notRotten('#tfc:meat'))
})
```

## FirmaLife Smoking

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```ts
event.recipes.firmalife.smoking(result: ItemStackIngredientJS, ingredient: Ingredient)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.firmalife.smoking(TFC.itemStackProvider.copyInput().addTrait('kubejs:smoked'), TFC.ingredient.notRotten('#tfc:meats'))
})
```

## FirmaLife Mixing Bowl

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```ts
event.recipes.firmalife.mixing_bowl()
    // Additional Methods
    .outputItem(outputItem: ItemStack)
    .outputFluid(outputFluid: FluidStackJS)
    .outputs(outputItem: ItemStack, outputFluid: FluidStackJS)
    .itemIngredients(ingredients: Ingredient[])
    .fluidIngredient(fluidIngredient: FluidStackIngredient)
    .ingredients(ingredients: Ingredient[], fluidIngredient: FLuidStackIngredient)
```

- OutputItem: An `ItemStack`, the item output
- OutputFluid: A `FluidStackJS`, the fluid output
- Outputs: A convenience method for setting both outputs, the same as calling `.outputItem().outputFluid()`
- ItemIngredients: An array of item ingredients, the item inputs
- FluidIngredient: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient)
- Ingredients: A convenience method for setting both inputs, the same as calling `.itemIngredients().fluidIngredient()`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.firmalife.mixing_bowl()
        .outputs('minecraft:dirt', Fluid.of('minecraft:milk', 50))
        .itemIngredients(['minecraft:stone', 'minecraft:deepslate'])
})
```

## FirmaLife Oven

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```ts
event.recipes.firmalife.oven(ingredient: Ingredient, temperature: number, duration: number, resultItem?: ItemStackProviderJS)
```

- 1st argument: An item ingredient, the input of the recipe
- 2nd argument: A number, the minimum temperature °C of the top oven for the recipe to operate
- 3rd argument: A number, the number of ticks required for the recipe to finish
- *Optional 4th argument*: An [ItemStackProviderJS](../bindings/#item-stack-provider), the output of the recipe, defaults to `TFC.itemStackProvider.empty()`

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.firmalife.oven('minecraft:spruce_log', 500, 100, 'minecraft:oak_log')
})
```

## FirmaLife Stinky Soup

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```ts
event.recipes.firmalife.stinky_soup(ingredients: Ingredient[], fluidIngredient: FluidStackIngredient, duration: number, temperature: number)
```

- 1st argument: An array of item ingredients, the item inputs of the recipe
- 2nd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient), the fluid input of the recipe
- 3rd argument: A number, the number of ticks required for the recipe to finish
- 4th argument: A number, the minimum temperature °C required for the recipe to operate

{: .notice }
Pots will not accept any fluids not tagged `tfc:usable_in_pot`, make sure the input fluid(s) are tagged as such

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.firmalife.stinky_soup(['minecraft:dirt', TFC.ingredient.not(TFC.ingredient.notRotten())], TFC.fluidStackIngredient('#minecraft:water', 1000), 500, 460)
})
```

## FirmaLife Vat

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```ts
event.recipes.firmalife.vat()
    // Additional methods
    .outputItem(outputProvider: ItemStackProviderJS)
    .outputFluid(outputFluid: FluidStackJS)
    .outputs(itemOutput: ItemStackProviderJS, outputFluid: FluidStackJS)
    .inputItem(inputItem: Ingredient)
    .inputFluid(inputFluid: FluidStackIngredient)
    .inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)
    .length(length: number)
    .temperature(temp: number)
    .jar(jar: ItemStack)
```

- OutputItem: An [ItemStackProviderJS](../bindings/#item-stack-provider), the item output
- OutputFluid: A `FluidStackJS`, the fluid output
- Outputs: A convenience method for setting both outputs, the same as calling `.outputItem().outputFluid()`
- InputItem: An item ingredient, the item input
- InputFluid: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient), the fluid input
- Inputs: A convenience method for setting both inputs, the same as calling `.inputItem().inputFluid()`
- Length: A number, the number of ticks the vat must process for, defaults to `600`
- Temperature: A number, the minimum temperature °C of the vat in order to process, defaults to `300`
- Jar: An `ItemStack` to be attached, only used for recipes that produce `firmalife:fruity_fluid` in conjunction with the jarring station

## FirmaLife Stomping

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```ts
event.recipes.firmalife.stomping(result: ItemStackProviderJS, ingredient, Ingredient, inputTexture: string, outputTexture: string, sound: string)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result
- 2nd argument: An item ingredient, the input
- 3rd argument: A string, the texture to use in the stomping barrel with the input item
- 4th argument: A string, the texture to use in the stomping barrel once the recipe has completed
- 5th argument: A string, the registry name of a sound event[^1], the sound to play when the barrel is stomped

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.firmalife.stomping('minecraft:dirt', 'minecraft:stone', 'tfc:block/charcoal_pile', 'tfc:block/powder/charcoal', 'tfc:block.charcoal.fall')
})
```

## FirmaLife Bowl Pot

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

### Method Signature

```ts
event.recipes.firmalife.bowl_pot(itemOutput: ItemStack, ingredients: Ingredient[], fluidIngredient: FluidStackIngredient, duration: number, temperature: number, food: (Consumer<FoodData> | {water?: number, hunger?: number, saturation?: number, grain?: number, fruit?: number, vegetables?: number, protein?: number, dairy?: number, decay_modifier?: number}))
```

- 1st argument: An item stack, the output of the recipe
- 2nd argument: An array of item ingredients, the item inputs of the recipe
- 3rd argument: A [FluidStackIngredient](../bindings/#fluid-stack-ingredient), the fluid ingredient of the recipe
- 4th argument: A number, the number of ticks the pot will process for
- 5th argument: A number, the temperature °C that the pot needs to get to for the recipe to begin
- 6th argument: Either a [FoodData](../bindings/#fluid-stack-ingredient) consumer or a string to number map containing any of `water`, `saturation`, `grain`, `fruit`, `vegetables`, `protein`, `dairy`, `hunger`, and `decay_modifier` values

{: .notice }
Pots will not accept any fluids not tagged `tfc:usable_in_pot`, make sure the input fluid(s) are tagged as such

### Examples

```js
ServerEvents.recipes(event => {
    event.recipes.firmalife.bowl_pot('minecraft:cooked_beef', [
        'minecraft:dirt',
        'minecraft:stone'
    ], 'minecraft:water', 20, 100, food => {
        food.hunger(50)
        food.protein(10.6)
        food.saturation(2)
    })
    event.recipes.firmalife.bowl_pot('tfc:food/red_apple', [
        'minecraft:poppy',
        'minecraft:oak_log'
    ], 'minecraft:lava', 20, 100, {
        hunger: 3,
        fruit: 12,
        decay_modifier: 0.9
    })
})
```

## FirmaLife Press

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: .unstable }
This recipe type is currently unused by FirmaLife and actually adds itself to the stomping recipe type in JEI

## Method Signature

```ts
event.recipes.firmalife.press(result: ItemStackProviderJS, ingredient, Ingredient, inputTexture: string, outputTexture: string, sound: string)
```

- 1st argument: An [ItemStackProviderJS](../bindings/#item-stack-provider), the result
- 2nd argument: An item ingredient, the input
- 3rd argument: A string, the texture to use in the stomping barrel with the input item
- 4th argument: A string, the texture to use in the stomping barrel once the recipe has completed
- 5th argument: A string, the registry name of a sound event[^1], the sound to play when the barrel is stomped

### Example

```js
ServerEvents.recipes(event => {
    event.recipes.firmalife.press('minecraft:smooth_stone', 'minecraft:cobblestone', 'minecraft:block/cobblestone', 'minecraft:block/smooth_stone', 'tfc:block.charcoal.fall')
})
```

## AFC Tree Tap

AFC's tree tapping recipe type

### Method Signature

```ts
event.recipes.afc.tree_tapping(inputBlock: BlockIngredient)
    .resultFluid(fluid: FluidStackJS)
    .minTemp(f: number)
    .maxTemp(f: number)
    .temps(min: number, max: number)
    .requiresNaturalLog(required: boolean)
    .springOnly(springOnly: boolean)
```

- 1st argument: A [block ingredient](../bindings/#block-ingredient)

<br>

- ResultFluid: Sets the fluid result of the recipe
- MinTemp: Sets the minimum temperature °C at which the recipe will be valid, defaults to `-50`
- MaxTemp: Sets the maximum temperature °C at which the recipe will be valid, defaults to `50`
- temps: Sets the maximum and minimum temperatures °C at which will the recipe will be valid
- RequiresNaturalLog: Determines if the recipe needs the log block to have the `natural=true` property to work, defaults to `true`
- SpringOnly: Determines if the recipe only works during the spring time, defaults to `false`
