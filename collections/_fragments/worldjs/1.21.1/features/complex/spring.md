---
title: Spring
anchor: spring
type: spring
wiki_link: https://minecraft.wiki/w/Spring?oldid=3566440
sort_pos: s
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.fluidState(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-fluid-state }: The fluid to place, as derived from the block
- `.rawFluidState(state: FluidState)`{: .language-kube-21 #{{ page.anchor }}-raw-fluid-state }: The fluid to place. **Note**: there is not a `FluidState` wrapper, so an actual `FluidState` object is required
- `.requiresBlockBelow(required: boolean)`{: .language-kube-21 #{{ page.anchor }}-requires-block-below }: If the spring requires a block matching the spring's [valid blocks](#{{ page.anchor }}-valid-blocks) below to generate
- `.rockCount(count: int)`{: .language-kube-21 #{{ page.anchor }}-rock-count }: The number of neighboring blocks that must match the [valid blocks](#{{ page.anchor }}-valid-blocks) of the spring
    - Defaults to `4`{:.n}
- `.holeCount(count: int)`{: .language-kube-21 #{{ page.anchor }}-hole-count }: The required number of air blocks adjacent to the spring
    - The above block is not counted
    - [[ def_1 ]]
- `.validBlocks(blocks: HolderSet<Block>)`{: .language-kube-21 #{{ page.anchor }}-valid-blocks }: The blocks the spring requires to generate
    - Defaults to `[]`
