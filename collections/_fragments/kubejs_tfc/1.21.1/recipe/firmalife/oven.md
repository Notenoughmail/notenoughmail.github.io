---
title: Oven
anchor: firmalife-oven
func: oven
mod: firmalife
group: o
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For cooking items in an oven
example: |-
    'minecraft:spruce_log',
    'minecraft:oak_log',
    3,
    3
sig: |-
    result: ItemStackProvider,
    ingredient: Ingredient,
    temperature: number,
    duration: int
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: An item ingredient, the recipe input
- 3rd argument: A number, the temperature (°C) the oven must reach to start baking
- 4th argument: A number {% in_range 1,,) %}, the number of ticks the oven must be baking for
