---
title: Item Damage Resistance
anchor: item-damage-resistance
cat:
    - kubejs_tfc
    - 1.21.1
    - data
desc: Add an item damage resistance
method: itemDamageResistance
sig: |-
    ingredient: Ingredient,
    resistance: {
        piercing?: number,
        slashing?: number,
        crushing?: number
    },
    id?: ResourceLocation
example: |-
    '#kubejs:weak_to_slashing',
    {
        slashing: -30,
        piercing: -2,
        crushing: 5
    }
---

- 1st argument: An ingredient, the items the resistance applies to
- 2nd argument: The resistance data, a map of types to values
    - `piercing?: number`{:.language-kube-21}: The piercing resistance
        - Negative values make the item extra vulnerable to piercing damage
        - [[ def_0 ]]
    - `slashing?: number`{:.language-kube-21}: The slashing resistance
        - Negative values make the item extra vulnerable to slashing damage
        - [[ def_0 ]]
    - `crushing?: number`{:.language-kube-21}: The crushing resistance
        - Negative values make the item extra vulnerable to crushing damage
        - [[ def_0 ]]
- *Optional 3rd argument*: A `ResourceLocation`{:.language-kube-21}, the id of the resistance
