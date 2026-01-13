---
title: Moss Growing Block
anchor: moss-growing-block
group: moss
type: tfc:moss_growing_block
name: moss_growing_block
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .mossyBlock('minecraft:mossy_cobblestone')
---

Creates a new moss growing block

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Method

- `.mossyBlock(block: Holder<Block>)`{: .language-kube-21 #{{ page.anchor }}-mossy-block }: Set the block the moss growing block converts into when moss grows to it
