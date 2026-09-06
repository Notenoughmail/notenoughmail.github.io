---
title: Fertilizer
anchor: fertilizer
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a fertilizer definition
sig: |-
    fertilizer: {
        ingredient: Ingredient,
        nitrogen?: number,
        phosphorus?: number,
        potassium?: number
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: 'minecraft:bone_block',
        potassium: 0.2,
        phosphorous: 0.07
    },
    'kubejs:bone'
---

- 1st argument: The fertilizer data, a map of parameters to values
    - `ingredient: Ingredient`{:.language-kube-21}: The ingredient the fertilizer values apply to
    - `nitrogen?: number`{:.language-kube-21}: The nitrogen amount
        - [[ unit ]]
        - [[ def_0 ]]
    - `phosphorus?: number`{:.language-kube-21}: The phosphorus amount
        - [[ unit ]]
        - [[ def_0 ]]
    - `potassium?: number`{:.language-kube-21}: The potassium amount
        - [[ unit ]]
        - [[ def_0 ]]
- *Optional 2nd argument*: A `ResourceLocation`, the id of the fertilizer
