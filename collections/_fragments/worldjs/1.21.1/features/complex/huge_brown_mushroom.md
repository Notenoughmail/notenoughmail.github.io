---
title: Huge Brown Mushroom
anchor: huge-brown-mushroom
type: huge_brown_mushroom
wiki_link: https://minecraft.wiki/w/Huge_Mushroom?oldid=3378093
icon: huge-mushroom
sort_pos: hm
name: 'kubejs:moonlit_brown_mushroom'
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    .capProvider([
        { weight: 14, value: 'minecraft:brown_mushroom_block' },
        'minecraft:pearlescent_froglight'
    ])
    .stemProvider([
        { weight: 10, value: 'minecraft:mushroom_stem' },
        'minecraft:stripped_birch_wood'
    ])
    .withPlacement(placement => {}) // See the weighted random selector example
    // Kindly provided by Liopyu
---

[[ base ]]

- `.capProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-cap-provider }: The [[ block_state_provider ]] to use for the cap
    - [[ required ]]
- `.stemProvider(provider: BlockStateProvider)`{: .language-kube-21 #{{ page.anchor }}-stem-provider }: The [[ block_state_provider ]] to use for the stem
    - [[ required ]]
- `.foliageRadius(radius: int)`{: .language-kube-21 #{{ page.anchor }}-foliage-radius }: The size of the cap
    - Defaults to `2`{:.n}
