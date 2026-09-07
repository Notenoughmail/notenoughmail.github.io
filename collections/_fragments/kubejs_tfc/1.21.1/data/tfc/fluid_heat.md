---
title: Fluid Heat
anchor: fluid-heat
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a fluid heat, required for [heating recipes]({% link kubejs_tfc/1.21.1/recipes.md %}#heating) to work with a fluid
method: fluidHeat
sig: |-
    fluidHeat: {
        fluid: Fluid,
        meltTemperature: number,
        specificHeatCapacity: number
    },
    id?: ResourceLocation
example: |-
    {
        fluid: 'minecraft:lava', // Here, the id of the heat would be 'kubejs:minecraft/lava'
        meltTemperature: 1550,
        specificHeatCapacity: 0.023
    }
---

- 1st argument: The fluid heat data, a map of parameters to values
    - `fluid: Fluid`{:.language-kube-21}: The fluid the heat applies to
    - `meltTemperature: number`{:.language-kube-21}: The temperature, in °C
    - `specificHeatCapacity: number`{:.language-kube-21}: The specific heat capacity of the metal, in `units of Energy / (°C * mB)`
- *Optional 2nd argument*: A `ResourceLocation`, the id of the fluid heat

{: .notice #{{ page.anchor }}-id-notice }
> If no id is specified, the namespace will be `kubejs` and the path will be the of the fluid with a slash between its namespace and path
