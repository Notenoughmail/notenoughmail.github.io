---
title: Heat
anchor: heat
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a heat capability definition to items
sig: |-
    heat: {
        ingredient: Ingredient,
        heatCapacity?: number,
        forgingTemperature?: number,
        weldingTemperature?: number
    },
    id?: ResourceLocation
example: |-
    {
        ingredient: 'minecraft:gold_ingot',
        heatCapacity: 0.5
    },
    'kubejs:vanilla_gold'
---

- 1st argument: The heat definition, a map of parameters to values
    - `ingredient: Ingredient`{:.language-kube-21}: The items the heat applies to
    - `heatCapacity: number`{:.language-kube-21}: The heat capacity of the item, a higher values makes the item take longer to heat up
        - [[ def_0 ]]
    - `forgingTemperature?: number`{:.language-kube-21}: The temperature at which the item can be forged[[ fn_temps ]]
        - [[ def_0 ]]
    - `weldingTemperature?: number`{:.language-kube-21}: The temperature at which the item can be welded[[ fn_temps ]]
        - [[ def_0 ]]
- *Optional 2nd argument*: A `ResourceLocation`, the id of the heat definition
