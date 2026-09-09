---
title: Fuel
anchor: fuel
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a fuel for firepits, charcoal forges, etc.
sig: |-
    fuel: {
        ingredient: Ingredient,
        duration?: int,
        temperature?: number,
        purity?: number
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: 'minecraft:poppy',
        duration: 500,
        temperature: 50,
        purity: 0.03
    },
    'kubejs:dirty_poppy'
---

- 1st argument: The fuel definition, a map of parameters to values
    - `ingredient: Ingredient`{:.language-kube-21}: The items the fuel applies to
    - `duration?: int`{:.language-kube-21}: The number of ticks the fuel burns for
        - [[ def_0 ]]
    - `temperature?: number`{:.language-kube-21}: The temperature, in °C, the fuel burns at
        - [[ def_0 ]]
    - `purity?: number`{:.language-kube-21}: The purity of the fuel, effects how much smoke the firepit makes when burning the fuel
        - [[ def_1 ]]
- *Optional 2nd argument*: A `ResourceLocation`, the id of the fuel
