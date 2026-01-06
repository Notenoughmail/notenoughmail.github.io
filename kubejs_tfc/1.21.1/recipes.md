---
layout: page
title: Recipes
permalink: /kubejs_tfc/1.21.1/recipes/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Explanations of making TFC's recipe types in scripts
---

# Recipes

The following recipe types are supported by KubeJS TFC

- [Alloy](#alloy)
- [Anvil](#anvil)
- [Instant Barrel](#instant-barrel)
- [Instant Fluid Barrel](#instant-fluid-barrel)
- [Sealed Barrel](#sealed-barrel)
- [Blast Furnace](#blast-furnace)
- [Bloomery](#bloomery)
- [Casting](#casting)
- [Chisel](#chisel)
- [Collapse](#collapse)
- [Glassworking](#glassworking)
- [Heating](#heating)
- [Knapping](#knapping)
- [Landslide](#landslide)
- [Loom](#loom)
- [Pot](#pot)
- [Jam Pot](#jam-pot)
- [Soup Pot](#soup-pot)
- [Quern](#quern)
- [Scraping](#scraping)
- [Sewing](#sewing)
- [Welding](#welding)
- [Advanced Shaped Crafting](#advanced-shaped-crafting)
- [Advanced Shapeless Crafting](#advanced-shapeless-crafting)

<a id="arborfirmacraft"></a> If *ArborFirmaCraft* {% include mr.html link='arborfirmacraft-(afc)' %} {% include cf.html link='arborfirmacraft' %} is installed, the following recipes are supported

- [Tapping](#afc-tapping)

{% capture isp %}[`ItemStackProvider`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#item-stack-provider){% endcapture %}

## Alloy

For alloying metals in a crucible

{: #alloy-signature }

### Method Signature

```js-21
event.recipes.tfc.alloy(
    result: Fluid,
    contents: List<AlloyRange>
)
```

- 1st argument: The resultant fluid
- 2nd argument: A list of alloy ranges, which can be created as a map of parameters to values
    - `fluid: Fluid`{:.language-kube-21}: The component fluid
    - `min: number`{:.language-kube-21}: The minimum fraction, {% in_unit %}, of the total fluid that needs to be this fluid
    - `max: number`{:.language-kube-21}: The maximum fraction, {% in_unit %}, of the total fluid that may be this fluid

{: #alloy-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.alloy(
        'minecraft:lava',
        [
            {
                fluid: 'minecraft:water',
                min: 0.2,
                max: 0.8
            },
            {
                fluid: 'minecraft:milk',
                min: 0.2,
                max: 0.8
            }
        ]
    )
})
```

## Anvil

For working items on an anvil

{: #anvil-signature }

### Method Signature

```js-21
event.recipes.tfc.anvil(
    result: ItemStackProvider,
    ingredient: Ingredient,
    rules: List<ForgeRule>
)
    // Additional methods
    .tier(tier: int)
    .applyBonus(applyBonus?: boolean)
```

- 1st argument: An {{ isp }}, the result of the recipe
- 2nd argument: An item ingredient, the recipe input
- 3rd argument: A list of one to three [`ForgeRule`{:.e}s](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/common/component/forge/ForgeRule.java){:.preserve-color}, the last steps that must be taken.
    {% include enum_list.html summary='Reveal/hide list of valid rules' values='hit_any,hit_not_last,hit_last,hit_second_last,hit_third_last,draw_any,draw_last,draw_not_last,draw_second_last,draw_third_last,punch_any,punch_last,punch_not_last,punch_second_last,punch_third_last,bend_any,bend_last,bend_not_last,bend_second_last,bend_third_last,upset_any,upset_last,upset_not_last,upset_second_last,upset_third_last,shrink_any,shrink_last,shrink_not_last,shrink_second_last,shrink_third_last' %}

<span></span>

- `.tier(tier: int)`{: .language-kube-21 #anvil-tier }: Accepts an integer number and sets the minimum anvil tier the recipe can be performed on, defaults to `0`{:.n}
- `.applyBonus(applyBonus?: boolean)`{: .language-kube-21 #anvil-apply-bonus }: Accepts a boolean and sets if the recipe will apply a forging bonus. Default value is `false`{:.p}, calling with no parameters sets to `true`{;.p}

{: #anvil-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.receipes.tfc.anvil(
        'minecraft:iron_bars',
        'minecraft:iron_nugget',
        [
            'hit_any',
            'upset_not_last'
        ]
    )
    .tier(3)
    .applyBonus()
})
```

## Instant Barrel

For performing item/fluid mixing in barrels instantly

{: #instant-barrel-signature }

### Method Signature

```js-21
event.recipes.tfc.instant_barrel(
    inputFluid: SizedFluidIngredient
)
    // Additional methods
    .outputItem(outputItem: ItemStackProvider)
    .outputFluid(outputFluid: FluidStack)
    .outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)
    .inputItem(inputItem: SizedIngredient)
    .sound(sound: Holder<SoundEvent>)
```

- 1st argument: A sized fluid ingredient, the input fluid

<span></span>

- `.outputItem(outputItem: ItemStackProvider)`{: .language-kube-21 #instant-barrel-output-item }: Accepts an {{ isp }}, the optional item output of the recipe
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-21 #instant-barrel-output_fluid }: Accepts a fluid stack, the optional fluid output of the recipe
- `.outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)`{: .language-kube-21 #instant-barrel-outputs }: Accepts an {{ isp }} and a fluid stack, the optional outputs of the recipe

- `.inputItem(inputItem: SizedIngredient)`{: .language-kube-21 #instant-barrel-input-item }: Accepts a sized item ingredient, the optional item input of the recipe
- `.sound(sound: Holder<SoundEvent>)`{: .language-kube-21 #instant-barrel-sound }: Accepts the id of a sound event[^1], the sound that plays when the recipe performs

[^1]: A list of available sound events can be gotten by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game

{: .related #instant-barrel-alias-notice }
> The recipe method presented here is an alias for the 'official' recipe type, `.tfc.barrel_instant(...)`{:.language-kube-21}. Both may be used in place of the other as they have the same methods and semantics

{: #instant-barrel-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.instant_barrel(
        Fluid.sizedIngredeintOf('minecraft:water', 50)
    )
    .outputs('minecraft:dirt', Fluid.of('minecraft:milk', 1))
})
```

## Instant Fluid Barrel

For performing fluid/fluid mixing in barrels instantly

{: #instant-fluid-barrel-signature }

### Method Signature

```js-21
event.recipes.tfc.instant_fluid_barrel(
    primaryFluid: SizedFluidIngredient,
    addedFluid: SizedFluidIngredient
)
    // Additional methods
    .outputFluid(outputFluid: FluidStack)
    .sound(soud: Holder<SoundEvent>)
```

- 1st argument: A sized fluid ingredient, the fluid in the barrel's tank
- 2nd argument: A sized fluid ingredient, the fluid added to the `priamryFluid`{:.v} by a fluid container item

<span></span>

- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-21 #instant-fluid-barrel-output-fluid }: Accepts a fluid stack, the result of the recipe
- `.sound(sound: Holder<SoundEvent>)`{: .language-kube-21 #instant-fluid-barrel-sound }: Accepts the id of a sound event[^1], the sound that plays when the recipe performs

{: .related #instant-fluid-barrel-alias-notice }
> The recipe method presented here is an alias for the 'official' recipe type, `.tfc.barrel_instant_fluid(...)`{:.language-kube-21}. Both may be used in place of each other as they have the same methods and semantics

{: #instant-fluid-barrel-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.instant_fluid_barrel(
        Fluid.of('minecraft:water', 20),
        Fluid.of('minecraft:milk', 10)
    )
    .outputFluid(Fluid.of('minecraft:lava', 50))
})
```

## Sealed Barrel

For performing fluid/item mixing in sealed barrels

{: #sealed-barrel-signature }

### Method Signature

```js-21
event.recipes.tfc.sealed_barrel(
    inputFluid: SizedFluidIngredient,
    duration: int
)
    // Additional methods
    .outputItem(outputItem: ItemStackProvider)
    .outputFluid(outputFluid: FluidStack)
    .otuputs(outputItem: ItemStackProvider, outputFluid: FluidStack)
    .inputItem(inputItem: SizedIngredient)
    .sound(sound: Holder<SoundEvent>)
    .onSeal(onSeal: ItemStackProvider)
    .onUnseal(onUnseal: ItemStackProvider)
    .seal(onSeal: ItemStackProvider, onUnseal: ItemStackProvider)
```

- 1st argument: A sized fluid ingredient, the fluid input of the recipe
- 2nd argument: An integer number, the sealed duration of the recipe. May be `-1`{:.n} to have an indefinite seal time

<span></span>

- `.outputItem(outputItem: ItemStackProvider)`{: .language-kube-21 #sealed-barrel-output-item }: Accepts an {{ isp }}, the optional item output of the recipe
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-21 #sealed-barrel-output_fluid }: Accepts a fluid stack, the optional fluid output of the recipe
- `.outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)`{: .language-kube-21 #sealed-barrel-outputs }: Accepts an {{ isp }} and a fluid stack, the optional outputs of the recipe

- `.inputItem(inputItem: SizedIngredient)`{: .language-kube-21 #sealed-barrel-input-item }: Accepts a sized item ingredient, the optional item input of the recipe
- `.sound(sound: Holder<SoundEvent>)`{: .language-kube-21 #sealed-barrel-sound }: Accepts the id of a sound event[^1], the sound that plays when the recipe performs
- `.onSeal(onSeal: ItemStackProvider)`{: .language-kube-21 #sealed-barrel-on-seal }: Accepts an {{ isp }}, the provider to apply to the stack when the barrel is sealed
- `.onUnseal(onUnseal: ItemStackProvider)`{: .language-kube-21 #sealed-barrel-on-unseal }: Accepts an {{ isp }}, the provider to apply to the stack when the barrel is unsealed
- `.seal(onSeal: ItemStackProvider, onUnseal: ItemStackProvider)`{: .language-kube-21 #sealed-barrel-seal }: Accepts a pair of {{ isp }}s, the providers to apply to the stack when sealing and unsealing the barrel

{: .related #sealed-barrel-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.barrel_sealed(...)`{:.language-kube-21}. Both may be used in placed of each other as they have the same methods and semantics

{: #sealed-barrel-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.sealed_barrel(
        Fluid.of('minecraft:milk', 100),
        -1
    )
    .inputItem(TFC.ingredeint.notRotten())
    .seal(TFC.isp.copyInputStack().addTrait('kubejs:milk'), TFC.isp.copyInputStack().removeTrait('kubejs:milk'))
})
```

## Blast Furnace

For recipes performed in the blast furnace multiblock

{: #blast-furnace-signature }

### Method Signature

```js-21
event.recipes.tfc.blast_furnace(
    result: FluidStack,
    catalyst: Ingredient,
    fluid: SizedFluidIngredeint
)
```

- 1st argument: A fluid stack, the result of the recipe
- 2nd argument: An item ingredient, the catalyst of the recipe. One required per amount of `fluid`{:.v} ingredient
- 3rd argument: A sized fluid ingredient, the fluid input of the recipe

{: .notice #blast-furnace-fluid-notice }
> While the recipe uses a `SizedFluidIngredient`, the actual blast furnace requires items which [melt](#heating) into the valid fluid(s)

{: #blast-furnace-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.blast_furnace(
        FLuid.of('tfc:metal/copper', 20),
        '#minecraft:flowers',
        Fluid.of('tfc:metal/bismuth', 30)
    )
})
```

## Bloomery

For recipes performed in the bloomery multiblock

{: #bloomery-signature }

### Method Signature

```js-21
event.recipes.tfc.bloomery(
    result: ItemStackProvider,
    catalyst: SizedIngredient,
    fluid: SizedFluidIngredeint,
    duration: int
)
```

- 1st argument: An {{ isp }}, the result of the recipe
- 2nd argument: A sized item ingredient, the catalyst item of the recipe
- 3rd argument: A sized fluid ingredient, the input fluid of the recipe
- 4th argument: An integer number, {% in_range 0,Infinity,) %}, the number of ticks the recipe takes

{: .notice #bloomery-fluid-notice }
> While the recipe uses a `SizedFluidIngredient`, the actual bloomery requires items which [melt](#heating) into the valid fluid(s)

{: #bloomery-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.bloomery(
        'kubejs:unworked_copper_piece',
        Item.of('tfc:powder/flux', 5),
        Fluid.of('tfc:metal/copper', 300),
        10500
    )
})
```

## Casting

For casting into mold items

{: #casting-signature }

### Method Signature

```js-21
event.recipes.tfc.casting(
    result: ItemStackProvider,
    mold: Ingredient,
    fluid: SizedFluidIngredient,
    breakChance?: number
)
```

- 1st argument: An {{ isp }}, the result of the recipe
- 2nd argument: An item ingredient, the mold item to pour the fluid into
- 3rd argument: A sized fluid ingredient, the fluid to cast
- *Optional 4th argument*: A number, {% in_unit %}, the probability the mold will break when extracting the casted object, defaults to `1`{:.n}

{: #casting-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.casting(
        'minecraft:gold_ingot',
        'kubejs:mold',
        Fluid.of('minecraft:lava', 100),
        0.95
    )
})
```

## Chisel

For chiseling blocks in-world using a chisel item

{: #chisel-signature }

### Method Signature

```js-21
event.recipes.tfc.chisel(
    result: BlockState,
    ingredient: BlockIngredient,
    mode: Holder<ChiselMode>,
    itemOutput?: ItemStackProvider
)
    // Additional methods
    .itemOutput(itemOutput: ItemStackProvider)
    .extraDrop(itemOutput: ItemStackProvider)
```

{% capture bing %}[block ingredient]({% link kubejs_tfc/1.21.1/bindings/ingredient.md %}#block-ingredient){% endcapture %}

- 1st argument: A block state, the base result of chiseling, may be tweaked by the `mode`{:.v}
- 2nd argument: A {{ bing }}, the input block(s) of the recipe
- 3rd argument: The id of a chisel mode. A full list of available modes can be seen by running the command `/kubejs dump_registry tfc:chisel_mode`{:.language-command}. Custom modes can be [registered]({% link kubejs_tfc/1.21.1/registry.md %}#chisel-mode) via scripts
- *Optional 4th argument*: An {{ isp }}, an additional item given to the player upon chiseling

<span></span>

- `.itemOutput(itemOutput: ItemStackProvider)`{: .language-kube-21 #chisel-item-output }: Accepts an {{ isp }}, the additional item given to the player upon chiseling
- `.extraDrop(itemOutput: ItemStackProvider)`{: .language-kube-21 #chisel-extra-crop }: An alias of [`.itemOutput(...)`{:.language-kube-21}](#chisel-item-output){:.preserve-color}

{: #chisel-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.chisel(
        'minecraft:oak_log[axis=z]',
        [ 'minecraft:dirt', 'minecraft:oak_planks' ],
        'tfc:smooth'
    )
})
```

## Collapse

For blocks that collapse as a result of unsafe mining practices

{: #collapse-signature }

### Method Signature

```js-21
event.recipes.tfc.collapse(
    result?: BlockState,
    ingredient: BlockIngredient
)
```

- *Optional 1st argument*: A block state, the result of the recipe. If not present, the block collapses to itself
- 2nd argument: A {{ bing }}, the block that will collapse

{: .notice #collapse-tag-notice }
> In order to collapse, a block *must* have the `tfc:can_collapse` tag. Additionally, for blocks that simply collapse to themself, it is sufficient for them to have that tag as TFC has a builtin recipe (which is checked *after* all other collapse recipes) that covers that case
>
> Also be aware of the related `tfc:can_start_collapse` and `tfc:can_trigger_collapse` block tags

{: #collapse-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.collapse(
        'minecraft:gold_block',
        'minecraft:iron_block'
    )
})
```

## Glassworking

For working glass on a blowpipe

{: #glassworking-signature }

### Method Signature

```js-21
event.recipes.tfc.glassworking(
    result: ItemStackProvider,
    batch: Ingredient,
    operations: List<Holder<GlassOperation>>
)
```

- 1st argument: An {{ isp }}, the result of the recipe
- 2nd argument: An item ingredient, the initial batch item added to the blowpipe
- 3rd argument: A list of glass operation ids. A full list of available operations can be seen by running the command `/kubejs dump_registry tfc:glass_operation`{:.language-command} in-game. Custom operations can be [registered]({% link kubejs_tfc/1.21.1/registry.md %}#glass-operation) via scripts

{: #glass-operation-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.glassworking(
        'kubejs:glass_trinket',
        'tfc:silica_glass_batch',
        [
            'tfc:pinch',
            'tfc:gold',
            'tfc:blow',
            'tfc:pyrite'
        ]
    )
})
```

## Heating

For heating items in firepits, crucibles, pit kilns, etc.

{: #heating-signature }

### Method Signature

```js-21
event.recipes.tfc.heating(
    ingredient: Ingredient,
    temperature: number
)
    // Additional methods
    .itemOutput(resultItem: ItemStackProvider)
    .fluidOutput(resultFluid: FluidStack)
    .outputs(resultItem: ItemStackProvider, resultFluid: FluidStack)
    .resultItem(resultItem: ItemStackProvider)
    .fluidResult(fluidResult: FluidStack)
    .results(resultItem: ItemStackProvider, resultFluid: FludiStack)
    .useDurability(useDurability?: boolean)
```

- 1st argument: An item ingredient, the item being heated
- 2nd argument: A number, {% in_range 0,Infinity,) %}, the temperature (°C) the item needs to reach for the recipe to complete

<span></span>

- `.itemOutput(resultItem: ItemStackProvider)`{: .language-kube-21 #heating-item-output }: Accepts an {{ isp }}, the item result of heating
- `.fluidOutput(fluidResult: FluidStack)`{: .language-kube-21 #heating-fluid-output }: Accepts a fluid stack, the fluid result of heating
- `.outputs(resultItem: ItemStackProvider, resultFluid: FluidStack)`{: .language-kube-21 #heating-outputs }: Accepts an {{ isp }} and a fluid stack, the item and fluid results of the recipe
- `.resultItem(resultItem: ItemStackProvider)`{: .language-kube-21 #heating-result-item }: An alias of [`.itemOutput(...)`{;.language-kube-21}](#heating-item-output){:.preserve-color}
- `.resultFluid(resultFluid: FluidStack)`{: .language-kube-21 #heating-result-fluid }: An alias of [`.fluidOutput(...)`{:.language-kube-21}](#heating-fluid-output){:.preserve-color}
- `.results(resultItem: ItemStackProvider, resultFluid: FluidStack)`{: .language-kube-21 #heating-results }: An alias of [`.outputs(...)`](#heating-outputs){:.preserve-color}
- `.useDurability(useDurability?: boolean)`{: .language-kube-21 #heating-use-durability }: Accepts a boolean, if the recipe should scale the fluid output by the input's durability. Defaults to `false`{:.p} and calling with no args will set to `true`{:.p}

{: .notice #heating-heat-notice }
> In order for the recipe to work, the ingredient must have an [item heat]({% link kubejs_tfc/1.21.1/data.md %}#heat)
>
> If the recipe has a fluid result, the fluid must have a matching [fluid heat]({% link kubejs_tfc/1.21.1/data.md %}#fluid-heat) to work with crucibles

{: #heating-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.heating(
        'minecraft:iron_axe',
        1500
    )
    .outputFluid(Fluid.of('tfc:metal/cast_iron', 100))
    .useDurability()
})
```

## Knapping

For knapping recipes, performed by right-clicking the input ingredient in the air and 'shaping' a 5 x 5 grid

{: #knapping-signature }

### Method Signature

```js-21
event.recipes.tfc.knapping(
    result: ItemStack,
    knappingType: ResouceLocation,
    pattern: List<String>
)
    // Additional methods
    .ingredient(ingredient: Ingredient)
    .defaultOn(defaultOn?: boolean)
```

- 1st argument: An item stack, the out put of the recipe
- 2nd argument: A `ResourceLocation`, the id of a [knapping type]({% link kubejs_tfc/1.21.1/data.md %}#knapping-type), the knapping behavior definition
- 3rd argument: A list of strings, the knapping pattern. The list may have between 1 and 5 strings, all rows must have the same length, and each row may be between 1 and 5 characters long. In the pattern, spaces mean the square must be clicked off/deactivated

<span></span>

- `.ingredient(ingredient: Ingredient)`{: .language-kube-21 #knapping-ingredient }: An item ingredient, specifies a specific sub-set of the knapping type's ingredient to use
- `.defaultOn(defaultOn?: boolean)`{: .language-kube-21 #knapping-default-on }: Optionally accepts a boolean, if the values outside of the defined pattern should be active or deactivated to match with non 5 x 5 patterns. Defaults to `false`{:.p}. Sets to `true`{:.p} if no value is passed to the function

{: #knapping-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.knapping(
        'minecraft:obsidian',
        'tfc:clay',
        [
            'X X',
            ' X ',
            'X X'
        ]
    )
})
```

## Landslide

For blocks that landslide automatically due to not being 'supported' by surrounding blocks

{: #landslide-signature }

### Method Signature

```js-21
event.recipes.tfc.landslide(
    result?: BlockState,
    ingredient: BlockIngredient
)
```

- *Optional 1st argument*: A block state, the result of the recipe. If not present, the block landslides to itself
- 2nd argument: A {{ bing }}, the block that will landslide

{: .notice #landslide-tag-notice }
> In order to collapse, a block *must* have the `tfc:can_landslide` tag. Additionally, for blocks that simply landslide to themself, it is sufficient for them to have that tag as TFC has a builtin recipe (which is checked *after* all other collapse recipes) that covers that case

{: #landslide-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.lanslide(
        'minecraft:grass_block',
        'minecraft:dirt'
    )
})
```

## Loom

Recipes performed on the loom

{: #loom-signature }

### Method Signature

```js-21
event.recipes.tfc.loom(
    result: ItemStackProvider,
    ingredient: Ingredient,
    steps: int,
    texture: ResourceLocation
)
```

- 1st argument: An {{ isp }}, the result of the recipe
- 2nd argument: An item ingredient, the recipe input
- 3rd argument: A number, how many times the loom needs to be clicked to finish the recipe
- 4th argument: A `ResourceLocation`, the id of a texture to display on the loom while performing the recipe

{: #loom-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.loom(
        'minecraft:obsidian',
        'minecraft:black_wool',
        20,
        'minecraft:block/black_concrete'
    )
})
```

## Pot

For basic pot recipes

{: #pot-signature }

### Method Signature

```js-21
event.recipes.tfc.pot(
    ingredients: List<Ingredient>,
    fluidIngredient: SizedFluidIngredient,
    duration: int,
    temperature: number
)
    // Additional methods
    .fluidOutput(fluidOutput: FluidStack)
    .itemOutput(itemOutput: List<ItemStackProvider>)
    .outputs(itemOutput: List<ItemStackProvider>, fluidOutput: FluidStack)
    .usesAllFluids(usesAllFluids: boolean)
```

- 1st argument: A list of up to 5 item ingredients, the recipe inputs
- 2nd argument: A sized fluid ingredient, the fluid input of the recipe
- 3rd argument: A non-negative integer number, the number of ticks the pot must be boiling for
- 4th argument: A non-negative number, the temperature (°C) the pot must reach to be boiling

<span></span>

- `.fluidOutput(fluidOutput: FluidStack)`{: .language-kube-21 #pot-fluid-output }: Accepts a fluid stack, the fluid result of the recipe
- `.itemOutput(itemOutput: List<ItemStackProvider>)`{: .language-kube-21 #pot-item-output }: Accepts a list of {{ isp }}s, the item results of the recipe. The given list *must* be the same length as the `ingredients`{:.v} list
- `.outputs(itemOutput: List<ItemStackProvider>, fluidOutput: FluidStack)`{: .language-kube-21 #pot-outputs }: Accepts a list of {{ isp }}s and a fluid stack
- `.usesAllFluids(usesAllFluids: boolean)`{: .language-kube-21 #pot-uses-all-fluids }: Accepts a boolean, if the entirety of the fluid in the pot should be used. Defaults to `true`{:.p}

{: #pot-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.pot(
        [ '#minecraft:flowers' ],
        Fluid.water(1000),
        50,
        110
    )
    .outputs('minecraft:bread', Fluid.of('minecraft:milk', 20))
})
```

## Jam Pot

For pot recipes that require the pot to be clicked with empty jars and items tagged `tfc:foods/empty_jars_with_lid` to get their outputs

{: #jam-pot-signature }

### Method Signature

```js-21
event.recipes.tfc.jam_pot(
    unsealedResult: ItemStack,
    sealedResult: ItemStack,
    ingredients: List<Ingredient>,
    fluidIngredient: SizedFluidIngredient,
    duration: int,
    temperature: number,
    texture: ResourceLocation
)
```

- 1st argument: An item stack, the stack to give the player when they click the pot with an empty jar after the recipe completes
- 2nd argument: A item stack, the stack to give the player when they click the pot with an item tagged `tfc:foods/empty_jars_with_lid` after the recipe completes
- 3rd argument: A list of up to 5 item ingredients, the item inputs of the recipe
- 4th argument: A sized fluid ingredient, the fluid input of the recipe
- 5th argument: A non-negative integer number, the number of ticks the pot must be boiling for
- 6th argument: A non-negative number, the temperature (°C) the pot must reach to be boiling
- 7th argument: A `ResourceLocation`, the id of a texture to display in the pot after completion of the recipe

{: .notice #jam-pot-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.pot_jam(...)`{:.language-kube-21}. Both may be used in placed of each other as they have the same semantics

{: #jam-pot-example }

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.jam_pot(
        'minecraft:red_wool',
        'minecraft:red_concrete',
        [
            'minecraft:red_concrete_powder'
        ],
        Fluid.water(100),
        1,
        50,
        'minecraft:block/green_wool'
    )
})
```

## Soup Pot

For pot recipes which require the pot to be clicked with items tagged `tfc:soup_bowls` to get an output

{: #soup-pot-signature }

### Method Signature

```js-21
event.recipes.tfc.soup_pot(
    ingredients: List<Ingredient>,
    fluidIngredient: SizedFluidIngredient,
    duration: int,
    temperature: number
)
```

- 1st argument: A list of up to 5 item ingredients, the item inputs of the recipe
- 2nd argument: A sized fluid ingredient, the fluid input of the recipe
- 3rd argument: A non-negative integer number, the number of ticks the pot must be boiling for
- 4th argument: A non-negative number, the temperature (°C) the pot must reach to start boiling

{: .related #soup-pot-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.pot_soup(...)`{:.language-kube-21}. Both may be used in placed of each other as they have the same semantics

{: #soup-pot-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.soup_pot(
        [
            'minecraft:wheat'
        ],
        Fluid.water(20),
        2,
        94
    )
})
```

## Quern

For grinding recipes in the quern

{: #quern-signature }

### Method Signature

```js-21
event.recipes.tfc.quern(
    result: ItemStackProvider,
    ingredient: Ingredient
)
```

- 1st argument: An {{ isp }}, the result of the recipe
- 2nd argument: An item ingredient, the recipe input

{: #quern-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.quern(
        TFC.isp.of('tfc:metal/ingot/copper')
            .addHeat(500),
        'tfc:metal/ingot/bismuth'
    )
})
```

## Scraping

For scraping items on the open face of a log with a knife

{: #scraping-signature }

### Method Signature

```js-21
event.recipes.tfc.scraping(
    result: ItemStackProvider,
    ingredient: Ingredient,
    outputTexture: ResourceLocation,
    inputTexture: ResouceLocation,
    resultItem?: ItemStackProvider
)
    // Additional methods
    .resultItem(resultItem: ItemStackProvider)
    .extraDrop(resultItem: ItemStackProvider)
```

- 1st argument: An {{ isp }}, the primary result of the recipe
- 2nd argument: An item ingredient, the item that will be scraped
- 3rd argument: A texture id, the texture to show in spots that have been scraped
- 4th argument: A texture id, the texture to shoe in spots that have not been scraped
- *Optional 5th argument*: An {{ isp }}, an additional item to drop upon completion of the recipe

<span></span>

- `.resultItem(resultItem: ItemStackProvider)`{: .language-kube-21 #scraping-result-item }: Accepts an {{ isp }}, the additional item to drop upon completion of the recipe
- `.extraDrop(resultItem: ItemStackProvider)`{: .language-kube-21 #scraping-extra-drop }: A simple alias to [`.resultItem(...)`{:.language-kube-21}](#scraping-result-item){:.preserve-color} meant to disambiguate `resultItem`{:.v} from `result`{:.v}

## Sewing

For sewing items in a sewing table

{: #sewing-signature }

### Method Signature

```js-21
event.recipes.tfc.sewing(
    result: ItemStack,
    stitches: List<String>,
    squares: List<String>
)
```

- 1st argument: An item stack, the result of the recipe
- 2nd argument: A list of strings, the stitch pattern in the sewing table. The list must have 5 values, each 9 characters long. A space character indicates no stitch at that position
- 3rd argument: A list of strings, the fabric square pattern in the sewing table. The list must have 4 values, each 8 characters long. Acceptable characters are ` `, `B`, and `W` for empty, burlap, and wool respectively

{: #sewing-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.sewing(
        'minecraft:cobblestone',
        [
            '## ### ##',
            '# #   # #',
            ' # ### # ',
            '# #   # #',
            '## ### ##'
        ],
        [
            ' BBWWBB ',
            'BBW  WBB',
            'W  BB  W',
            '  WBBW  '
        ]
    )
})
```

## Welding

For welding items on an anvil

{: #welding-signature }

### Method Signature

```js-21
event.recipes.tfc.welding(
    result: ItemStackProvider,
    firstInput: Ingredient,
    secondInput: Ingredient
)
    // Additional methods
    .tier(tier: int)
    .bonusBehavior(bonus: BonusBehavior)
```

- 1st argument: An {{ isp }}, the result of the recipe
- 2nd argument: An item ingredient, one of the items welded
- 3rd argument: An item ingredient, one of the items welded

<span></span>

- `.tier(tier: int)`{: .language-kube-21 #welding-tier }: Accepts a number and sets the minimum anvil tier required to perform the recipe, defaults to `0`{:.n}
- `.bonusBehavior(bonus: BonusBehavior)`{: .language-kube-21 #welding-bonus-behavior }: Sets the behavior for copying forging bonuses from the inputs. Accepts a `BonusBehavior`{:.e}, of which there are three
    - `copy_best`{:.e}: Copy the best forging bonus of the inputs
    - `copy_worst`{:.e}: Copy the worst forging bonus of the inputs
    - `ignore`{:.e}: Do not apply any bonus to the output, the default value

{: #welding-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.welding(
        'minecraft:obsidian',
        'minecraft:water_bucket',
        'minecraft:lava_bucket'
    )
    .tier(4)
})
```

## Advanced Shaped Crafting

For shaped crafting recipes which have an {{ isp }} result

{: #shaped-signature }

### Method Signature

```js-21
event.recipes.tfc.shaped(
    result: ItemStackProvider,
    pattern: List<String>,
    key: Map<char, Ingredient>
)
    // Additional methods
    .remainder(remainder: ItemStackProvider)
    .showNotification(showNotification: boolean)
    .inputRow(inputRow: int)
    .inputColumn(inputColumn: int)
    .inputPosition(inputRow: int, inputColumn: int)
    .noNotification()
```

- 1st argument: An {{ isp }}, the recipe result
- 2nd argument: A list of string, the recipe pattern
- 3rd argument: A `char`{:.p} to ingredient map, specifying the ingredients in the pattern

<span></span>

- `.remainder(remainder: ItemStackProvider)`{: .language-kube-21 #shaped-remainder }: Accepts an {{ isp }}, the provider to apply to all inputs with the same item as the primary input
- `.showNotification(showNotification: boolean)`{: .language-kube-21 #shaped-show-notification }: If the player should receive a toast when they unlock the recipe. Defaults to `true`{:.p}
- `.inputRow(inputRow: int)`{: .language-kube-21 #shaped-input-row }: Accepts a non-negative integer number, the row index the primary ingredient is located. Defaults to `0`{:.n}
- `.inputColumn(inputColumn: int)`{: .language-kube-21 #shaped-input-column }: Accepts a non-negative integer number, the column index the primary ingredient is located. Defaults to `0`{:.n}
- `.inputPosition(inputRow: int, inputColumn: int)`{: .language-kube-21 #shaped-input-position }: Accepts two non-negative integer numbers, the row and column index of the primary ingredient
- `.noNotification()`{: .language-kube-21 #shaped-no-notification }: Disables the player receiving a toast about unlocking the recipe

{: .related #shaped-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.advanced_shaped_crafting(...)`{:.language-kube-21}. Both may be used in placed of each other as they have the same methods and semantics

{: #shaped-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.shaped(
        'minecraft:obsidian',
        [
            'SA'
        ],
        {
            S: 'minecraft:lava_bucket',
            A: 'minecraft:water_bucket'
        }
    )
    .remainder(TFC.isp.empty())
})
```

## Advanced Shapeless Crafting

For shapeless crafting recipes which have an {{ isp }} result

{: #shapeless-signature }

### Method Signature

```js-21
event.recipes.tfc.shapeless(
    result: ItemStackProvider,
    ingredients: List<Ingredient>,
    primaryIngredient: Ingredient,
    remainder?: ItemStackProvider
)
```

- 1st argument: An {{ isp }}, the recipe result
- 2nd argument: A list of item ingredients, the recipe inputs. May not be empty
- 3rd argument: An item ingredient, the primary ingredient of the recipe
- *Optional 4th argument*: An {{ isp }}, the provider to apply to all inputs with the same item as the primary input

{: .related #shapeless-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.advanced_shapeless_crafting(...)`{:.language-kube-21}. Both may be used in placed of each other as they have the same semantics

{: #shapeless-example }

### Example

```js-21
ServerEvents.recipes(event => {
    event.recipes.tfc.shapeless(
        'minecraft:blue_glazed_terracotta',
        [
            'minecraft:blue_concrete',
            TFC.ingredient.fluidContents(Fluid.lava(50))
        ],
        TFC.ingredient.fluidContents(Fluid.lava(50)),
        TFC.isp.copyInputStack().addHeat(500)
    )
})
```

## AFC Tapping

For tapping trees for fluid

{: #afc-tapping-signature }

### Method Signature

```js-21
event.recipes.afc.tree_tapping(
    resultFluid: FluidStack,
    inputBlock: BlockIngredient
)
    // Additional methods
    .requiresNaturalLog(requiresNaturalLog: boolean)
    .springOnly(springOnly?: boolean)
    .minTemp(minimumTemperature: number)
    .maxTemp(maximumTemperature: number)
    .tempRange(minimumTemperature: number, maximumtemperature: number)
```

- 1st argument: A fluid stack, the result of the recipe
- 2nd argument: A {{ bing }}, the block being tapped

<span></span>

- `.requiresNaturalLog(requiresNaturalLog: boolean)`{: .language-kube-21 #afc-tapping-requires-natural-log }: Accepts a boolean, if the block being tapped must have TFC's `branch_direction` block state and its value is not `none`{:.e}. Defaults to `true`{:.p}
- `.springOnly(springOnly?: boolean)`{: .language-kube-21 #afc-tapping-spring-only }: Accepts a boolean, if the recipe may only be completed in the spring. Defaults to `false`{:.p}. Sets to `true`{:.p} if no value is passed to the function
- `.minTemp(minimumTemperature: number)`{: .language-kube-21 #afc-tapping-min-temp }: Accepts a number, the minimum temperature (°C) the recipe can be performed in
- `.maxTemp(maximumTemperature: number)`{: .language-kube-21 #afc-tapping-max-temp }: Accepts a number, the maximum temperature (°C) the recipe can be performed in
- `.tempRange(minimumTemperature: number, maximumTemperature: number)`{: .language-kube-21 #afc-tapping-temp-range }: Accepts two numbers, the minimum and maximum temperature (°C) the recipe can be performed in

{% comment %}

### chisel item output

### heating item output

### heating fluid output

### heating outputs

### scraping result item

{% endcomment %}
