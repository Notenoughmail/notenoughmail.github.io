---
layout: page
title: Recipes
permalink: /kubejs_tfc/1.20.1/recipes/
parent: 1.20.1
grand_parent: KubeJS TFC
desc: Documentation on creating TFC recipe through JS
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
- [Soup Pot](#soup-pot)
- [Quern](#quern)
- [Scraping](#scraping)
- [Sewing](#sewing)
- [Advanced Shaped Crafting](#advanced-shaped-crafting)
- [Advanced Shapeless Crafting](#advanced-shapeless-crafting)
- [Damage Inputs Crafting](#damage-inputs-crafting)
- [Extra Products Crafting](#extra-products-crafting)
- [No Remainder Crafting](#no-remainder-crafting)

<a id="firmalife"></a>If *FirmaLife* {% include mr.html link='firmalife' %} {% include cf.html link='firmalife' %} is installed, the following recipes are supported:

- [Drying](#firmalife-drying)
- [Smoking](#firmalife-smoking)
- [Mixing Bowl](#firmalife-mixing-bowl)
- [Oven](#firmalife-oven)
- [Stinky Soup](#firmalife-stinky-soup)
- [Vat](#firmalife-vat)
- [Stomping](#firmalife-stomping)
- [Bowl Pot](#firmalife-bowl-pot)
- [Press](#firmalife-press)

<a id="arborfirmacraft"></a>If *ArborFirmaCraft* {% include mr.html link='arborfirmacraft-(afc)' %} {% include cf.html link='arborfirmacraft' %} is installed, the following recipes are supported:

- [Tree Tap](#afc-tree-tap)

<a id="artisanal"></a>If *TFC Artisanal* {% include mr.html link='tfc-artisanal' %} {% include cf.html link='tfc-artisanal' %} is installed, the following recipes are supported:

- [Scalable Pot](#artisanal-scalable-pot)
- [Damage and Catalyst Shapeless Crafting](#artisanal-damage-and-catalyst-shapeless-crafting)
- [Distillery](#artisanal-distillery)
- [Juicing](#artisanal-juicing)
- [Only If Flux Makes Limewater Instant Barrel](#artisanal-only-if-flux-makes-limewater-instant-barrel)
- [Specific No Remainder Damage Shaped Crafting](#artisanal-specific-no-remainder-damage-shaped-crafting)
- [Specific No Remainder Shaped Crafting](#artisanal-specific-no-remainder-shaped-crafting)
- [Specific No Remainder Shapeless Crafting](#artisanal-specific-no-remainder-shapeless-crafting)

## Alloy

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#alloy)!

{: #alloy-signature }

### Method Signature

```js-20
event.recipes.tfc.alloy(
    result: String,
    contents: AlloyPart[]
)
```

- 1st argument: A string representing the name of a metal
- 2nd argument: An array of [`AlloyPart`]({% link kubejs_tfc/1.20.1/bindings.md %}#alloy-part)s defining the components and their percentage ranges for the recipe

{: .related #alloy-metal-info }
See [the relevant page]({% link kubejs_tfc/1.20.1/data.md %}#metals) for defining custom metals

{: #alloy-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.alloy(
        'tfc:metal',
        [
            TFC.alloyPart('tfc:copper', 0.2, 0.3),
            TFC.alloyPart('tfc:rose_gold', 0.4, 0.8),
            TFC.alloyPart('tfc:black_steel', 0.2, 0.5)
        ]
    )
})
```

## Welding

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#anvil-welding)!

{: #welding-signature }

### Method signature

```js-20
event.recipes.tfc.welding(
    result: ItemStackProvider,
    firstInput: Ingredient,
    secondInput: Ingredient,
    tier?: number
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient
- 3rd argument: An item ingredient
- *Optional 4th argument*: A number, the minimum tier of anvil the recipe may be completed on, defaults to `-1`{:.n}

{: #welding-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.welding(
        'minecraft:brick',
        'tfc:rock/cobble/dacite',
        'minecraft:clay'
    )
})
```

## Working

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#anvil-working)!

{: #working-signature }

### Method Signature

```js-20
event.recipes.tfc.anvil(
    result: ItemStackProvider,
    input: Ingredient,
    rules: ForgeRule[]
)
    // Additional methods
    .tier(tier: number)
    .bonus(applyBonus: boolean)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient
- 3rd argument: An array of up to 3 `ForgeRule`{:.e}s, see the main page for a full list

<span></span>

- `.tier(tier:number)`{: .language-kube-20 #anvil-working-tier }: Accepts a number and sets the minimum anvil tier the recipe can be performed on, defaults to `-1`{:.n}
- `.bonus(applyBnus: boolean)`{: .language-kube-20 #anvil-working-bonus }: Accepts a boolean and sets if the recipe will apply a forging bonus, defaults to `false`{:.p}

{: #working-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.anvil(
        'kubejs:my_cool_shears',
        'kubejs:unworked_shears',
        [
            'hit_not_last',
            'upset_any'
        ]
    ).bonus(true)
})
```

## Barrel Instant Fluid

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#barrel-instant-fluid)!

{: #instant-fluid-barrel-signature }

### Method Signature

```js-20
event.recipes.tfc.barrel_instant_fluid(
    outputFluid: FluidStack,
    primaryFluid: FluidStackIngredient,
    addedFluid: FluidStackIngredient,
    sound?: String
)
```

- 1st argument: A `FluidStack`, the result of the recipe
- 2nd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient), the input fluid in the barrel
- 3rd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient), the input fluid added via a fluid container
- *Optional 4th argument*: A string, the registry name of a sound event, defaults to `minecraft:block.brewing_stand.brew`[^1]

{: .notice #instant-barrel-fluid-notice }
Barrels will not accept fluids that are not tagged `tfc:usable_in_barrel`, make sure that both the output fluid and the input fluid(s) are tagged as such

{: #instant-fluid-barrel-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.barrel_instant_fluid(
        Fluid.of('minecraft:water', 50),
        TFC.fluidStackIngredient('#forge:milk', 30),
        TFC.fluidStackIngredient('minecraft:lava', 20)
    )
})
```

## Barrel Instant

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#barrel-instant)!

{: #instant-barrel-signature }

### Method Signature

```js-20
event.recipes.tfc.barrel_instant()
    // Additional methods
    .outputItem(outputItem: ItemStackProvider)
    .outputFluid(outputFluid: FluidStack)
    .outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)
    .inputItem(inputItem: Ingredient)
    .inputFluid(inputFluid: FluidStackIngredient)
    .inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)
    .sound(sound: String)
```

- `.outputItem(otuputItem: ItemStackProvider)`{: .language-kube-20 #instant-barrel-output-item }: Accepts an [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider) and sets the recipe's output item, defaults to empty
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-20 #instant-barrel-output-fluid }: Accepts a `FluidStack` and sets the recipe's output fluid, defaults to empty
- `.outputs(outputItem: ItemStackProvider, outputFluif: FluidStack)`{: .language-kube-20 #instant-barrel-outputs }: A convenience method for setting both outputs, identical to calling `.outputItem(outputItem).outputFluid(outputFluid)`{: .language-kube-20 }
- `.inputItem(inputItem: Ingredient)`{: .language-kube-20 #instant-barrel-input-item }: Accepts an item ingredient and sets the recipe's input item, will accept counts greater than 1, defaults to empty
- `.inputFluid(inputFluid: FluidStackIngredient)`{: .language-kube-20 #instant-barrel-input-fluid }: Accepts a [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient) and sets the recipe's input fluid, defaults to empty
- `.inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)`{: .language-kube-20 #instant-barrel-inputs }: A convenience method for setting both inputs, identical to calling `.inputItem(inputItem).inputFluid(inputFluid)`{: .language-kube-20 }
- `.sound(sound: String)`{: .language-kube-20 #instant-barrel-sound }: Accepts a string, representing the registry name of a sound event which is played when a recipe finishes, defaults to `minecraft:block.brewing_stand.brew`[^1]

{: .notice #instant-barrel-notice }
> An instant barrel recipe must have an input item, input fluid, or both
>
> Barrels will not accept fluids that are not tagged `tfc:usable_in_barrel`, make sure that the input/output fluid(s) are tagged as such

{: #instant-barrel-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.barrel_instant()
        .outputs(TFC.itemStackProvider.of('minecraft:cooked_porkchop').copyFood(), TFC.fluidStackIngredient('kubejs:grease', 50))
        .inputItem('4x minecraft:cooked_beef')
})
```

## Barrel Sealed

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#barrel-sealed)!

{: #sealed-barrel-signature }

### Method Signature

```js-20
event.recipes.tfc.barrel_sealed(duration: number)
    // Additional methods
    .outputItem(outputItem: ItemStackProvider)
    .outputFluid(outputFluid: FluidStack)
    .outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)
    .inputItem(inputItem: Ingredient)
    .inputFluid(inputFluid: FluidStackIngredient)
    .inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)
    .sound(sound: String)
    .onSeal(onSeal: ItemStackProvider)
    .onUnseal(onUnseal: ItemStackProvider)
    .seal(onSeal: ItemStackProvider, onUnseal: ItemStackProvider)
```

- 1st argument: A number, sets the duration in ticks the barrel must be sealed for, a duration of `-1`{:.n} will make the recipe **infinite**, one or both of the seal types should be defined

<span></span>

- `.outputItem(outputItem: ItemStackProvider)`{: .language-kube-20 #sealed-barrel-output-item }: Accepts an [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider) and sets the recipe's output item, defaults to empty
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-20 #sealed-barrel-output-fluid }: Accepts a `FluidStack` and sets the recipe's output fluid, defaults to empty
- `.outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)`{: .language-kube-20 #sealed-barrel-outputs }: A convenience method for setting both outputs, identical to calling `.outputItem(outputItem).outputFluid(outputFluid)`{: .language-kube-20 }
- `.inputItem(inputItem: Ingredient)`{: .language-kube-20 #sealed-barrel-input-item }: Accepts an item ingredient and sets the recipe's input item, will accept counts greater than 1, defaults to empty
- `.inputFluid(inputFluid: FluidStackIngredient)`{: .language-kube-20 #sealed-barrel-input-fluid }: Accepts a [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient) and sets the recipe's input fluid, defaults to empty
- `.inputs(inputItem: Ingredient, inputFluid: FluidStackIngredeint)`{: .language-kube-20 #sealed-barrel-inputs }: A convenience method for setting both inputs, identical to `.inputItem(inputItem).inputFluid(inputFluid)`{: .language-kube-20 }
- `.sound(sound: String)`{: .language-kube-20 #sealed-barrel-sound }: Accepts a string, representing the registry name of a sound event which is played when a recipe finishes, defaults to `minecraft:block.brewing_stand.brew`[^1]
- `.onSeal(onSeal: ItemStackProvider)`{: .language-kube-20 #sealed-barrel-on-seal }: Accepts an [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider) which will be applied when the barrel is sealed
- `.onUnseal(onUnseal: ItemStackProvider)`{: .language-kube-20 #sealed-barrel-on-unseal }: Accepts an [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider) which will be applied when the barrel is unsealed
- `.seal(onSeal: ItemStackProvider, onUnseal: ItemStackProvider)`{: .language-kube-20 #sealed-barrel-seal }: A convenience method for setting both seals, identical to calling `.onSeal(onSeal).onUnseal(onUnseal)`{: .language-kube-20 }

{: .notice #sealed-barrel-notice }
> A sealed barrel recipe must have an input item, input fluid, or both
>
> Barrels will not accept fluids that are not tagged `tfc:usable_in_barrel`, make sure that the input/output fluid(s) are tagged as such

[^1]: A full list of all sound events can be attained by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game

{: #sealed-barrel-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.barrel_sealed(5000)
        .outputItem('8x minecraft:mud')
        .inputs('8x #tfc:dirt', TFC.fluidStackIngredient('#minecraft:water', 1000))
})
```

## Blast Furnace

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#blast-furnace)!

{: #blast-furnace-signature }

### Method Signature

```js-20
event.recipes.tfc.blast_furnace(
    result: FluidStack,
    catalyst: Ingredient,
    fluid: FluidStackIngredient
)
```

- 1st argument: A `FluidStack`, the output fluid of the recipe
- 2nd argument: An item ingredient specifying the catalyst item
- 3rd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)

{: #blast-furnace-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.blast_furnace(
        Fluid.of('tfc:metal/zinc', 5),
        'kubejs:magic_catalyst',
        TFC.fluidStackIngredient(['tfc:metal/copper', 'tfc:metal/nickel'], 90)
    )
})
```

## Bloomery

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#bloomery)!

{: #bloomery-signature }

### Method Signature

```js-20
event.recipes.tfc.bloomery(
    result: ItemStackProvider,
    catalyst: Ingredient,
    fluid: FluidStackIngredient,
    duration: number
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient, the ingredient which catalysts match, will accept amounts greater than 1
- 3rd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)
- 4th argument: A number, the number of ticks until the recipe is complete

{: #bloomery-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.bloomery(
        '3x minecraft:dirt',
        '#kubejs:dirt_makers',
        Fluid.of('kubejs:dirt_fluid', 50),
        5000
    )
})
```

## Casting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#casting)!

{: #casting-signature }

### Method Signature

```js-20
event.recipes.tfc.casting(
    result: ItemStackProvider,
    mold: Ingredient,
    fluid: FluidStackIngredient,
    breakChance: number
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the output of the recipe
- 2nd argument: An item ingredient, used to match the mold item
- 3rd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)
- 4th argument: A number {% in_range 0,1 %}, the probability that the mold will break upon completion of the recipe, a higher number means a higher chance

{: .notice #casting-notice }
> All input fluids for the recipe must have the appropriate fluid tag in order for the mold item to accept them, typically this is either `tfc:usable_in_ingot_mold` or `tfc:usable_in_tool_head_mold`

{: #casting-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.casting(
        '8x ae2:skystone',
        'kubejs:block_mold',
        TFC.fluidStackIngredient('minecraft:lava', 4000),
        1
    )
})
```

## Chisel

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#chiseling)!

{: #chisel-signature }

### Method Signature

```js-20
event.recipes.tfc.chisel(result: BlockState, ingredient: BlockIngredient, mode: ChiselMode)
    // Additional methods
    .itemIngredient(itemIngredient: Ingredient)
    .extraDrop(extraDrop: ItemStackProvider)
```

- 1st argument: A `BlockState`, the result of the recipe
- 2nd argument: A [`BlockIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient), the block to be chiseled for the recipe
- 3rd argument: A `ChiselMode`{:.e}, the chisel mode for the recipe, either `smooth`{:.e}, `stair`{:.e}, or `slab`{:.e}

<span></span>

- `.itemIngredient(itemIngredient: Ingredient)`{: .language-kube-20 #chisel-item-ingredient }: An ingredient specifying the chisel, must be in the `tfc:chisels` tag, defaults to `#tfc:chisels`
- `.extraDrop(extraDrop: ItemStackProvider)`{: .language-kube-20 #chisel-extra-drop }: An [ItemStackProvider]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider) specifying an extra item to be dropped after chiseling, defaults to empty

{: #chisel-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.chisel('minecraft:grass_block[snowy=true]', '#minecraft:flowers', 'smooth')
        .extraDrop('4x minecraft:blue_dye')
})
```

## Collapse/Landslide

See the [collapse](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#collapse) and [landslide](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#landslide) main pages! **Note**: The syntax is exactly the same for both of these recipes, thus they shown together

{: #collapse-landslide-signature }

### Method Signature

```js-20
event.recipes.tfc.collapse(result?: BlockState, ingredient: BlockIngredient)
event.recipes.tfc.landslide(result?: BlockState, ingredient: BlockIngredient)
```

- *Optional 1st argument*: A `BlockState`, the result of the recipe, if not provided, the `copy_input` property of the recipe will be implicitly set to `true`{:.p}
- 2nd argument: A [`BlockIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient), the ingredient of the recipe

{: #collapse-landslide-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.collapse('minecraft:grass[snowy=true]', TFC.blockIngredient(['minecraft:dirt', '#forge:unstable_dirts']))
    event.recipes.tfc.landslide(TFC.blockIngredient('#kubejs:landslides_to_self'))
})
```

## Glassworking

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#glassworking)!

{: #glassworking-signature }

### Method Signature

```js-20
event.recipes.tfc.glassworking(
    result: ItemStack,
    batch: Ingredient,
    operations: GlassOperation[]
)
```

- 1st argument: An item stack, the result of the recipe
- 2nd argument: An item ingredient, the required item that must be attached to the blowpipe, needs the `tfc:glass_batches` tag in order to be attached to the blowpipe
- 3rd argument: An array of `GlassOperation`{:.e}s, see the main page for a list of all possible operations

{: #glassworking-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.glassworking(
        '3x minecraft:red_stained_glass_pane',
        'minecraft:red_stained_glass',
        [
            'blow',
            'stretch',
            'stretch'
        ]
    )
})
```

## Heating

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#heating)!

{: #heating-signature }

### Method Signature

```js-20
event.recipes.tfc.heating(ingredient: Ingredient, temperature: number)
    // Additional methods
    .resultItem(resultItem: ItemStackProvider)
    .resultFluid(resultFluid: FluidStack)
    .results(resultItem: ItemStackProvider, resultFluid: FluidStack)
    .useDurability(useDurability: boolean)
    .chance(chance: number)
```

- 1st argument: An item ingredient, the input of the recipe
- 2nd argument: A number, the temperature °C at which the inputs will convert to the outputs (if any)

<span></span>

- `.resultItem(resultItem: ItemStackProvider)`{: .language-kube-20 #heating-result-item }: Accepts an [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider) and sets the result item of the recipe, defaults to empty
- `.resultFluid(resultFluid: FluidStack)`{: .language-kube-20 #heating-result-fluid }: Accepts a `FluidStack` and sets the result fluid of the recipe, defaults to empty
- `.results(resultItem: ItemStackProvider, resultFluid: FluidStack)`{: .language-kube-20 #heating-results }: A convenience method for setting both results, identical to calling `.resultItem(resultItem).resultFluid(resultFluid)`{: .language-kube-20 }
- `.useDurability(useDurability: number)`{: .language-kube-20 #heating-use-durability }: Accepts a boolean, determines if the recipe should consider the durability of the item when melting into a fluid
- `.chance(chance: number)`{: .language-kube-20 #heating-chance }: Accepts a number, {% in_range 0,1 %}, sets the chance of the item output

{: .notice #heating-notice }
> The ingredient needs to have an [item heat]({% link kubejs_tfc/1.20.1/data.md %}#item-heats) added to it
>
> The recipe may define an item result, a fluid result, both, or neither
>
> If the recipe has a fluid result, the fluid *must* have a matching [metal]({% link kubejs_tfc/1.20.1/data.md %}#metals) definition to work with crucibles

{: #heating-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.heating('minecraft:cobblestone', 1500)
        .results('minecraft:stone', Fluid.of('minecraft:lava', 1))
})
```

## Knapping

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#knapping)!

{: #knapping-signature }

### Method Signature

```js-20
event.recipes.tfc.knapping(
    result: ItemStack,
    knappingType: String,
    pattern: String[]
)
    //Additional methods
    .ingredient(ingredient: Ingredient)
    .outsideSlotRequired(required: boolean)
```

- 1st argument: An item stack, the result of the recipe
- 2nd argument: A string, the id of the [knapping type]({% link kubejs_tfc/1.20.1/data.md %}#knapping-types) of the recipe
- 3rd argument: An array of strings representing the knapping grid, may be up to 5 x 5. Spaces are empty spots while any other character are a filled spot

<span></span>

- `.ingredient(ingredient: ingredient)`{: .language-kube-20 #knapping-ingredient }: Accepts an item ingredient, used to restrict the recipe input even further from the knapping type's ingredient, defaults to empty
- `.outsideSlotRequired(required: boolean)`{: .language-kube-20 #knapping-outside-required }: For recipes with grids less than 5 x 5, defines if the slots outside the grid are required to be filled or not, defaults to `true`{:.p}

{: #knapping-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.knapping(
        'minecraft:clay',
        'tfc:clay',
        [
            'XXX',
            'X X',
            'XXX'
        ]
    ).outsideSlotRequired(false)
})
```

## Loom

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#loom)!

{: #loom-signature }

### Method Signature

```js-20
event.recipes.tfc.loom(
    result: ItemStackProvider,
    ingredient: Ingredient,
    requiredSteps: number,
    inProgressTexture: String
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result produced by this recipe
- 2nd argument: An item ingredient, will accepts counts greater than 1
- 3rd argument: A number, the number of times the loom must be interacted with to complete the recipe
- 4th argument: A string, the texture the loom uses to render the recipe while in progress

{: #loom-example }

### Example

```js-20
ServerEvent.recipes(event => {
    event.recipes.tfc.loom(
        '4x minecraft:red_wool',
        '4x minecraft:blue_wool',
        4,
        'minecraft:block/purple_wool'
    )
})
```

## Jam Pot

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes-pot/#jam-pot)!

{: #jam-pot-signature }

### Method Signature

```js-20
event.recipes.tfc.pot_jam(
    result: ItemStack,
    ingredients: Ingredient[],
    fluidIngredient: FluidStackIngredient,
    duration: number,
    temperature: number,
    texture: String
)
```

- 1st argument: The item given to the the player when the pot is clicked with an empty jar
- 2nd argument: An array of item ingredients that the recipe consumes
- 3rd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient), the fluid needed in the pot
- 4th argument: A number, the number of ticks the pot must boil for
- 5th argument: A number, the temperature, in °C, that the pot must get to in order to start boiling/start processing the recipe
- 6th argument: A string, the texture location that is rendered in the pot when it is complete and still has output

{: .notice #jam-pot-notice }
Pots will only accept fluids tagged `tfc:usable_in_pot`, make sure the input fluid(s) are tagged as such

{: #jam-pot-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.pot_jam(
        '3x tfc:jar/banana',
        [
            'minecraft:stick',
            TFC.ingredient.notRotten('minecraft:cooked_porkchop')
        ],
        Fluid.of('kubejs:sweet_water', 500),
        50,
        400,
        'tfc:block/jar/banana'
    )
})
```

## Simple Pot

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes-pot/#simple-pot)!

{: #simple-pot-signature }

### Method Signature

```js-20
event.recipes.tfc.pot(
    ingredients: Ingredient[],
    fluidIngredient: FluidStackIngredient,
    duration: number,
    temperature: number
)
    // Additional methods
    .itemOutput(itemOutput: ItemStackProvider[])
    .fluidOutput(fluidOutput: FluidStack)
    .outputs(itemOutput: ItemStackProvider[], fluidOutput: FluidStack)
```

- 1st argument: An array of item ingredients that the recipe consumes
- 2nd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)
- 3rd argument: A number, the number of ticks the pot must boil for
- 4th argument: A number, the temperature, in °C, that the pot must get to in order to start boiling/start processing the recipe

<span></span>

- `.itemOutput(itemOutput: ItemStackProvider[])`{: .language-kube-20 #simple-pot-item-output }: An array of [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider)s indicating what items should be left in the pot
- `.fluidOutput(fluidOutput: FluidStack)`{: .language-kube-20 #simple-pot-fluid-output }: A `FluidStack` that the pot produces at the completion of the recipe
- `.outputs(itemOutput: itemStackProvier[], fluidOutput: FluidStack)`{: .language-kube-20 #simple-pot-outputs }: A convenience method for setting both outputs, identical to `.itemOutput(itemOutput).fluidOutput(fluidOutput)`{: .language-kube-20 }

{: .notice #simple-pot-notice }
Pots will only accept fluids tagged `tfc:usable_in_pot`, make sure the input/output fluid(s) are tagged as such

{: #simple-pot-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.pot(
        [
            'minecraft:grass',
            'minecraft:stone'
        ],
        Fluid.of('minecraft:lava', 750),
        100,
        750
    ).outputs(
        [
            'minecraft:dirt',
            'minecraft:red_stained_glass'
        ],
        Fluid.of('minecraft:water', 50)
    )
})
```

## Soup Pot

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes-pot/#soup-pot)!

{: #soup-pot-signature }

### Method Signature

```js-20
event.recipes.tfc.pot_soup(
    ingredients: Ingredient[],
    fluidIngredient: FluidStackIngredient,
    duration: number,
    temperature: number
)
```

- 1st argument: An array of item ingredients that the recipe consumes
- 2nd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient) that the recipe requires
- 3rd argument: A number, the number of ticks that the pot must boil for
- 4th argument: A number, the temperature, in °C, that the pot must get to in order to start boiling/start processing the recipe

{: .notice #soup-pot-notice }
Pots will only accept fluids tagged `tfc:usable_in_pot`, make sure the input fluid(s) are tagged as such

{: #soup-pot-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.pot_soup(
        [
            'minecraft:red_stained_glass',
            '#minecraft:flowers'
        ],
        TFC.fluidStackIngredient('#kubejs:soupy', 750),
        845,
        300
    )
})
```

## Quern

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#quern)!

{: #quern-signature }

### Method Signature

```js-20
event.recipes.tfc.quern(result: ItemStackProvider, ingredient: Ingredient)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}/#item-stack-provider), the output of the recipe
- 2nd argument: An item ingredient, the input for the recipe

{: #quern-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.quern('minecraft:gravel', 'minecraft:cobblestone')
})
```

## Scraping

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#scraping)!

{: #scraping-signature }

### Method Signature

```js-20
event.recipes.tfc.scraping(
    result: ItemStackProvider,
    ingredient: Ingredient,
    outputTexture: String,
    inputTexture: String,
    extraDrop?: ItemStackProvider
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result of the recipe
- 2nd argument: an item ingredient, the input of the recipe
- 3rd argument: A string, the texture of the scraped item
- 4th argument: A string, the texture of the unscraped item
- *Optional 5th argument*: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), an optional extra drop

{: .notice #scraping-ingredient-tag }
In order to actually place an item on a log to scrape, it must have the `tfc:scrapable` item tag. Additionally, a game restart may be required for placement to become possible

{: #scraping-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.scraping(
        '4x minecraft:paper',
        '#minecraft:flowers',
        'minecraft:block/dirt',
        'minecraft:block/red_stained_glass'
    )
})
```

## Sewing

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/recipes/#sewing)! (may not yet exist)

{: #sewing-signature }

### Method Signature

```js-20
event.recipes.tfc.sewing(result: ItemStack, stitches: number[45], squares: number[32])
```

- 1st argument: An `ItemStack`, the result of the recipe
- 2nd argument: An array of 45 numbers (9 wide by 5 tall, as mapped to the corners of the sewing table's grid spaces), a value of `0`{:.n} indicates the position does not have a stitch, a value of `1`{:.n} indicates the position does have a stitch
- 3rd argument: An array of 32 numbers (8 wide by 4 tall, as mapped to the squares of the sewing table's grid spaces), a value of `-1`{:.n} indicates the position does not have a cloth, a value of `0`{:.n} indicates the position has a dark cloth, a value of `1`{:.n} indicates the position has a light cloth

{: #sewing-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.sewing(
        '6x minecraft:dirt',
        [
            0, 0, 0, 0, 0, 0, 0, 0, 0, 
            1, 0, 0, 0, 1, 0, 0, 0, 1,
            0, 1, 1, 1, 0, 1, 1, 1, 0,
            1, 0, 0, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0
        ], [
            -1, -1, 0, -1, -1, 0, -1, -1,
             0,  0, 1,  0,  0, 1,  0,  0,
             0,  0, 1,  0,  0, 1,  0,  0,
            -1, -1, 0, -1, -1, 0, -1, -1
        ]
    )
})
```

## Advanced Shaped Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/crafting/#advanced-shaped-crafting)!

This recipe type supports[^2] Kube's ingredient and result modifiers. The result modifiers apply *after* any ISP modifiers.

[^2]: Technically, the support is implemented through an entirely different recipe type, but this is automatically converted to that type when any of Kube's ingredient/result modifiers are present.

{: #advanced-shaped-crafting-signature }

### Method Signature

```js-20
event.recipes.tfc.advanced_shaped_crafting(
    result: ItemStackProvider,
    pattern: String[],
    key: Map<Character, Ingredient>,
    row: number,
    column: number
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the output of the recipe
- 2nd argument: The pattern for the crafting grid, spaces can be used to indicate an empty slot
- 3rd argument: A `Character` to ingredient map, associates the pattern to ingredients
- 4th argument: A number, the row of the input ingredient the output uses if it is dependent on its inputs
- 5th argument: A number, the column of the input ingredient the output uses if it is dependent on its inputs

{: #advanced-shaped-crafting-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.advanced_shaped_crafting(
        TFC.itemStackProvider.of('tfc:food/red_apple').addTrait('kubejs:fruity'),
        [
            'FLK',
            'KLF'
        ], {
            F: '#minecraft:flowers',
            L: 'minecraft:dirt',
            K: 'tfc:food/red_apple'
        },
        0,
        0
    )
})
```

## Advanced Shapeless Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/crafting/#advanced-shapeless-crafting)!

This recipe type supports[^2] Kube's ingredient and result modifiers. The result modifiers apply *after* any ISP modifiers.

{: #advanced-shapeless-crafting-signature }

### Method Signature

```js-20
event.recipes.tfc.advanced_shapeless_crafting(
    result: ItemStackProvider,
    ingredients: Ingredient[],
    primaryIngredient?: Ingredient
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the output of the recipe
- 2nd argument: An array of item ingredients, the inputs of the recipe
- *Optional 3rd argument*: An item ingredient, which identifies the which slot of the recipe is used as the 'input' if the output is input-dependent

{: #advanced-shapeless-crafting-example }

### Examples

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.advanced_shapeless_crafting(
        'minecraft:dirt',
        [
            'minecraft:stone',
            'minecraft:cobblestone'
        ]
    )
    event.recipes.tfc.advanced_shapeless_crafting(
        TFC.itemStackProvider.copyInput().addTrait('kubejs:with_added_stones'),
        [
            'tfc:food/red_apple',
            'tfc:rock/loose/dacite'
        ],
        'tfc:food/red_apple'
    )
})
```

## Damage Inputs Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/crafting/#damage-inputs)!

{: #damage-inputs-signature }

### Method Signatures

```js-20
event.recipes.tfc.damage_inputs_shaped_crafting(recipe: ShapedCraftingRecipe)
event.recipes.tfc.damage_inputs_shapeless_crafting(recipe: ShapelessCraftingRecipe)
```

- 1st argument: A crafting recipe, must be the same shaped/shapeless type as the type of the damage inputs recipe

{: #damage-inputs-example }

### Examples

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.damage_inputs_shaped_crafting(
        event.recipes.minecraft.crafting_shaped(
            'minecraft:dirt',
            [
                'MMN'
            ], {
                M: 'minecraft:stone',
                N: '#tfc:knives'
            }
        )
    )
    event.recipes.tfc.damage_inputs_shapeless_crafting(
        event.recipes.minecraft.crafting_shapeless(
            'minecraft:stone',
            [
                '#minecraft:flowers',
                '#minecraft:axes'
            ]
        )
    )
})
```

## Extra products Crafting

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/crafting/#extra-products)!

{: #extra-products-signature }

### Method Signatures

```js-20
event.recipes.tfc.extra_products_shaped_crafting(
    extraProducts: ItemStack[],
    recipe: ShapedCraftingRecipe
)
event.recipes.tfc.extra_products_shapeless_crafting(
    extraProducts: ItemStack[],
    recipe: ShapelessCraftingRecipe
)
```

- 1st argument: An array of `ItemStack`s, the extra products of the recipe
- 2nd argument: A crafting recipe, must be the same shaped/shapeless type as the type of the extra products recipe

{: #extra-products-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.extra_products_shaped_crafting(
        '3x minecraft:red_stained_glass',
        event.recipes.minecraft.crafting_shaped(
            'minecraft:dirt',
            [
                'GHJ'
            ], {
                G: '#minecraft:flowers',
                H: 'minecraft:stone',
                J: 'tfc:rock/raw/diorite'
            }
        )
    )
    event.recipes.tfc.extra_products_shapeless_crafting(
        '4x minecraft:green_stained_glass_pane',
        event.recipes.minecraft.crafting_shapeless(
            'minecraft:red_stained_glass',
            [
                'minecraft:dirt',
                '#minecraft:flowers'
            ]
        )
    )
})
```

## No Remainder Crafting

This is a crafting recipe type that prevents any remainders from being left after crafting

{: #no-remainder-signature }

### Method Signatures

```js-20
event.recipes.tfc.no_remainder_shaped_crafting(recipe: ShapedCraftingRecipe)
event.recipes.tfc.no_remainder_shapeless_crafting(recipe: ShapelessCraftingRecipe)
```

- 1st argument: A crafting recipe, must be the same shaped/shapeless type as the type of the no remainder recipe

{: #no-remainder-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.tfc.no_remainder_shaped_crafting(
        event.recipes.minecraft.crafting_shaped(
            'minecraft:ice',
            [
                'SAS'
            ], {
                S: 'kubejs:super_cooler',
                A: 'minecraft:water_bucket'
            }
        )
    )
    event.recipes.tfc.no_remainder_shapeless_crafting(
        event.recipes.minecraft.crafting_shapeless(
            'minecraft:obsidian',
            [
                'minecraft:water_bucket',
                'minecraft:lava_bucket'
            ]
        )
    )
})
```

## FirmaLife Drying

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: firmalife-drying-signature }

### Method Signature

```js-20
event.recipes.firmalife.drying(
    result: ItemStackProvider,
    ingredient: Ingredient
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient

{: #firmalife-drying-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.drying(
        'kubejs:jerky',
        TFC.ingredient.notRotten('#tfc:meat')
    )
})
```

## FirmaLife Smoking

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: #firmalife-smoking-signature }

### Method Signature

```js-20
event.recipes.firmalife.smoking(
    result: ItemStackIngredientJS,
    ingredient: Ingredient
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result of the recipe
- 2nd argument: An item ingredient

{: #firmalife-smoking-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.smoking(
        TFC.isp.copyInput().addTrait('kubejs:smoked'),
        TFC.ingredient.notRotten('#tfc:meats')
    )
})
```

## FirmaLife Mixing Bowl

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: #firmalife-mixing-bowl-signature }

### Method Signature

```js-20
event.recipes.firmalife.mixing_bowl()
    // Additional Methods
    .outputItem(outputItem: ItemStack)
    .outputFluid(outputFluid: FluidStack)
    .outputs(outputItem: ItemStack, outputFluid: FluidStack)
    .itemIngredients(ingredients: Ingredient[])
    .fluidIngredient(fluidIngredient: FluidStackIngredient)
    .ingredients(ingredients: Ingredient[], fluidIngredient: FluidStackIngredient)
```

- `.outputItem(outputItem: ItemStack)`{: .language-kube-20 #mixing-bowl-output-item }: An `ItemStack`, the item output
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-20 #mixing-bowl-output-fluid }: A `FluidStack`, the fluid output
- `.outputs(outputItem: ItemStack, outputFluid: Fluidstack)`{: .language-kube-20 #mixing-bowl-outputs }: A convenience method for setting both outputs, the same as calling `.outputItem(outputItem).outputFluid(outputFluid)`{: .language-kube-20 }
- `.itemIngredients(ingredients: Ingredient[])`{: .language-kube-20 #mixing-bowl-item-ingredients }: An array of item ingredients, the item inputs
- `.fluidIngredient(fluidIngredient: FluidStackIgnredient)`{: .language-kube-20 #mixing-bowl-fluid-ingredients }: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)
- `.ingredients(ingredients: Ingredient[], fluidIngredient: FluidStackIngredient)`{: .language-kube-20 #mixing-bowl-ingredients }: A convenience method for setting both inputs, the same as calling `.itemIngredients(ingredients).fluidIngredient(fluidIngredient)`{: .language-kube-20 }

{: #firmalife-mixing-bowl-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.mixing_bowl()
        .outputs('minecraft:dirt', Fluid.of('minecraft:milk', 50))
        .itemIngredients(['minecraft:stone', 'minecraft:deepslate'])
})
```

## FirmaLife Oven

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: #firmalife-oven-signature }

### Method Signature

```js-20
event.recipes.firmalife.oven(
    ingredient: Ingredient,
    temperature: number,
    duration: number,
    resultItem?: ItemStackProvider
)
```

- 1st argument: An item ingredient, the input of the recipe
- 2nd argument: A number, the minimum temperature °C of the top oven for the recipe to operate
- 3rd argument: A number, the number of ticks required for the recipe to finish
- *Optional 4th argument*: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the output of the recipe, defaults to `TFC.itemStackProvider.empty()`{: .language-kube-20 }

{: #firmalife-oven-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.oven(
        'minecraft:spruce_log',
        500,
        100,
        'minecraft:oak_log'
    )
})
```

## FirmaLife Stinky Soup

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: #firmalife-stinky-soup-signature }

### Method Signature

```js-20
event.recipes.firmalife.stinky_soup(
    ingredients: Ingredient[],
    fluidIngredient: FluidStackIngredient,
    duration: number,
    temperature: number
)
```

- 1st argument: An array of item ingredients, the item inputs of the recipe
- 2nd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient), the fluid input of the recipe
- 3rd argument: A number, the number of ticks required for the recipe to finish
- 4th argument: A number, the minimum temperature °C required for the recipe to operate

{: .notice #firmalife-stinky-soup-notice }
Pots will not accept any fluids not tagged `tfc:usable_in_pot`, make sure the input fluid(s) are tagged as such

{: #firmalife-stinky-soup-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.stinky_soup(
        [
            'minecraft:dirt',
            TFC.ingredient.not(TFC.ingredient.notRotten())
        ],
        TFC.fluidStackIngredient('#minecraft:water', 1000),
        500,
        460
    )
})
```

## FirmaLife Vat

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: #firmalife-vat-signature }

### Method Signature

```js-20
event.recipes.firmalife.vat()
    // Additional methods
    .outputItem(outputProvider: ItemStackProvider)
    .outputFluid(outputFluid: FluidStack)
    .outputs(itemOutput: ItemStackProvider, outputFluid: FluidStack)
    .inputItem(inputItem: Ingredient)
    .inputFluid(inputFluid: FluidStackIngredient)
    .inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)
    .length(length: number)
    .temperature(temp: number)
    .jar(jar: ItemStack)
```

- `.outputItem(outputProvier: ItemStackProvider)`{: .language-kube-20 #vat-output-item }: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the item output
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-20 #vat-output-fluid }: A `FluidStack`, the fluid output
- `.outputs(itemOutput: ItemStackProvider, outputFluid: FluidStack)`{: .language-kube-20 #vat-outputs }: A convenience method for setting both outputs, the same as calling `.outputItem(itemOutput).outputFluid(outputFluid)`{: .language-kube-20 }
- `.inputItem(inputItem: Ingredient)`{: .language-kube-20 #vat-input-item }: An item ingredient, the item input
- `.inputFluid(inputFluid: FluidStackIngredient)`{: .language-kube-20 #vat-input-fluid }: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient), the fluid input
- `.inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)`{: .language-kube-20 #vat-inputs }: A convenience method for setting both inputs, the same as calling `.inputItem(inputItem).inputFluid(inputFluid)`{: .language-kube-20 }
- `.length(length: number)`{: .language-kube-20 #vat-length }: A number, the number of ticks the vat must process for, defaults to `600`{:.n}
- `.temperature(temp: number)`{: .language-kube-20 #vat-temperature }: A number, the minimum temperature °C of the vat in order to process, defaults to `300`{:.n}
- `.jar(jar: ItemStack)`{: .language-kube-20 #vat-jar }: An `ItemStack` to be attached, only used for recipes that produce `firmalife:fruity_fluid` in conjunction with the jarring station

{: #firmalife-vat-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.vat()
        .outputItem('minecraft:dirt')
        .inputFluid(Fluid.of('minecraft:lava', 500))
        .length(60)
})
```

## FirmaLife Stomping

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: #firmalife-stomping-signature }

### Method Signature

```js-20
event.recipes.firmalife.stomping(
    result: ItemStackProvider,
    ingredient: Ingredient,
    inputTexture: String,
    outputTexture: String,
    sound: String
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result
- 2nd argument: An item ingredient, the input
- 3rd argument: A string, the texture to use in the stomping barrel with the input item
- 4th argument: A string, the texture to use in the stomping barrel once the recipe has completed
- 5th argument: A string, the registry name of a sound event[^1], the sound to play when the barrel is stomped

{: #firmalife-stomping-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.stomping(
        'minecraft:dirt',
        'minecraft:stone',
        'tfc:block/charcoal_pile',
        'tfc:block/powder/charcoal',
        'tfc:block.charcoal.fall'
    )
})
```

## FirmaLife Bowl Pot

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: #firmalife-bowl-pot-signature }

### Method Signature

```js-20
event.recipes.firmalife.bowl_pot(
    itemOutput: ItemStack,
    ingredients: Ingredient[],
    fluidIngredient: FluidStackIngredient,
    duration: number,
    temperature: number,
    food: (Consumer<FoodData> | {
        water?: number,
        hunger?: number,
        saturation?: number,
        grain?: number,
        fruit?: number,
        vegetables?: number,
        protein?: number,
        dairy?: number,
        decay_modifier?: number
    })
)
```

- 1st argument: An item stack, the output of the recipe
- 2nd argument: An array of item ingredients, the item inputs of the recipe
- 3rd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient), the fluid ingredient of the recipe
- 4th argument: A number, the number of ticks the pot will process for
- 5th argument: A number, the temperature °C that the pot needs to get to for the recipe to begin
- 6th argument: Either a [`FoodData`]({% link kubejs_tfc/1.20.1/data.md %}#food-items) consumer or a string to number map containing any of `water`{:.v}, `saturation`{:.v}, `grain`{:.v}, `fruit`{:.v}, `vegetables`{:.v}, `protein`{:.v}, `dairy`{:.v}, `hunger`{:.v}, and `decay_modifier`{:.v} values

{: .notice #firmalife-bowl-pot-notice }
Pots will not accept any fluids not tagged `tfc:usable_in_pot`, make sure the input fluid(s) are tagged as such

{: #firmalife-bowl-pot-example }

### Examples

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.bowl_pot(
        'minecraft:cooked_beef',
        [
            'minecraft:dirt',
            'minecraft:stone'
        ],
        'minecraft:water',
        20,
        100,
        food => {
            food.hunger(50)
            food.protein(10.6)
            food.saturation(2)
        }
    )
    event.recipes.firmalife.bowl_pot(
        'tfc:food/red_apple',
        [
            'minecraft:poppy',
            'minecraft:oak_log'
        ],
        'minecraft:lava',
        20,
        100,
        {
            hunger: 3,
            fruit: 12,
            decay_modifier: 0.9
        }
    )
})
```

## FirmaLife Press

See the [main page](https://github.com/eerussianguy/firmalife/wiki/Datapack-Documentation)!

{: .unstable #firmalife-press-unstable }
This recipe type is currently unused by FirmaLife and actually adds itself to the stomping recipe type in JEI

{: #firmalife-press-signature }

## Method Signature

```js-20
event.recipes.firmalife.press(
    result: ItemStackProvider,
    ingredient: Ingredient,
    inputTexture: String,
    outputTexture: String,
    sound: String
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result
- 2nd argument: An item ingredient, the input
- 3rd argument: A string, the texture to use in the stomping barrel with the input item
- 4th argument: A string, the texture to use in the stomping barrel once the recipe has completed
- 5th argument: A string, the registry name of a sound event[^1], the sound to play when the barrel is stomped

{: #firmalife-press-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.firmalife.press(
        'minecraft:smooth_stone',
        'minecraft:cobblestone',
        'minecraft:block/cobblestone',
        'minecraft:block/smooth_stone',
        'tfc:block.charcoal.fall'
    )
})
```

## AFC Tree Tap

AFC's tree tapping recipe type

{: #afc-tree-tap-signature }

### Method Signature

```js-20
event.recipes.afc.tree_tapping(inputBlock: BlockIngredient)
    // Additional methods
    .resultFluid(fluid: FluidStack)
    .minTemp(f: number)
    .maxTemp(f: number)
    .temps(min: number, max: number)
    .requiresNaturalLog(required: boolean)
    .springOnly(springOnly: boolean)
```

- 1st argument: A [block ingredient]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient)

<span></span>

- `.resultFluid(fluid: FluidStack)`{: .language-kube-20 #tree-tap-result-fluid }: Sets the fluid result of the recipe
- `.minTemp(f: number)`{: .language-kube-20 #tree-tap-min-temp }: Sets the minimum temperature °C at which the recipe will be valid, defaults to `-50`{:.n}
- `.maxTemp(f: number)`{: .language-kube-20 #tree-tap-max-temp }: Sets the maximum temperature °C at which the recipe will be valid, defaults to `50`{:.n}
- `.temps(min: number, max: number)`{: .language-kube-20 #tree-tap-temps }: Sets the maximum and minimum temperatures °C at which will the recipe will be valid
- `.requiresNaturalLog(required: boolean)`{: .language-kube-20 #tree-tap-requires-natural }: Determines if the recipe needs the input block to have TFC's [`branch_direction`{:.e}](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/common/blocks/TFCBlockStateProperties.java#L82) state property and have a value that is not `none`{:.e} to work. Defaults to `true`{:.p}
- `.springOnly(springOnly: boolean)`{: .language-kube-20 #tree-tap-spring-only }: Determines if the recipe only works during the spring time, defaults to `false`{:.p}

{: .notice #treetap-notice }
Tree taps can only be placed on blocks with the `afc:tappable_logs` tag, make sure the input blocks(s) are tagged as such

{: #afc-tree-tap-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.afc.tree_tapping(TFC.blockIngredient('minecraft:oak_log'))
        .resultFluid(Fluid.of('minecraft:water', 2))
        .springOnly(true)
})
```

## Artisanal Scalable Pot

Artisanal's scalable pot recipe type, similar to the regular pot but scales the output stacks based on how much excess fluid was in the pot

{: #artisanal-scalable-pot-signature }

### Method Signature

```js-20
event.recipes.artisanal.scalable_pot(
    ingredients: Ingredient[],
    fluidIngredient: FluidStackIngredient,
    duration: number,
    temperature: number
)
    // Additional methods
    .itemOutput(itemOutput: ItemStackProvider[])
    .fluidOutput(fluidOutput: FluidStack)
    .outputs(itemOutput: ItemStackProvider[], fluidOutput: FluidStack)
```

- 1st argument: An array of item ingredients that the recipe consumes
- 2nd argument: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)
- 3rd argument: A number, the number of ticks the pot must boil for
- 4th argument: A number, the temperature, in °C, that the pot must get to in order to start boiling/start processing the recipe

<span></span>

- `.itemOutput(itemOutput: ItemStackProvider[])`{: .language-kube-20 #artisanal-scalable-pot-item-output }: An array of [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider)s indicating what items should be left in the pot
- `.fluidOutput(fluidOutput: FluidStack)`{: .language-kube-20 #artisanal-scalable-pot-fluid-output }: A `FluidStack` that the pot produces at the completion of the recipe
- `.outputs(itemOutput: itemStackProvier[], fluidOutput: FluidStack)`{: .language-kube-20 #artisanal-scalable-pot-outputs }: A convenience method for setting both outputs, identical to `.itemOutput(itemOutput).fluidOutput(fluidOutput)`{: .language-kube-20 }

{: .notice #artisanal-scalable-pot-notice }
Pots will only accept fluids tagged `tfc:usable_in_pot`, make sure the input/output fluid(s) are tagged as such

{: #artisanal-scalable-pot-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.artisanal.scalable_pot(
        [
            'minecraft:dirt',
            'minecraft:cobblestone'
        ],
        Fluid.of('minecraft:lava', 20),
        100,
        5
    ).fluidOutput(
        Fluid.of('minecraft:milk', 50)
    )
})
```

## Artisanal Damage and Catalyst Shapeless Crafting

Artisanal's damage and catalyst shapeless crafting recipe. Identical to TFC's [damage inputs](#damage-inputs-crafting) recipe type except it also ignores item tagged `artisanal:crafting_catalysts` when determining which items to damage

{: #artisanal-damage-and-catalyst-shapeless-crafting-signature }

### Method Signature

```js-20
event.recipes.artisanal.damage_and_catalyst_shapeless_crafting(
    recipe: ShapelessCraftingRecipe
)
```

- 1st argument: A crafting recipe, must be shapeless

{: #artisanal-damage-and-catalyst-shapeless-crafting-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.artisanal.damage_and_catalyst_shapeless_crafting(
        event.recipes.minecraft.crafting_shapeless('2x minecraft:gold_ingot', [
            'tfc:metal/double_ingot/gold',
            '#artisanal:magnifying_glasses',
            '#tfc:saws'
        ])
    )
})
```

## Artisanal Distillery

Artisanal's distillery recipe type

{: #artisanal-distillery-signature }

### Method Signature

```js-20
event.recipes.artisanal.distillery(
    minTemp: number,
    duration: number
)
    // Additional methods
    .inputItem(ingredient: Ingredient)
    .inputFluid(fluidIngredient: FluidStackIngredient)
    .inputs(ingredient: Ingredient, fluidIngredient: FluidStackIngredient)
    .resultItem(resultItem: ItemStackProvider)
    .resultFluid(resultFluid: FluidStack)
    .results(resultItem: ItemStackProvider, resultFluid: FluidStack)
    .leftoverItem(leftoverItem: ItemStackProvider)
    .leftoverFluid(leftoverFluid: FluidStack)
    .leftovers(leftoverItem: ItemStackProvider, leftoverFluid: FluidStack)
```

- 1st argument: A number, the minimum temperature, in °C, the distillery requires to preform the recipe
- 2nd argument: A number, how long, in ticks, the recipe takes to complete

<span></span>

- `.inputItem(ingredient: Ingredient)`{: .language-kube-20 #artisanal-distillery-input-item }: An item ingredient, the input item
- `.inputFluid(fluidIngredient: FluidStackIngredient)`{: .language-kube-20 #artisanal-distillery-input-fluid }: A [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient), the input fluid
- `.inputs(ingredient: Ingredient, fluidIngredient: FluidStackIngredient)`{: .language-kube-20 #artisanal-distillery-inputs }: A convenience method for setting both inputs, identical to calling `.inputItem(ingredient).inputFluid(fluidIngredient)`{: .language-kube-20 }
- `.resultItem(resultItem: ItemStackProvider)`{: .language-kube-20 #artisanal-distillery-result-item }: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the result of the recipe
- `.resultFluid(resultFluid: FluidStack)`{: .language-kube-20 #artisanal-distillery-result-fluid }: A `FluidStack`, the fluid result of the recipe
- `.results(resultItem: ItemStackProvider, resultFluid: FluidStack)`{: .language-kube-20 #artisanal-distillery-results }: A convenience method for setting both results, identical to calling `.resultItem(resultItem).resultFluid(resultFluid)`{: .language-kube-20 }
- `.leftoverItem(leftoverItem: ItemStackProvider)`{: .language-kube-20 #artisanal-distillery-leftover-item }: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the leftover item
- `.leftoverFluid(leftoverFluid: FluidStack)`{: .language-kube-20 #artisanal-distillery-leftover-fluid }: A `FluidStack`, the leftover fluid
- `.leftovers(leftoverItem: ItemStackProvider, leftoverFluid: FluidStack)`{: .language-kube-20 #artisanal-distillery-leftovers }: A convenience method for setting both leftovers, identical to calling `.leftoverItem(leftoverItem).leftoverFluid(leftoverFluid)`{: .language-kube-20 }

{: #artisanal-distillery-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.artisanal.distillery(450, 20)
        .inputs('minecraft:iron_ingot', TFC.fluidStackIngredient('#minecraft:water', 50))
        .results('minecraft:sculk', Fluid.of('minecraft:lava', 20))
        .leftOverItem('minecraft:beacon')
})
```

## Artisanal Juicing

Artisanal's juicing recipe type

{: #artisanal-juicing-signature }

### Method Signature

```js-20
event.recipes.artisanal.juicing(
    result: FluidStack,
    ingredient: Ingredient
)
```

- 1st argument: A `FluidStack`, the output of the recipe
- 2nd argument: An item ingredient, the input item

{: #artisanal-juicing-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.artisanal.juicing(
        Fluid.of('minecraft:milk', 50),
        'tfc:food/barley_grain'
    )
})
```

## Artisanal Only If Flux Makes Limewater Instant Barrel

Artisanal's only if flux makes limewater instant barrel recipe type, an version of [instant barrel recipes](#barrel-instant) which only works if Artisanal's `fluxMakesLimewater` config option is enabled

{: #artisanal-config-barrel-signature }

### Method Signature

```js-20
event.recipes.artisanal.only_if_flux_makes_limewater_instant_barrel()
    // Additional methods
    .outputItem(outputItem: ItemStackProvider)
    .outputFluid(outputFluid: FluidStack)
    .outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)
    .inputItem(inputItem: Ingredient)
    .inputFluid(inputFluid: FluidStackIngredient)
    .inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)
    .sound(sound: String)
```

- `.outputItem(otuputItem: ItemStackProvider)`{: .language-kube-20 #artisanal-config-barrel-output-item }: Accepts an [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider) and sets the recipe's output item, defaults to empty
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-20 #artisanal-config-barrel-output-fluid }: Accepts a `FluidStack` and sets the recipe's output fluid, defaults to empty
- `.outputs(outputItem: ItemStackProvider, outputFluif: FluidStack)`{: .language-kube-20 #artisanal-config-barrel-outputs }: A convenience method for setting both outputs, identical to calling `.outputItem(outputItem).outputFluid(outputFluid)`{: .language-kube-20 }
- `.inputItem(inputItem: Ingredient)`{: .language-kube-20 #artisanal-config-barrel-input-item }: Accepts an item ingredient and sets the recipe's input item, will accept counts greater than 1, defaults to empty
- `.inputFluid(inputFluid: FluidStackIngredient)`{: .language-kube-20 #artisanal-config-barrel-input-fluid }: Accepts a [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient) and sets the recipe's input fluid, defaults to empty
- `.inputs(inputItem: Ingredient, inputFluid: FluidStackIngredient)`{: .language-kube-20 #artisanal-config-barrel-inputs }: A convenience method for setting both inputs, identical to calling `.inputItem(inputItem).inputFluid(inputFluid)`{: .language-kube-20 }
- `.sound(sound: String)`{: .language-kube-20 #artisanal-config-barrel-sound }: Accepts a string, representing the registry name of a sound event which is played when a recipe finishes, defaults to `minecraft:block.brewing_stand.brew`[^1]

{: .notice #artisanal-config-barrel-notice }
> An instant barrel recipe must have an input item, input fluid, or both
>
> Barrels will not accept fluids that are not tagged `tfc:usable_in_barrel`, make sure that the input/output fluid(s) are tagged as such

{: #artisanal-config-barrel-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.artisanal.only_if_flux_makes_limewater_instant_barrel()
        .outputs('minecraft:diamond', Fluid.of('minecraft:lava', 50))
        .sound('minecraft:ambient.cave')
        .inputFluid(Fluid.of('tfc:limewater', 500))
})
```

## Artisanal Specific No Remainder Damage Shaped Crafting

Artisanal's specific no remainder damage shaped crafting, a version of shaped [damage inputs crafting](#damage-inputs-crafting) which also complete removes the remainders of the specified slot instead of just damaging it

{: #artisanal-specific-no-remainder-damage-shaped-signature }

### Method Signature

```js-20
event.recipes.artisanal.specific_no_remainder_damage_shaped(
    result: ItemStackProvider,
    pattern: String[],
    key: Map<Character, Ingredient>,
    row: number,
    column: number
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the output of the recipe
- 2nd argument: The pattern for the crafting grid, spaces can be used to indicate an empty slot
- 3rd argument: A `Character` to ingredient map, associates the pattern to ingredients
- 4th argument: A number, the row of the input ingredient to be removed and which the output uses if it is dependent on its inputs
- 5th argument: A number, the column of the input ingredient to be removed and which the output uses if it is dependent on its inputs

{: #artisanal-specific-no-remainder-damage-shaped-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.artisanal.specific_no_remainder_damage_shaped(
        'minecraft:stick',
        [
            'S S',
            ' A ',
            'S S'
        ],
        {
            S: '#tfc:hammers',
            A: 'minecraft:water_bucket'
        },
        1,
        1
    )
})
```

## Artisanal Specific no Remainder Shaped Crafting

Artisanal's specific no remainder shaped crafting recipe type, a version of [advanced shaped crafting](#advanced-shaped-crafting) recipes which removes the remainders of the primary ingredient

{: #artisanal-specific-no-remainder-shaped-signature }

### Method Signature

```js-20
event.recipes.artisanal.specific_no_remainder_shaped(
    result: ItemStackProvider,
    pattern: String[],
    key: Map<Character, Ingredient>,
    row: number,
    column: number
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the output of the recipe
- 2nd argument: The pattern for the crafting grid, spaces can be used to indicate an empty slot
- 3rd argument: A `Character` to ingredient map, associates the pattern to ingredients
- 4th argument: A number, the row of the input ingredient to be removed and which the output uses if it is dependent on its inputs
- 5th argument: A number, the column of the input ingredient to be removed and which the output uses if it is dependent on its inputs

{: #artisanal-specific-no-remainder-shaped-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.artisanal.specific_no_remainder_shaped(
        'minecraft:iron_sword',
        [
            'SA',
            'AS'
        ],
        {
            S: 'minecraft:water_bucket',
            A: 'minecraft:oak_log'
        },
        1,
        1
    )
})
```

## Artisanal Specific No Remainder Shapeless Crafting

Artisanal's specific no remainder shapeless crafting recipe type, a version of [advanced shapeless crafting](#advanced-shapeless-crafting) recipes which removes the remainders of the primary ingredient

{: #artisanal-specific-no-remainder-shapeless-signature }

### Method Signature

```js-20
event.recipes.artisanal.specific_no_remainder_shapeless(
    result: ItemStackProvider,
    ingredients: Ingredient[],
    primaryIngredient?: Ingredient
)
```

- 1st argument: An [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings.md %}#item-stack-provider), the output of the recipe
- 2nd argument: An array of item ingredients, the inputs of the recipe
- *Optional 3rd argument*: An item ingredient, which identifies the which slot of the recipe is used as the 'input' if the output is input-dependent and whose remainder will be discarded on crafting

{: #artisanal-specific0no-remainder-shapeless-example }

### Example

```js-20
ServerEvents.recipes(event => {
    event.recipes.artisanal.specific_no_remainder_shapeless(
        'minecraft:deepslate',
        [
            'minecraft:water_bucket',
            'minecraft:milk_bucket',
            'minecraft:stone'
        ],
        'minecraft:milk_bucket'
    )
})
```
