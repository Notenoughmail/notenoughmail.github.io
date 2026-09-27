---
title: Kaolin Disc Vein
anchor: kaolin-disc-vein
type: kaolin_disc_vein
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/veins/#kaolin-disc-vein
sort_pos: v_k
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    .replacementStates({
        'tfc:rock/raw/dacite': [
            'minecraft:gold_ore'
        ]
    })
    .rarity(40)
    .minY(30)
    .maxY(80)
    .height(2)
    .seed(417862862586)
    .withPlacement(p => p.tag('tfc:in_biome/veins'))
inherit: '#disc-vein'
inherit-display: disc vein
---
