---
title: Cave Vegetation
anchor: cave-vegetation
type: cave_vegetation
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#cave-vegetation
sort_pos: c
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    .states({
        'tfc:rock/raw/conglomerate': [
            {
                weight: 50,
                value: 'caves:vine/scary'
            },
            {
                weight: 3,
                value: 'caves:vine/spooky'
            }
        ]
    })
---

[[ base ]]

- `.states(states: Map<Block, List<WeightedValue<BlockState>>>)`{: .language-kube-21 #{{ page.anchor }}-states }: A mapping of cave block to weighted vegetation blocks, via [[ weight ]]s, to place
