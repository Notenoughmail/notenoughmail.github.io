---
type: server
name: collapse
title: Collapse
anchor: collapse
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - event.getSecondaryPositions().forEach(pos => {
    - "    event.getLevel().playSound(null, pos, 'minecraft:block.wood.break', 'blocks', 1, 1)"
    - '})'
---

This event fires whenever a collapse, real or fake, occurs

{: #{{ page.anchor }}-methods }

## Methods

- `.getCenterPos(): BlockPos`{: .language-kube-21 #{{ page.anchor }}-get-center-pos }: Get the origin position of the collapse
- `.getLevel(): Level`{: .language-kube-21 #{{ page.anchor }}-get-level }: Get the level the collapse occurred in
- `.getRadiusSquared(): number`{: .language-kube-21 #{{ page.anchor }}-get-radius-squared }: Get the square of the maximum distance from the center that blocks may collapse. Will be `0`{:.n} if the collapse is fake
- `.getSecondaryPositions(): List<BlockPos>`{: .language-kube-21 #{{ page.anchor }}-get-secondary-positions }: Get the additional positions where a block will collapse or, if the collapse is fake, particles will spawn
- `.isFake(): boolean`{: .language-kube-21 #{{ page.anchor }}-is-fake }: If the collapse is fake
