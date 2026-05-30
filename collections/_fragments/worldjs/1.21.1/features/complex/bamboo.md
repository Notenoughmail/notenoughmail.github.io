---
title: Bamboo
anchor: bamboo
type: bamboo
wiki_link: https://minecraft.wiki/w/Bamboo_(feature)?oldid=3566422
icon: bamboo-%28feature%29
sort_pos: b
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    .probability(0.72)
    .withPlacement(placement => {
        placement.modifiers(modifiers => {
            modifiers.minecraft
                .inSquare()
                .surfaceWaterDepth(1)
                .inBiome()
        })
    })
---

[[ base ]]

- `.probability(probability: float)`{: .language-kube-21 #{{ page.anchor }}-probability }: The chance a podzol disk spawns under the bamboo stalk
    - [[ unit ]]
    - [[ def_1 ]]
