---
title: Dripstone Cluster
anchor: dripstone-cluster
type: dripstone_cluster
wiki_link: https://minecraft.wiki/w/Dripstone_(feature)?oldid=3522490
sprite: BlockSprite
icon: pointed-dripstone
sort_pos: d
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.floorToCeilingSearchRange(range: int)`{: .language-kube-21 #{{ page.anchor }}-floor-to-ceiling-search-range }: How many blocks the feature searches for the floor or ceiling
    - Must be {% in_range 1,512 %}
    - [[ def_1 ]]
- `.height(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-height }: The height of the cluster as an [[ int ]]
    - Must be {% in_range 1,128 %}
    - [[ required ]]
- `.radius(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-radius }: The radius of the cluster as an [[ int ]]
    - Must be {% in_range 1,128 %}
    - [[ required ]]
- `.maxStalagmiteStalactiteHeightDiff(diff: int)`{: .language-kube-21 #{{ page.anchor }}-max-stalagmite-stalactite-height-diff }: The maximum difference between the height of stalagmites and stalactites
    - Must be {% in_range 0,64 %}
    - [[ def_1 ]]
- `.heightDeviation(deviation: int)`{: .language-kube-21 #{{ page.anchor }}-height-deviation }: The maximum difference from the height of a dripstone
    - Must be {% in_range 1,64 %}
    - [[ def_1 ]]
- `.dripstoneBlockLayerThickness(provider: IntProvider)`{: .language-kube-21 #{{ page.anchor }}-dripstone-block-layer-thickness }: The dripstone block layer's thickness as an [[ int ]]
    - Must be {% in_range 0,128 %}
    - [[ required ]]
- `.density(provider: FloatProvider)`{: .language-kube-21 #{{ page.anchor }}-density }: The density of the columns as a [[ float ]]
    - Must be {% in_range 0,2 %}
    - [[ required ]]
- `.wetness(provider: FloatProvider)`{: .language-kube-21 #{{ page.anchor }}-wetness }: The chance of also placing a pool as a [[ float ]]
    - Must be {% in_range 0,2 %}
    - [[ required ]]
- `.chanceOfDripstoneColumnAtMaxDistanceFromCenter(chance: number)`{: .language-kube-21 #{{ page.anchor }}-chance-of-dripstone-column-at-max-distance-from-center }: The chance there is a column at the maximum distance from the center
    - [[ unit ]]
    - [[ def_0 ]]
- `.maxDistanceFromEdgeAffectingChanceOfDripstoneColumn(dist: int)`{: .language-kube-21 #{{ page.anchor }}-max-distance-from-edge-affecting-chance-of-dripstone-column }: The maximum distance form the center that can influence the chance of the column placing
    - Must be {% in_range 1,64 %}
    - [[ def_1 ]]
- `.maxDistanceFromCenterAffectingHeightBias(dist: int)`{: .language-kube-21 #{{ page.anchor }}-max-distance-from-center-affecting-height-bias }: The maximum distance from the center that can influence the height bias
    - Must be {% in_range 1,64 %}
    - [[ def_1 ]]
