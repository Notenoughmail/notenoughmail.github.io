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

## Instant Fluid Barrel

## Sealed Barrel

## Blast Furnace

## Bloomery

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
- 3rd argument: A `SizedFluidIngredient`, the fluid to cast
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

## Collapse

## Glassworking

## Heating

## Knapping

## Landslide

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

## Jam Pot

## Soup Pot

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

## Sewing

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

## Advanced Shapeless Crafting

## AFC Tapping
