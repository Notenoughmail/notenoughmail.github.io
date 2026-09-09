---
title: Nether Fertilizer
anchor: nether-fertilizer
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a nether fertilizer definition
mod: beneath
group: BeneathEvents
method: netherFertilizer
sig: |-
    fertilizer: {
        ingredient: Ingredient,
        death?: number,
        destruction?: number,
        decay?: number,
        sorrow?: number
        flame?: number
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: '#minecraft:dirt',
        death: 5,
        flame: 1.2
    }
---

- 1st argument: The nether fertilizer data, a map of parameters to values
    - `ingredient: Ingredient`{:.language-kube-21}: The ingredient the fertilizer applies to
    - `death?: number`{:.language-kube-21}: the `death` value of the fertilizer
        - [[ unit ]]
        - [[ def_0 ]]
    - `destruction?: number`{:.language-kube-21}: The `destruction` value of the fertilizer
        - [[ unit ]]
        - [[ def_0 ]]
    - `decay?: number`{:.language-kube-21}: The `decay` value of the fertilizer
        - [[ unit ]]
        - [[ def_0 ]]
    - `sorrow?: number`{:.language-kube-21}: The `sorrow` value of the fertilizer
        - [[ unit ]]
        - [[ def_0 ]]
    - `flame?: number`{:.language-kube-21}: The `flame` value of the fertilizer
        - [[ unit ]]
        - [[ def_0 ]]
- *Optional 2nd argument*: A `ResourceLocation`, the id of the nether fertilizer
