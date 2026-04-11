---
title: Chisel
anchor: chisel
mod: tfc
group: c
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For chiseling blocks in world using a chisel item
example:
    - "'minecraft:oak_log[axis=z]',"
    - "[ 'minecraft:dirt', 'minecraft:oak_planks' ],"
    - "'tfc:smooth'"
sig:
    - 'result: BlockState,'
    - 'ingredient: BlockIngredient,'
    - 'mode: Holder<ChiselMode>,'
    - 'itemOutput?: ItemStackProvider'
sig_add:
    - '.itemOutput(itemOutput: ItemStackProvider)'
    - '.extraDrop(itemOutput: ItemStackProvider)'
---

- 1st argument: A block state, the base result of chiseling, may be tweaked by the `mode`{:.v}
- 2nd argument: A [[ bing ]], the input block(s) of the recipe
- 3rd argument: The id of a chisel mode. A full list of available modes can be seen by running the command `/kubejs dump_registry tfc:chisel_mode`{:.language-command}. Custom modes can be [registered]({% link kubejs_tfc/1.21.1/registry.md %}#chisel-mode) via scripts
- *Optional 4th argument*: An [[ isp ]], an additional item given to the player upon chiseling

<span></span>

- `.itemOutput(itemOutput: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-item-output }: Accepts an [[ isp ]], the additional item given to the player upon chiseling
- `.extraDrop(itemOutput: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-extra-crop }: An alias of [`.itemOutput(...)`{:.language-kube-21}](#{{ page.anchor }}-item-output){:.preserve-color}
