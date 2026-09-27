---
title: Boulder
anchor: boulder
type: boulder
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#boulder
sort_pos: b_a
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    .states({
        'tfc:rock/raw/conglomerate': [
            'minecraft:gold_block',
            'minecraft:gravel'
        ],
        'tfc:rock/raw/dacite': [
            'minecraft:iron_block'
        ]
    })
    .withPlacement(p => {
        p.tag('tfc:feature/boulders')
        p.modifiers(m => {
            let { minecraft, tfc} = m
            minecraft
                .rarityFilter(12)
                .inSquare()
                .heightmap('world_surface_wg')
            tfc.flatEnough(0.4, 4, 2)
        })
    })
---

[[ base ]]

- `.states(state: Map<Block, List<BlockState>>)`{: .language-kube-21 #{{ page.anchor }}-states }: Sets the states to place, mapping from the raw rock of a region to the collection of blockstate the boulder is made of
