---
title: Add Features
anchor: add-features
type: add_features
name: add_moonlit_sanctuaries
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example: |-
    .biomes('#minecraft:is_forest')
    .step('vegetal_decoration')
    .features('#kubejs:worldgen/moonlit_sanctuaries')
---

- [[ biomes ]]
- `.step(step: GenerationStep$Decoration)`{: .language-kube-21 #{{ page.anchor }}-step }: Set the decoration step the features will added to
    {% include enum_list.html summary='Reveal/hide list of decoration steps' values='raw_generation,lakes,local_modifications,underground_structures,surface_structures,strongholds,underground_ores,underground_decoration,fluid_springs,vegetal_decoration,top_layer_modification' %}
- `.features(features: HolderSet<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-features }: Set the feature(s) to be added to the biome(s)
