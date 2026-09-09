---
title: Stinky Soup
anchor: firmalife-stinky-soup
func: stinky_soup
mod: firmalife
group: s
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For [soup](#soup-pot) recipes that produce a foul soup
example: |-
    [ '#minecraft:flowers' ],
    Fluid.of('minecraft:water', 50),
    5,
    5
sig: |-
    ingredients: List<Ingredient>,
    fluidIngredient: SizedFluidIngredient,
    duration: int,
    temperature: number
---

- 1st argument: A list of up to 5 item ingredients, the item inputs of the recipe
- 2nd argument: A sized fluid ingredient, the fluid input of the recipe
- 3rd argument: A non-negative integer number, the number of ticks the pot must be boiling for
- 4th argument: A non-negative number, the temperature (°C) the pot must reach to start boiling
