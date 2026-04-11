---
title: Bloomery
anchor: bloomery
mod: tfc
group: b
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For recipes performed in the bloomery multiblock
example:
    - "'kubejs:unworked_copper_piece',"
    - "Item.of('tfc:powder/flux', 5),"
    - "Fluid.of('tfc:metal/copper', 300),"
    - '10500'
sig:
    - 'result: ItemStackProvider,'
    - 'catalyst: SizedIngredient,'
    - 'fluid: SizedFluidIngredient,'
    - 'duration: int'
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: A sized item ingredient, the catalyst item of the recipe
- 3rd argument: A sized fluid ingredient, the input fluid of the recipe
- 4th argument: An integer number, {% in_range 0,Infinity,) %}, the number of ticks the recipe takes

{: .notice #{{ page.anchor }}-fluid-notice }
> While the recipe uses a `SizedFluidIngredient`, the actual bloomery requires items which [melt]({% link kubejs_tfc/1.21.1/recipes.md %}#heating) into the valid fluid(s)
