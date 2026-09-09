---
title: Lamp Fuel
anchor: lamp-fuel
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add a new lamp fuel
method: lampFuel
sig: |-
    lampFuel: {
        fluid: FluidIngredient,
        lamps: BlockIngredient,
        burnRate: int
    },
    id?: ResourceLocation
example: |-
    {
        fluid: 'minecraft:milk',
        lamps: [
            'tfc:metal/lamp/blue_steel',
            'tfc:metal/lamp/bronze'
        ],
        burnRate: 6
    }
---

- 1st argument: The lamp fuel data, a map of parameters to values
    - `fluid: FluidIngredient`{:.language-kube-21}: The fluids the fuel applies to
    - `lamps: BlockIngredient`{:.language-kube-21}: The [blocks]([[ bing ]]) the fuel is valid for
    - `burnRate: int`{:.language-kube-21}: The burn rate, in ticks / mB, of the fuel
- *Optional 2nd argument*: A `ResourceLocation`, the id of the fuel
