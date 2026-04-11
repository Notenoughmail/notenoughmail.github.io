---
title: Jam Pot
anchor: jam-pot
mod: tfc
group: pot_jam
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For pot recipes that require the pot to be clicked with empty jars and items tagged `tfc:foods/empty_jars_with_lid` to get their outputs
example:
    - "'minecraft:red_wool',"
    - "'minecraft:red_concrete',"
    - "["
    - "    'minecraft:red_concrete_powder'"
    - "],"
    - "Fluid.water(100),"
    - "1,"
    - "50,"
    - "'minecraft:block/green_wool'"
sig:
    - "unsealedResult: ItemStack,"
    - "sealedResult: ItemStack,"
    - "ingredients: List<Ingredient>,"
    - "fluidIngredient: SizedFluidIngredient,"
    - "duration: int,"
    - "temperature: number,"
    - "texture: ResourceLocation"
---

- 1st argument: An item stack, the stack to give the player when they click the pot with an empty jar after the recipe completes
- 2nd argument: A item stack, the stack to give the player when they click the pot with an item tagged `tfc:foods/empty_jars_with_lid` after the recipe completes
- 3rd argument: A list of up to 5 item ingredients, the item inputs of the recipe
- 4th argument: A sized fluid ingredient, the fluid input of the recipe
- 5th argument: A non-negative integer number, the number of ticks the pot must be boiling for
- 6th argument: A non-negative number, the temperature (°C) the pot must reach to be boiling
- 7th argument: A `ResourceLocation`, the id of a texture to display in the pot after completion of the recipe
