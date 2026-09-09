---
title: Bowl Pot
anchor: firmalife-bowl-pot
func: bowl_pot
mod: firmalife
group: p
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For pot recipes where the pot is clicked with bowls to get food with specified food data
example: |-
    'minecraft:cooked_beef',
    [
        'minecraft:dirt',
        'minecraft:cobblestone'
    ],
    Fluid.water(),
    20,
    100,
    {
        hunger: 50,
        dairy: 5,
        decayModifier: 0.9
    }
sig: |-
    itemOutput: ItemStack,
    ingredients: List<Ingredient>,
    fluidIngredient: SizedFluidIngredient,
    duration: int,
    temperature: number,
    food: {
        hunger?: int,
        water?: number,
        saturation?: number,
        intoxication?: int,
        grain?: number
        fruit?: number,
        vegetables?: number,
        protein?: number,
        dairy?: number,
        decayModifier?: number
    }
---

- 1st argument: The output item of the recipe
- 2nd argument: A list of up to 5 item ingredients, the item inputs of the recipe
- 3rd argument: A sized fluid ingredient, the fluid input of the recipe
- 4th argument: A non-negative integer number, the number of ticks the pot must be boiling for
- 5th argument: A non-negative number, the temperature (°C) the pot must reach to start boiling
- 6th argument: The [food data]({% link kubejs_tfc/1.21.1/data.md %}#food-data-properties) to apply to the output item
