---
title: Cluster Vein
anchor: cluster-vein
type: cluster_vein
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/veins/#cluster-vein
sort_pos: v_c
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ base ]]

- `.replacementStates(states: Map<Block, List<WeightedValue<BlockState>>>)`{: .language-kube-21 #{{ page.anchor }}-replacement-states }: A mapping of blocks to the ore states as [[ weight ]]s
    - [[ required ]]
- `.rarity(r: int)`{: .language-kube-21 #{{ page.anchor }}-rarity }: How often the vein will place, approximately once per `r`{:.v} chunks
    - [[ pos ]]
    - [[ def_1 ]]
- `.density(d: number)`{: .language-kube-21 #{{ page.anchor }}-density }: Within the vein volume, the portion of the base rock that should be replaced with ore
    - [[ unit ]]
    - [[ def_1 ]]
- `.minY(y: int)`{: .language-kube-21 #{{ page.anchor }}-min-y }: The lowest y-value the vein can spawn at
    - Defaults to `-64`{:.language-kube-21}
- `.maxY`{: .language-kube-21 #{{ page.anchor }}-max-y }: The highest y-value the vein can spawn at
    - Defaults to `320`{:.n}
- `.projectToSurface(p: boolean)`{: .language-kube-21 #{{ page.anchor }}-project-to-surface }: If the vein should project to the surface during placement
    - [[ def_f ]]
- `.projectOffset(p: boolean)`{: .language-kube-21 #{{ page.anchor }}-project-offset }: If an offset should be applied to the vein when projecting to surface
    - [[ def_f ]]
- `.nearLava(n: boolean)`{: .language-kube-21 #{{ page.anchor }}-near-lava }: If the vein should only spawn near lava
    - [[ def_f ]]
- `.seed(seed: int)`{: .language-kube-21 #{{ page.anchor }}-seed }: The seed of the vein
    - Defaults to a random 64-bit integer seeded by the hash of the vein's id
- `.indicator(indicator: IndicatorBuilder)`{: .language-kube-21 #{{ page.anchor }}-indicator }: Properties for the indicator blocks placed on the ground near the vein. Can be made as an object with the following fields
    - `depth?: int`{:.language-kube-21}: The maximum depth below the surface the vein will place indicators
        - [[ pos ]]
        - [[ def_1 ]]
    - `rarity?: int`{:.language-kube-21}: The rarity to place indicators, as a fraction of the horizontal locations the vein places ore blocks
        - [[ def_1 ]]
    - `undergroundRarity?: int`{:.language-kube-21}: The rarity to place indicators underground when the vein is too deep to place on the surface, as a fraction of the horizontal locations the vein places ore blocks
        - [[ pos ]]
        - [[ def_1 ]]
    - `undergroundCount?: int`{:.language-kube-21}: The number of times to attempt to place an underground indicator in a given location
        - [[ def_1 ]]
    - `states: List<WeightedValue<BlockState>>`{:.language-kube-21}: The indicator states to place, as [[ weight ]]s
        - [[ required ]]
- `.size(s: int)`{: .language-kube-21 #{{ page.anchor }}-size }: The size of the vein
    - [[ pos ]]
    - Defaults to `10`{:.n}
