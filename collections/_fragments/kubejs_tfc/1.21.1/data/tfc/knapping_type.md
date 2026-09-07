---
title: Knapping Type
anchor: knapping-type
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a new knapping type for use in [knapping recipes]({% link kubejs_tfc/1.21.1/recipes.md %}#knapping)
method: knappingType
sig: |-
    knappingType: {
        inputItem: SizedIngredient,
        clickSound: Holder<SoundEvent>,
        icon: ItemStack,
        amountToConsume?: int,
        consumeAfterComplete?: boolean,
        hasOffTexture?: boolean,
        spansParticles?: boolean
    },
    id: ResourceLocation
example: |-
    {
        inputItem: Ingredient.of('minecraft:flint', 5),
        amountToConsume: 2,
        clickSound: 'minecraft:entity.warden.roar',
        icon: 'minecraft:flint',
        spawnsParticles: true
    },
    'kubejs:flint'
---

- 1st argument: The knapping type definition, a map of parameters to values
    - `inputItem: SizedIngredient`{:.language-kube-21}: The input for the knapping type
    - `clickSound: Holder<SoundEvent>`{:.language-kube-21}: The sound to play when knapping[[ fn_sound ]]
    - `icon: ItemStack`{:.language-kube-21}: The item to use as the category icon in recipe viewers
    - `amountToConsume?: int`{:.language-kube-21}: How many items of input to consume when performing a recipe
        - Defaults to the count of `inputItem`{:.v}
    - `consumeAfterComplete?: boolean`{:.language-kube-21}: If the input items should only be consumed after the recipe completes
        - Defaults to `false`{:.p}
    - `hasOffTexture?: boolean`{:.language-kube-21}: If the knapping screen should display a second texture for tiles that are off
        - Defaults to `false`{:.p}
    - `spawnsParticles?: boolean`{:.language-kube-21}: If knapping particles should spawn when clicking a knapping tile
        - Defaults to `false`{:.p}
- 2nd argument: A `ResourceLocation`, the id of the knapping type which knapping recipes reference
