---
title: Huge Red Mushroom
anchor: huge-red-mushroom
type: huge_red_mushroom
wiki_link: https://minecraft.wiki/w/Huge_Mushroom?oldid=3378093
icon: huge-mushroom
sort_pos: hm
name: 'kubejs:moonlit_red_mushroom'
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    .capProvider([
        { weight: 14, value: 'minecraft:red_mushroom_block' },
        'minecraft:ochre_froglight'
    ])
    .stemProvider([
        { weight: 10, value: 'minecraft:mushroom_stem' },
        'minecraft;stripped_birch_wood'
    ])
    .foliageRadius(1)
    .withPlacement(placement => {}) // See the weighted random selector example
    // Kindly provided by Liopyu
inherit: huge-brown-mushroom
inherit-display: huge brown mushroom
---
