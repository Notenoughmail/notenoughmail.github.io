---
title: Remove Features
anchor: remove-features
type: remove_features
name: remove_lava_lakes
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example:
    - ".biomes('#kubejs:no_lava_lakes')"
    - ".features('minecraft:lake_lava')"
---

- [[ biomes ]]
- `.features(features: HolderSet<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-features }: Set the feature(s) to remove from the biome(s)
- `.steps(steps: Set<GenerationStep$Decoration>)`{: .language-kube-21 #{{ page.anchor }}-steps }: Set the generation steps to remove the feature(s) from. Leaving empty or not defining will remove the feature(s) from every generation step
    {% include enum_list.html summary='Reveal/hide list of valid decoration steps' values='raw_generation,lakes,local_modifications,underground_structures,surface_structures,strongholds,underground_ores,underground_decoration,fluid_springs,vegetal_decoration,top_layer_modification' %}
