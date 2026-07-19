---
title: Hot Spring
anchor: hot-spring
type: hot_spring
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#hot-spring
sort_pos: h
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ base ]]

- `.wallState(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-wall-state }: The wall of the hot spring. If not set blocks from the lowest rock layer will be used
- `.fluidState(state: BlockState)`{: .language-kube-21 #{{ page.anchor }}-fluid-state }: The fluid of the hot spring
    - Defaults to `'minecraft:air'`{:.s}
- `.radius(r: int)`{: .language-kube-21 #{{ page.anchor }}-radius }: The radius of the hot spring
    - Must be {% in_range 1,16 %}
    - Defaults to `14`{:.n}
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
    - `states: Map<Block, List<WeightedValue<BlockState>>>`{:.language-kube-21}: A mapping of blocks to the decoration states as [[ weight ]]s
        - [[ required ]]
- `.allowedUnderwater(allowed: boolean)`{: .language-kube-21 #{{ page.anchor }}-allowed-underwater }: If the hot spring can generate underwater
    - [[ def_f ]]
- `.replaceOnFluidContact(replacements: Map<Block, List<WeightedValue<BlockState>>>)`{: .language-kube-21 #{{ page.anchor }}-replace-on-fluid-contact }: The blocks to replace and what to replace them with, as [[ weight ]]s, when contacting fluid
