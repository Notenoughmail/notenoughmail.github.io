---
title: 'minecraft:noise'
anchor: chunk-generator-noise
cat:
    - worldjs
    - 1.21.1
    - chunk_gen
---

[Uses noise](https://minecraft.wiki/w/Dimension_definition#noise) to determine the shape and biomes of the world

- `.noiseSettings(settings: Holder$Reference<NoiseGeneratorSettings>)`{: .language-kube-21 #{{ page.anchor }}-noise-setting }: The [noise settings](#noise-generator-settings) of the world
    - [[ required ]]
- `.biomeSource(type: ResourceLocation, biomeSourceBuilder: Consumer<BiomeSourceBuilder>)`{: .language-kube-21 #{{ page.anchor }}-biome-source }: Settings for the biome layout of the world
    - `type: ResourceLocation`{:.language-kube-21}: The id of a [biome source builder type](#biome-sources)
    - `biomeSourceBuilder: Consumer<BiomeSourceBuilder>`{:.language-kube-21}: A callback to edit the properties of the [biome source](#biome-sources)
        - The methods available will depend on the `type`{:.v}
    - [[ required ]]

{% comment %}

## noise generator settings

## biome sources

{% endcomment %}
