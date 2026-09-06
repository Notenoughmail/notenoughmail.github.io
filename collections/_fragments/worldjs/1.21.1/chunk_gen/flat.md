---
title: 'minecraft:flat'
anchor: chunk-generator-flat
cat:
    - worldjs
    - 1.21.1
    - chunk_gen
---

A [superflat](https://minecraft.wiki/w/Superflat) world

- `.structureOverrides(structures: HolderSet<StrcutrueSet>)`{: .language-kube-21 #{{ page.anchor }}-structure-overrides }: The structure sets to place in the world
    - Defaults to all structure sets
- `.addLayer(height: int, block: Block)`{: .language-kube-21 #{{ page.anchor }}-add-layer }: Add a layer to the world
    - `height: int`{:.language-kube-21}: The thickness of the layer
        - Must be {% in_range 0,4064 %}
    - `block: Block`{:.language-kube-21}: The block to place for the layer
- `.biome(biome: Holder$Reference<Biome>)`{: .language-kube-21 #{{ page.anchor }}-biome }: The biome of the world
    - Defaults to `'minecraft:plains'`{:.s}
- `.withLavaLakes()`{: .language-kube-21 #{{ page.anchor }}-with-lava-lakes }: Allows lava lakes to generate
- `.withBiomeFeatures()`{: .language-kube-21 #{{ page.anchor }}-with-biome-features }: Allows the placed features of the biome to generate
