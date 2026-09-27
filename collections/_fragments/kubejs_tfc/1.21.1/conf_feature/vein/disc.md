---
title: Disc Vein
anchor: disc-vein
type: disc_vein
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/veins/#disc-vein
sort_pos: v_d
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    .replacementStates({
        'tfc:rock/raw/andesite': [
            {
                weight: 50,
                value: 'kubejs:fossil/andesite'
            },
            'minecraft:bone_block'
        ],
        'tfc:rock/raw/granite': [
            {
                weight: 90,
                value: 'kubejs:fossil/granite'
            },
            {
                weight: 3,
                value: 'minecraft:bone_block'
            }
        ],
        'tfc:rock/raw/conglomerate': [
            'kubejs:fossil/conglomerate',
            'kubejs:fossil/conglomerate/alternate'
        ]
    })
    .size(20)
    .height(6)
    .density(0.1)
    .seed(48963214896522)
    .projectToSurface(true)
    .projectOffset(true)
    .withPlacement(p => p.tag('tfc:in_biome/veins'))
---

[[ cluster ]]

- `.size(s: int)`{: .language-kube-21 #{{ page.anchor }}-size }: The radius of the disc
    - [[ pos ]]
    - Defaults to `5`{:.n}
- `.height(h: int)`{: .language-kube-21 #{{ page.anchor }}-height }: The height of the disc
    - [[ pos ]]
    - Defaults to `5`{:.n}
