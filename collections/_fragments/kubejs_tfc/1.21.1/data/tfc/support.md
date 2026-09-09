---
title: Support
anchor: support
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a support definition
sig: |-
    support: {
        ingredient: BlockIngredient,
        up?: int,
        down?: int,
        horizontal?: int
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: '#kubejs:wacky_supports',
        up: 6,
        horizontal: 2
    },
    'kubejs:wacky_support'
---

- 1st argument: The support data, a map of parameters to values
    - `ingredient: BlockIngredient`{:.language-kube-21}: A [`BlockIngredient`]([[ bing ]]), the blocks the support applies to
    - `up?: int`{:.language-kube-21}: The number of blocks above the support that are supported
        - [[ def_0 ]]
    - `down?: int`{:.language-kube-21}: The number of blocks below the support that are supported
        - [[ def_0 ]]
    - `horizontal?: int`{:.language-kube-21}: The number of blocks away that are supported
        - [[ def_0 ]]
- *Optional 2nd argument*: A `ResourceLocation`, the id of the support
