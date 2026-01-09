---
title: Tool
anchor: tool
type: tfc:tool
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .mineableBlocksTag('kubejs:ugly_blocks')
    - .attackDamageBaseline(0.2)
    - .modifyTier(tier => {
    - "    tier.setUses(5000)"
    - '})'
---

Creates a new generic tool item

Inherits the methods of the [chisel item builder](#chisel)

{: #tool-methods }

## Extra Methods

- `.mineableBlocksTag(blockTag: TagKey<Block>)`{: .language-kube-21 #tool-mineable-blocks-tag }: Set the block tag the tool is effective against
- `.knife()`{: .language-kube-21 #tool-knife }: Set the mineable block tag to `tfc:mineable_with_knife` and add the tool to the `tfc:tools/knife` tag
