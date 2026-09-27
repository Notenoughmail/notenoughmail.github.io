---
title: Baby Boulder
anchor: baby-boulder
type: baby_boulder
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#baby-boulder
sort_pos: b_b
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    .states({
        'tfc:rock/raw/conglomerate': [
            'minecraft:cobblestone',
            'minecraft:mossy_cobblestone'
        ]
    })
    .withPlacement(p => {
        p.tag('tfc:feature/boulders')
        p.modifiers(m => {
            let { minecraft, tfc } = m
            minecraft
                .inSquare()
                .heightmap('world_surface_wg')
            tfc.flatEnough(0.2, 3, 1)
        })
    })
inherit: '#boulder'
inherit-display: boulder
---
