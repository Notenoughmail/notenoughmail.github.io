---
title: Add Features
anchor: add-features
type: add_features
name: add_flowers
cat:
    - worldjs
    - 1.21.1
    - biome_mod
example:
    - ".biomes('#kubejs:needs_more_flowers')"
    - ".step('vegetal_decoration')"
    - ".features('#kubejs:flower_patches')"
---

- [[ biomes ]]
- `.step(step: GenerationStep$Decoration)`{: .language-kube-21 #{{ page.anchor }}-step }: Set the decoration step the features will added to
    {% include enum_list.html summary='Reveal/hide list of valid decoration steps' values='raw_generation,lakes,local_modifications,underground_structures,surface_structures,strongholds,underground_ores,underground_decoration,fluid_springs,vegetal_decoration,top_layer_modification' %}
- `.features(features: HolderSet<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-features }: Set the feature(s) to be added to the biome(s)
