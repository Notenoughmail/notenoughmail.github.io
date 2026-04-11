---
title: Collapse
anchor: collapse
mod: tfc
group: c
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For blocks that collapse as a result of unsafe mining practices
example:
    - "'minecraft:gold_block',"
    - "'minecraft:iron_block'"
sig:
    - 'result?: BlockState,'
    - 'ingredient: BlockIngredient'
---

- *Optional 1st argument*: A block state, the result of the recipe. If not present, the block collapses to itself
- 2nd argument: A [[ bing ]], the block that will collapse

{: .notice #{{ page.anchor }}-tag-notice }
> In order to collapse, a block *must* have the `tfc:can_collapse` tag. Additionally, for blocks that simply collapse to themself, it is sufficient for them to have that tag as TFC has a builtin recipe (which is checked *after* all other collapse recipes) that covers that case
>
> Also be aware of the related `tfc:can_start_collapse` and `tfc:can_trigger_collapse` block tags
