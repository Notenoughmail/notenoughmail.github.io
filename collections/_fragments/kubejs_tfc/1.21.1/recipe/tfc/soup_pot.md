---
title: Soup Pot
anchor: soup-pot
func: soup_pot
mod: tfc
group: pot_soup
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For pot recipes which require the pot to be clicked with items tagged `tfc:soup_bowls` to get an output
example:
    - "["
    - "    'minecraft:wheat'"
    - "],"
    - "Fluid.water(20),"
    - "2,"
    - "94"
sig:
    - "ingredients: List<Ingredient>,"
    - "fluidIngredient: SizedFluidIngredient,"
    - "duration: int,"
    - "temperature: number"
---

- 1st argument: A list of up to 5 item ingredients, the item inputs of the recipe
- 2nd argument: A sized fluid ingredient, the fluid input of the recipe
- 3rd argument: A non-negative integer number, the number of ticks the pot must be boiling for
- 4th argument: A non-negative number, the temperature (°C) the pot must reach to start boiling

{: .related #{{ page.anchor }}-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.pot_soup(...)`{:.language-kube-21}. Both may be used in placed of each other as they have the same semantics
