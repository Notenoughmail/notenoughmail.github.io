---
title: Casting
anchor: casting
mod: tfc
group: c
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For casting into mold items
example:
    - "'minecraft:gold_ingot',"
    - "'kubejs:mold',"
    - "Fluid.of('minecraft:lava', 100),"
    - "0.95"
sig:
    - 'result: ItemStackProvider,'
    - 'mold: Ingredient,'
    - 'fluid: SizedFluidIngredient,'
    - 'breakChance?: number'
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: An item ingredient, the mold item to pour the fluid into
- 3rd argument: A sized fluid ingredient, the fluid to cast
- *Optional 4th argument*: A number, {% in_unit %}, the probability the mold will break when extracting the casted object, defaults to `1`{:.n}
