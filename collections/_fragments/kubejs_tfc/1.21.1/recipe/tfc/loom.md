---
title: Loom
anchor: loom
mod: tfc
group: l
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For recipes performed on a loom block
example:
    - "'minecraft:obsidian',"
    - "'minecraft:black_wool',"
    - "20,"
    - "'minecraft:block/black_concrete'"
sig:
    - "result: ItemStackProvider,"
    - "ingredient: Ingredient,"
    - "steps: int,"
    - "texture: ResourceLocation"
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: An item ingredient, the recipe input
- 3rd argument: A number, how many times the loom needs to be clicked to finish the recipe
- 4th argument: A `ResourceLocation`, the id of a texture to display on the loom while performing the recipe
