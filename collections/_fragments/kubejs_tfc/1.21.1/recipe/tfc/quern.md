---
title: Quern
anchor: quern
mod: tfc
group: q
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For grinding recipes performed in querns
example:
    - "TFC.isp.of('tfc:metal/ingot/copper')"
    - "    .addHeat(500),"
    - "'tfc:metal/ingot/bismuth'"
sig:
    - "result: ItemStackProvider,"
    - "ingredient: Ingredient"
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: An item ingredient, the recipe input
