---
title: Multiface Growth
anchor: multiface-growth
type: multiface_growth
wiki_link: https://minecraft.wiki/w/Sculk_Vein_(feature)?oldid=3566428
sprite: BlockSprite
icon: sculk-vein
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.block(block: Block)`{: .language-kube-21 #{{ page.anchor }}-block }: The block to place
    - **Must** be an instance of `MultifaceBlock`
    - [[ required ]]
- `.searchRange(range: int)`{: .language-kube-21 #{{ page.anchor }}-search-range }: The range to search for a placement position
    - Must be {% in_range 1,64 %}
    - [[ def_1 ]]
- `.canPlaceOnFloor()`{: .language-kube-21 #{{ page.anchor }}-can-place-on-floor }: Allow the feature to place on floors
- `.canPlaceOnCeiling()`{: .language-kube-21 #{{ page.anchor }}-can-place-on-ceiling }: Allow the feature to place on ceilings
- `.canPlaceOnWall()`{: .language-kube-21 #{{ page.anchor }}-can-place-on-wall }: Allow the feature to place on walls
- `.chanceOfSpreading(chance: float)`{: .language-kube-21 #{{ page.anchor }}-chance-of-spreading }: The chance the feature can spread
    - [[ unit ]]
    - [[ def_0 ]]
- `.canBePlacedOn(blocks: HolderSet<Block>)`{: .language-kube-21 #{{ page.anchor }}-can-be-place-on }: The block(s) the placed block can be placed on
    - Defaults to `[]`
