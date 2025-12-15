---
layout: page
title: Miscellaneous Features
permalink: /kubejs_tfc/1.20.1/misc/
parent: 1.20.1
grand_parent: KubeJS TFC
desc: Documentation of KubeJS TFC features which don't fit in another page
---

# Miscellaneous Features

This page is for features which don't deserve their own page and/or don't fit into another page

- [Configuration](#configuration)
- [Recipe Components](#recipe-components)
- [Recipe Input/Output Replacement](#recipe-replacement)
- [Recipe Filters](#recipe-filters)

## Configuration

In KubeJS's `dev.properties` file there is an option for `debugInfo`, if set to `true`{:.p}, KubeJS TFC will print various debug info to the log

Also in the `dev.properties` file

- `tfc/insertSelfTestsIntoConsole`: If `true`{:.p}, TFC's self test warnings will be inserted into the KubeJS console. Allows for warnings about items/fluids missing tags for proper recipe functionality to appear on world load. Defaults to `true`{:.p}.
- `tfc/deduplicateConsoleErrors`: If `true`{:.p}, any TFC self test warnings that are inserted into Kube's console will *not* be written to the normal log/console. Only has an effect when `tfc/insertSelfTestsIntoConsole` is `true`{:.p}. Defaults to `true`{:.p}.

## Recipe Components

KubeJS handles recipes through *recipe schemas*, which are made up of *recipe components*, essentially a mirror to a recipe type's json (de)serialization process. For the most part recipe schemas are made through addons, but KubeJS does have a startup event for registering custom recipe schemas in your scripts.

{: .notice }
This is *not* meant to be a tutorial on how to use that event, merely an acknowledgement of the recipe components KubeJS TFC adds for use in that event

### Provided Components

KubeJS TFC adds 6 recipe component types

- `tfc:outputItemStackProvider`: An output [ItemProviderComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/ItemProviderComponent.java), used by recipes which support [ISP]({% link kubejs_tfc/1.20.1/bindings/isp.md %}) outputs
- `tfc:otherItemStackProvider`: An [ItemProviderComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/ItemProviderComponent.java), used by recipes which support [ISP]({% link kubejs_tfc/1.20.1/bindings/isp.md %}) intermediates
- `tfc:fluidIngredient`: A [FluidIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/FluidIngredientComponent.java), used by recipes which support [fluid ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-ingredient)
- `tfc:fluidStackIngredient`: A [FluidStackIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/FluidIngredientComponent.java), used by recipes which support [fluid stack ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)
- `tfc:alloyPart`: An [AlloyPartComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/AlloyPartComponent.java), used by alloy recipes for their [alloy parts]({% link kubejs_tfc/1.20.1/bindings.md %}#alloy-part)
- `tfc:blockIngredient`: A [BlockIngredientComponent](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/recipe/component/BlockIngredientComponent.java), used by recipes which support [block ingredients]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient)

## Recipe Replacement

KubejS TFC's [recipe components](#recipe-components) can be replaced via `.replaceInput()`{: .language-kube-20 } and `.replaceOutput()`{: .language-kube-20 } as appropriate

{: #recipe-replacement-alloy-part }

### AlloyPart

[`AlloyPart`]({% link kubejs_tfc/1.20.1/bindings.md %}#alloy-part)s can be replaced wit the `.replaceInput()`{: .language-kube-20 } method on recipes with an `AlloyPart` as the replacement match and another `AlloyPart` as the input replacement. If the `AlloyPart` used as the input replacement has `keepOriginalBounds`{:.v} as `false`{:.p}, then the bounds will also be changed, instead of just the metal

Example:

```js-20
ServerEvents.recipes(event => {
    let recipe = event.recipes.tfc.alloy(
        'tfc:copper',
        [
            TFC.alloyPart('tfc:rose_gold', 0.2, 0.3),
            TFC.alloyPart('tfc:steel', 0.1, 0.4)
        ]
    )

    recipe.replaceInput(TFC.alloyPart('tfc:rose_gold', 0, 0), TFC.alloyPart('red_steel', 0, 0))
    recipe.repalceInput(TFC.alloyPart('tfc:steel', 0, 0), TFC.alloyPart('tfc:rose_gold', 0.7, 0.8, false))
})
```

{: #recipe-replacement-block-ingredient }

### BlockIngredient

[`BlockIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient)s can replaced with the `.replaceInput()`{: .language-kube-20 } method on recipes with a `BlockStatePredicate` as the replacement match and another block ingredient as the input replacement

Example:

```js-20
ServerEvents.recipes(event => {
    let recipe = event.recipes.tfc.landslide(
        'minecraft:deepslate'
    )

    recipe.replaceInput(BlockStatePredicate.of('minecraft:deepslate', TFC.blockIngredient(['minecraft:hay_block', 'minecraft:end_gateway'])))
})
```

{: #recipe-replacement-fluid-stack-ingredient }

### FluidStackIngredient

[`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient)s can be replaced with the `.replaceInput()`{: .language-kube-20 } method on recipes with a fluid stack as the replacement match and another FSI as the input replacement

Example:

```js-20
ServerEvents.recipes(event => {
    let recipe = event.recipes.tfc.instant_barrel()
        .outputItem('tfc:food/green_item')
        .inputFluid(Fluid.of('minecraft:water', 500))

    recipe.replaceInput(Fluid.of('minecraft:water', 50), TFC.fluidStackIngredient(['minecraft:water', 'minecraft:milk', 'minecraft:lava'], 500))
})
```

{: #recipe-replacement-item-stack-provider }

### ItemStackProvider

[`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings/isp.md %})s cane be replaced with the `.replaceOutput()`{: .language-kube-20 } method in recipes with either an item or an ISP as the replacement match and an ISP as the input replacement. If an ISP is used as the replacement match, the only ISPs which have all of the modifiers the one used as the match has will match. Additionally, ISPs that have no stack and are used as the replacement match will match any ISP with the correct modifiers, regardless of what item it has

Examples:

```js-20
ServerEvents.recipes(event => {
    let recipe = event.recipes.tfc.quern(
        'minecraft:dirt',
        'minecraft:stone'
    )

    recipe.replaceOutput('minecraft:dirt', TFC.isp.of('tfc:food/cooked_pork').addheat(500))

    recipe = event.recipes.tfc.quern(
        TFC.isp.of('minecraft:white_wool').addHeat(500),
        'minecraft:stone'
    )

    recipe.replaceOutput(TFC.isp.empty().addHeat(0), TFC.isp('minecraft:gravel').copyHeat())
})
```

## Recipe Filters

KubeJS TFC adds several types of recipe filters for use with its [recipe components](#recipe-components). They can be used by passing an object with a `tfc` key with an object value which itself has a `type` key. The different types are:

- [Is TFC](#recipe-filters-is-tfc)
- [Has ISPs](#recipe-filters-has-isp)
- [Block Ingredient](#recipe-filters-block-ingredient)
- [Fluid Ingredient](#recipe-filters-fluid-stack-ingredient)
- [Alloy Contents](#recipe-filters-allot-contents)
- [Alloy Result](#recipe-filters-alloy-result)
- [ItemStackProvider](#recipe-filters-item-stack-provider)

Additionally, these filters can be ANDed together by including them in an array under the `tfc` key

{: #recipe-filters-is-tfc }

### Is TFC

This filter checks if the recipe is 'TFC-like', or support is handled by KubeJS TFC

**Type**: `is_tfc`

Example:

```js-20
ServerEVents.recieps(event => {
    event.forEachRecipe(
        {
            tfc: {
                type: 'is_tfc'
            }
        },
        r => console.log(r)
    )
})
```

{: #recipe-filters-has-isp }

### Has ISPs

This filter checks if the recipe has any [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings/isp.md %}) arguments

**Type**: `has_isp`

Example:

```js-20
ServerEvents.recipes(event => {
    event.forEachRecipe(
        {
            tfc: {
                type: 'has_isp'
            }
        },
        r => console.log(r)
    )
})
```

{: #recipe-filters-block-ingredient }

### Block Ingredient

This filter checks if the recipe has a [`BlockIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#block-ingredient) that matches the provided block

**Type**: `block`

Definition:

- `block: Block`{: .language-kube-20 }: The block to check `BlockIngredient`s for

Example:

```js-20
ServerEvents.recipes(event => {
    event.forEachRecipe(
        {
            tfc: {
                type: 'block',
                block: 'tfc:rock/raw/dolomite'
            }
        },
        r => console.log(r)
    )
})
```

{: #recipe-filters-fluid-stack-ingredient }

### Fluid Stack Ingredient

This filter checks if the recipe has a [`FluidStackIngredient`]({% link kubejs_tfc/1.20.1/bindings.md %}#fluid-stack-ingredient) that matches the given `FluidStack`

**Type**: `fluid_stack`

Definition:

- `fluid: FluidStack`{: .language-kube-20 }: The fluid stack to check against the `FluidStackIngreient`. Matches will only be made if the ingredient has an amount greater-than or equal to the fluid stack

Example:

```js-20
ServerEvents.recipes(event => {
    event.forEachRecipe(
        {
            tfc: {
                type: 'fluid_stack',
                fluid: Fluid.of('minecraft:water', 20)
            }
        },
        r => console.log(r)
    )
})
```

{: #recipe-filters-alloy-contents }

### Alloy Contents

This filter checks if the recipe has an [`AlloyPart`]({% link kubejs_tfc/1.20.1/bindings.md %}#alloy-part) that with the given metal

**Type**: `alloy_contents`

Definition:

- `contents: String`{: .language-kube-20 }: The metal to match against

Example:

```js-20
ServerEvents.recipes(event => {
    event.forEachRecipe(
        {
            tfc: {
                type: 'alloy_contents',
                contents: 'tfc:copper'
            }
        },
        r => console.log(r)
    )
})
```

{: #recipe-filters-alloy-result }

### Alloy Result

This filter checks if the recipe has an alloy result of the given metal

**Type**: `alloy_result`

Definition:

- `result: String`{: .language-kube-20 }: The metal to match against

Example:

```js-20
ServerEvents.recipes(event => {
    event.forEachRecipe(
        {
            tfc: {
                type: 'alloy_result',
                result: 'tfc:rose_gold'
            }
        },
        r => console.log(r)
    )
})
```

{: #recipe-filters-item-stack-provider }

### ItemStackProvider

This filter checks if the recipe has an [`ItemStackProvider`]({% link kubejs_tfc/1.20.1/bindings/isp.md %}) with the given item or modifiers

**Type**: `isp`

Definition:

- `output?: boolean`{: .language-kube-20 }: A boolean, if false checks intermediate ISPs instead of output ISPs. Optional, defaults to `true`{:.p}
- `match?: ItemMatch`{: .language-kube-20 }: An item match, checks the item of the ISP. Optional, if not present does not check the ISP item
- `modifiers?: (List<String> | String)`{: .language-kube-20 }: A list of item stack modifier types, the ISP must have all of these modifiers to match. Optional

Examples:

```js-20
ServerEvents.recipes(event => {
    event.forEachRecipe(
        {
            tfc: {
                type: 'isp',
                modiifers: 'tfc:copy_input'
            }
        },
        r => console.log(r)
    )
    event.forEachRecipe(
        {
            tfc: {
                type: 'isp',
                match: 'tfc:food/cooked_pork',
                modifiers: [
                    'tfc:add_heat',
                    'tfc:add_trait'
                ]
            }
        },
        r => console.log(r)
    )
})
```

{% comment %}

#### recipe filters is tfc

#### recipe-filters has isp

#### recipe filters block ingredient

#### recipe filters fluid stack ingredient

#### recipe filters allot contents

#### recipe filters alloy result

#### recipe filters item stack provider

{% endcomment %}
