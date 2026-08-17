---
title: 'minecraft:multi_noise'
anchor: biome-source-multi-noise
cat:
    - worldjs
    - 1.21.1
    - biome_source
---

{% capture range %}Must be {% in_range -2,2 %}{% endcapture %}
{% capture def %}Defaults to `0`{:.n}{% endcapture %}

Uses the world's noise router to [determine biome](https://minecraft.wiki/w/Dimension_definition?oldid=3716645#multi_noise) positions

*One of the following **must** be set. If both are set, the preset will take precedence over the custom parameters*

- `.usingPreset(preset: Holder$Reference<MultiNoiseBiomeSourceParameterList>)`{: .language-kube-21 #{{ page.anchor }}-using-preset }: The parameter preset to use
    - May be one of `'minecraft:overworld'`{:.s} or `'minecraft:nether'`{:.s}
- `.usingParameters(Consumer<ClimateParameterListBuilder>)`{: .language-kube-21 #{{ page.anchor }}-using-parameters }: Build the climate parameters using a callback of the form
    - `builder: ClimateParameterListBuilder`{:.language-kube-21}: The builder, which has a single method available
        - `.forBiome(biome: Holder$Reference<Biome>): ParameterEntry`{: .language-kube-21 #{{ page.anchor }}-climate-parameter-entry }: Creates, adds, and returns a climate parameter entry for the referenced biome. Biomes may have multiple entries. Entries have the following methods, which all return the entry
            - `.temperature(value: number)`{:.language-kube-21}: The temperature to place the biome at
                - {{ range }}
                - {{ def }}
            - `.temperature(min: number, max: number)`{:.language-kube-21}: The temperature range to place the biome in
                - {{ range }}
                - {{ def }}
            - `.humidity(value: number)`{:.language-kube-21}: The humidity to place the biome at
                - {{ range }}
                - {{ def }}
            - `.humidity(min: number, max: number)`{:.language-kube-21}: The humidity range to place the biome in
                - {{ range }}
                - {{ def }}
            - `.continentalness(value: number)`{:.language-kube-21}: The continentalness to place the biome at
                - {{ range }}
                - {{ def }}
            - `.continentalness(min: number, max: number)`{:.language-kube-21}: The continentalness range to place the biome in
                - {{ range }}
                - {{ def }}
            - `.erosion(value: number)`{:.language-kube-21}: The erosion to place the biome at
                - {{ range }}
                - {{ def }}
            - `.erosion(min: number, max: number)`{:.language-kube-21}: The erosion range to place the biome in
                - {{ range }}
                - {{ def }}
            - `.depth(value: number)`{:.language-kube-21}: The depth to place the biome at
                - {{ range }}
                - {{ def }}
            - `.depth(min: number, max: number)`{:.language-kube-21}: The depth range to place the biome in
                - {{ range }}
                - {{ def }}
            - `.weirdness(value: number)`{:.language-kube-21}: The weirdness to place the biome at
                - {{ range }}
                - {{ def }}
            - `.weirdness(min: number, max: number)`{:.language-kube-21}: The weirdness range to place the biome in
                - {{ range }}
                - {{ def }}
            - `.offset(offset: number)`{:.language-kube-21}: The suitability offset
                - Must be {% in_unit %}
                - {{ def }}
