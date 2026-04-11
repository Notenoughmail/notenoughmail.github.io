---
title: Blast furnace
anchor: blast-furnace
func: blast_furnace
mod: tfc
group: b
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For recipes performed in the blast furnace multiblock
example:
    - "Fluid.of('tfc:metal/copper', 20),"
    - "'#minecraft:flowers',"
    - "Fluid.of('tfc:metal/bismuth', 30)"
sig:
    - 'result: FluidStack,'
    - 'catalyst: Ingredient,'
    - 'fluid: SizedFluidIngredient'
---

- 1st argument: A fluid stack, the result of the recipe
- 2nd argument: An item ingredient, the catalyst of the recipe. One required per amount of `fluid`{:.v} ingredient
- 3rd argument: A sized fluid ingredient, the fluid input of the recipe

{: .notice #{{ page.anchor }}-fluid-notice }
> While the recipe uses a `SizedFluidIngredient`, the actual blast furnace requires items which [melt]({% link kubejs_tfc/1.21.1/recipes.md %}#heating) into the valid fluid(s)
