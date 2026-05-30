---
title: Huge Brown Mushroom
anchor: huge-brown-mushroom
type: huge_brown_mushroom
wiki_link: https://minecraft.wiki/w/Huge_Mushroom?oldid=3378093
icon: huge-mushroom
sort_pos: hm
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.capProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-cap-provider }: The [[ block_state_provider ]] to use for the cap
    - [[ required ]]
- `.stemProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-stem-provider }: The [[ block_state_provider ]] to use for the stem
    - [[ required ]]
- `.foliageRadius(radius: int)`{: .language-kube-21 #{{ page.anchor }}-foliage-radius }: The size of the cap
    - Defaults to `2`{:.n}
