---
title: Landslide
anchor: landslide
mod: tfc
group: l
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For blocks that landslide automatically due to not be supported by surrounding blocks
example:
    - "'minecraft:grass_block',"
    - "'minecraft:dirt'"
sig:
    - 'result?: BlockState,'
    - 'ingredient: BlockIngredient'
---

- *Optional 1st argument*: A block state, the result of the recipe. If not present, the block landslides to itself
- 2nd argument: A [[ bing ]], the block that will landslide

{: .notice #{{ page.anchor }}-tag-notice }
> In order to collapse, a block *must* have the `tfc:can_landslide` tag. Additionally, for blocks that simply landslide to themself, it is sufficient for them to have that tag as TFC has a builtin recipe (which is checked *after* all other collapse recipes) that covers that case
