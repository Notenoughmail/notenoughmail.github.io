---
title: Stacked Tree
anchor: stacked-tree
type: stacked_tree
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/trees/#stacked-tree
sort_pos: f_t
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ base ]]

- `.trunk(trunk: TrunkConfig)`{: .language-kube-21 #{{ page.anchor }}-trunk }: The trunk properties. Can be made as an object with the following fields
    - `state: BlockState`{:.langauge-kube-21}: The trunk block to place
        - Defaults to `'minecraft:air'`{:.s}
    - `minHeight?: int`{:.langauge-kube-21}: The minimum height of the trunk
        - Must be <= `maxHeight`{:.v}
        - [[ def_0 ]]
    - `maxHeight?: int`{:.langauge-kube-21}: The maximum height of the trunk
        - Must be >= `minHeight`{:.v}
        - Defaults to `2`{:.n}
    - `wide?: boolean`{:.langauge-kube-21}: If the trunk should be 2x2
        - [[ def_f ]]
    - [[ required ]]
- `.roots(roots: TreeRootBuilder)`{: .language-kube-21 #{{ page.anchor }}-roots }: The root system properties. Can be made as an object with the fields
    - `blocks: Map<Block, List<WeightedValue<BlockState>>>`{:.langauge-kube-21}: The blocks to place, mapping from the surface blocks to the [[ weighted ]] states to place
        - [[ required ]]
    - `width?: int`{:.langauge-kube-21}: The maximum horizontal distance the roots can place
        - [[ pos ]]
        - Defaults to `4`{:.n}
    - `height?: int`{:.langauge-kube-21}: The maximum vertical distance below the surface the roots can place
        - [[ pos ]]
        - Defaults to `3`{:.n}
    - `tries?: int`{:.langauge-kube-21}: The number of times to attempt to place each root
        - [[ pos ]]
        - Defaults to `5`{:.n}
    - `skewChance?: float`{:.langauge-kube-21}: The chance a root position is skewed downwards
        - Defaults to `NaN`{:.n}
    - `required?: bool`{:.langauge-kube-21}: If the tree requires the roots to place in order to place
        - [[ def_f ]]
- `.treePlacement(placement: TreePlacementConfig)`{: .language-kube-21 #{{ page.anchor }}-tree-placement }: The tree placement properties. Can be made as an object with the fields
    - `width?: int`{:.langauge-kube-21}: The width of ground clearance needed
        - Defaults to `5`{:.n}
    - `height?: int`{:.langauge-kube-21}: The height of ground clearance needed
        - Defaults to `3`{:.n}
    - `groundType?: GroundType`{:.langauge-kube-21}: The type of ground the tree can spawn on
        {% include enum_list.html summary='Reveal/hide list of ground types' values='normal,sand,shallow_water,submerged,shallow_allow_saltwater,submerged_allow_saltwater,floating' %}
        - Defaults to `normal`{:.e}
- `.layers(layers: List<StackedTreeLayer>)`{: .language-kube-21 #{{ page.anchor }}-layers }: The layers making up a tree. Each layer can be made as an object with the fields
    - `templates: List<ResourceLocation>`{:.langauge-kube-21}: The id of the layer's structure, located at `data/<namesapce>/structures/<path>.nbt`
        - [[ required ]]
    - `minCount: int`{:.langauge-kube-21}: The minimum number of structures from the layer to use
        - **Must** be <= `maxCount`{:.v}
    - `maxCount: int`{:.langauge-kube-21}: The maximum number of structures from the layer to use
        - **Must** be >= `minCount`{:.v}
