---
title: Fissure
anchor: fissure
type: fissure
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#fissure
sort_pos: f
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ base ]]

- `.wallState(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-wall-state }: The wall state of the fissure
- `.fluid(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-fluid }: The fluid within the fissure
    - Defaults to `'minecraft:air'`{:.s}
- `.count(c: int)`{: .language-kube-21 #{{ page.anchor }}-count }: How many fissures to place
    - [[ pos ]]
    - Defaults to `5`{:.n}
- `.radius(r: int)`{: .language-kube-21 #{{ page.anchor }}-radius }: The size of the area fissures will be placed in
    - [[ pos ]]
    - Defaults to `12`{:.n}
- `.pieces(minCount: int, maxCount: int)`{: .language-kube-21 #{{ page.anchor }}-pieces }: The number of pieces which make up each fissure to place
    - [[ pos ]]
    - `maxCount`{:.v} must be greater than or equal to `minCount`{:.v}
    - Defaults to `10`{:.n} and `24`{:.n}
- `.maxPieceLength(m: int)`{: .language-kube-21 #{{ page.anchor }}-max-piece-length }: The max length of an individual fissure piece
    - [[ pos ]]
    - Defaults to `6`{:.n}
- `.decoration(decoration: FissureDecoration)`{: .language-kube-21 #{{ page.anchor }}-decoration }: Additional decoration properties. Can be made as an object with the following fields
    - `rarity?: int`{:.language-kube-21}: The rarity for blocks being replaced by decoration blocks
        - [[ pos ]]
        - [[ def_1 ]]
    - `radius?: int`{:.language-kube-21}: The radius around the fissure that blocks should be replaced
        - [[ pos ]]
        - [[ def_1 ]]
    - `count?: int`{:.language-kube-21}: The number of blocks to replace. the true number of replaced blocks will be `count / rarity`{:.language-kube-21}
        - [[ pos ]]
        - [[ def_1 ]]
    - `states: Map<Block, List<WeightedValue<BlockState>>>`{:.language-kube-21}: A mapping of blocks to the decoration states as [[ weighted ]]s
        - [[ required ]]
- `.anchor(anchor: VerticalAnchor)`{: .language-kube-21 #{{ page.anchor }}-anchor }: The height of the fissure origin as a [[ vertical_anchor ]]
    - Defaults to `{ above_bottom: 16 }`{:.language-kube-21}
