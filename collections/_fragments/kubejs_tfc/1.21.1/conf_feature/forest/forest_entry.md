---
title: Forest Entry
anchor: forest-entry
type: forest_entry
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/trees/#forest-entry
sort_pos: f_b
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

- `.climate(placement: ClimatePlacement)`{: .language-kube-21 #{{ page.anchor }}-climate }: The climatic conditions this forest entry can spawn in. Can be made as an object with the fields
    - `minTemp?: float`{:.langauge-kube-21}: The minimum temperature
        - [[ n_inf ]]
    - `maxTemp?: float`{:.langauge-kube-21}: The maximum temperature
        - [[ p_inf ]]
    - `minGroundwater?: float`{:.langauge-kube-21}: The minimum groundwater value
        - [[ n_inf ]]
    - `maxGroundwater?: float`{:.langauge-kube-21}: The maximum groundwater value
        - [[ p_inf ]]
    - `minRainVariance?: float`{:.langauge-kube-21}: The minimum rain variance
        - Defaults to `-1`{:language-kube-21}
    - `maxRainVariance?: float`{:.langauge-kube-21}: The maximum rain variance
        - [[ def_1 ]]
    - `absoluteRainVariance?: boolean`{:.langauge-kube-21}: If the sign of the rain variance at a location should be ignored when checking ranges
        - [[ def_f ]]
    - `fuzzy?: boolean`{:.langauge-kube-21}: If climate values should be evaluated fuzzily
        - [[ def_f ]]
    - `ignoreRivers?: boolean`{:.langauge-kube-21}: If climate values should be influenced before river influence
        - [[ def_f ]]
    - `minForestDensity?: int`{:.langauge-kube-21}: The minimum forest density
        - [[ non_neg ]]
        - [[ def_0 ]]
    - `maxForestDensity?: int`{:.langauge-kube-21}: The maximum forest density
        - [[ non_neg ]]
        - Defaults to `4`{:.n}
    - `minElevation?: int`{:.langauge-kube-21}: The minimum elevation
        - Defaults to `-64`{:.n}
    - `maxElevation?: int`{:.langauge-kube-21}: The maximum elevation
        - Defaults to `320`{:.n}
    - `forestTypes?: List<ForestType>`{:.langauge-kube-21}: The [forest types]({% link kubejs_tfc/1.21.1/type-explanations.md %}#forest-type-enum) the entry may spawn in. Will spawn in all types if empty or unset
        - Defaults to `[]`
- `.bush(log: BlockState, leaves: BlockState)`{: .language-kube-21 #{{ page.anchor }}-bush }: The bush blocks
- `.fallen(log: BlockState, leaves: BlockState)`{: .language-kube-21 #{{ page.anchor }}-fallen }: The fallen tree blocks
    - The `log`{:.v} block must be TFC's `natural` and the vanilla `axis` state properties. See the [log builder]({% link kubejs_tfc/1.21.1/blocks.md %}#log)
    - The `leaves`{:.v} block must have TFC's `layers` state property. See the [fallen leaves builder]({% link kubejs_tfc/1.21.1/blocks.md %}#leaves-fallen-leaves)
- `.groundcover(cover: List<WeightedValue<BlockState>>)`{: .language-kube-21 #{{ page.anchor }}-groundcover }: The groundcover present in the forest as [[ weighted ]]s
- `.trees(normal: Holder<ConfiguredFeature<?, ?>>, dead: Holder<ConfiguredFeature<?, ?>>)`{: .language-kube-21 #{{ page.anchor }}-trees }: The living and dead tree configured features to place in the forest
    - [[ required ]]
- `.oldGrowthTree(old: Holder<ConfiguredFeature<?, ?>>)`{: .language-kube-21 #{{ page.anchor }}-old-growth-tree }: The configured feature to place for old growth trees
- `.krummholz(krummholz: Holder<ConfiguredFeature<?, ?>>)`{: .language-kube-21 #{{ page.anchor }}-krummholz }: The configured feature to place for krummholz
    - See the [krummholz feature builder](#krummholz)
- `.soilDisc(disc: Holder<ConfiguredFeature<?, ?>>)`{: .language-kube-21 #{{ page.anchor }}-soil-disc }: The soil disc feature to place
- `.oldGrowthChance(chance: int)`{: .language-kube-21 #{{ page.anchor }}-old-growth-chance }: The chance any given tree will be old growth. Approximately one per `chance`{:.v} trees
    - [[ pos ]]
    - Defaults to `6`{:.n}
- `.spoilerOldGrowthChance(chance: int)`{: .language-kube-21 #{{ page.anchor }}-spoiler-old-growth-chance }: The secondary chance that any given tree will be old growth. Approximately one per `chance`{:.v} trees
    - [[ pos ]]
    - Defaults to `200`{:.n}
- `.fallenChance(chance: int)`{: .language-kube-21 #{{ page.anchor }}-fallen-chance }: The chance that any given tree will instead be a fallen tree. Approximately one per `chance`{:.n} trees
    - [[ pos ]]
    - Defaults to `14`{:.n}
- `.deadChance(chance: int)`{: .language-kube-21 #{{ page.anchor }}-dead-chance }: The chance that any given tree will instead be a dead tree. Approximately one per `chance`{:.v} trees
    - [[ pos ]]
    - Defaults to `75`{:.n}
- `.floating(floating: boolean)`{: .language-kube-21 #{{ page.anchor }}-floating }: If trees are allowed to float when placing
    - [[ def_f ]]

{% comment %}

## krummholz

{% endcomment %}
