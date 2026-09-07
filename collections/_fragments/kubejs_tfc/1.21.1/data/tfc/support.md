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
        supportUp?: int,
        supportDown?: int,
        supportHorizontal?: int
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: '#kubejs:wacky_supports',
        supportUp: 6,
        supportHorizontal: 2
    },
    'kubejs:wacky_support'
---

- 1st argument: The support data, a map of parameters to values
    - `ingredient: BlockIngredient`{:.language-kube-21}: A [`BlockIngredient`]([[ bing ]]), the blocks the support applies to
    - `supportUp?: int`{:.language-kube-21}: The number of blocks above the support that are supported
        - [[ def_0 ]]
    - `supportDown?: int`{:.language-kube-21}: The number of blocks below the support that are supported
        - [[ def_0 ]]
    - `supportHorizontal?: int`{:.language-kube-21}: The number of blocks away that are supported
        - [[ def_0 ]]
- *Optional 2nd argument*: A `ResourceLocation`, the id of the support
