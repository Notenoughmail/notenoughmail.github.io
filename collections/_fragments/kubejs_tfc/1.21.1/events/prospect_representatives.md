---
type: startup
name: prospectRepresentatives
title: Prospect Representatives
anchor: prospect-representatives
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - event.register('minecraft:sponge', 'minecraft:wet_sponge')
    - event.register('minecraft:terracotta', 'minecraft:white_terracotta', 'minecraft:red_terracotta', 'minecraft:lime_terracotta') // etc.
---

TFC's prospecting system allows multiple blocks to be treated as the same for the purposes of counting how many of a block were found. This event allows for the creation of such aliases

{: #{{ page.anchor }}-methods }

## Method

- `.register(representative: Block, blocks...: Block[])`{: .language-kube-21 #{{ page.anchor }}-register }: Register the representative of the given blocks
    - `representative: Block`{:.language-kube-21}: The block to be reported/counted when prospecting
    - `blocks...: Block[]`{:.language-kube-21}: The blocks to be represented by the `representative`{:.v}
