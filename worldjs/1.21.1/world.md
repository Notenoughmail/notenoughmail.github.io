---
layout: page
title: World Presets, Chunk Generators, & Dimension Types
permalink: /worldjs/1.21.1/world/
parent: 1.21.1
grand_parent: WorldJS
has_toc: false
has_children: false
desc: Creating world presets, dimension types, biomes, and noise generator settings with WorldJS
---

# {{ page.title }}

{% map replacements %}
{% required %}**Must** be set{% end_required %}
{% endmap %}

- [World Preset](#world-preset)
- [Dimension Type](#dimension-type)
- [Noise Generator Settings](#noise-generator-settings)
- [Biome](#biome)

## World Preset

[World presets](https://minecraft.wiki/w/World_preset) determine the dimensions of a world by mapping a the id of the dimension to its [dimension type](#dimension-type) and [chunk generator](#chunk-generators). WorldJS adds the ability to create world presets through KubeJS's `ServerEvents.registry('worldgen/world_preset', event => {})`{:.language-kube-21} event via the default (no type id) builder

- `.withDimension(id: ResourceKey<LevelStem>, dimensionType: Holder$Reference<DimensionType>, generatorType: ResourceLocation, generatorBuilder: Consumer<ChunkGeneratorBuilder>)`{: .language-kube-21 #world-preset-with-dimension }: Adds a dimension to the preset
    - `id: ResourceKey<LevelStem>`{:.language-kube-21}: The id of the dimension
    - `dimensionType: Holder$Reference<Dimensiontype>`{:.language-kube-21}: The id of the [dimension type](#dimension-type) to use for the dimension
    - `generatorType: ResourceLocation`{:.language-kube-21}: The id of a [chunk generator builder type](#chunk-generators)
    - `generatorBuilder: Consumer<ChunkGeneratorBuilder>`{:.language-kube-21}: A callback to edit the properties of the [chunk generator builder](#chunk-generators)
        - The methods available will depend on the `generatorType`{:.v}
    - **Note**: A `minecraft:overworld` dimension *must* be set for the preset to be valid
- `.addToNormalPresetList()`{: .language-kube-21 #world-preset-add-to-normal-preset-list }: Add the preset to the `minecraft:normal` tag so it can be selected in the create world screen
- `.addToHiddenPresetList()`{: .language-kube-21 #world-preset-add-to-hidden-preset-list }: Add the preset to the `minecraft:extended` tag so it is available in the create world screen as a hidden preset
- `.asDefaultPreset()`{: .language-kube-21 #world-preset-as-default-preset }: Makes this preset be selected by default in the create world screen

{: #world-preset-example }

### Example

```js-21
ServerEvents.registry('worldgen/world_preset', event => {
    event.create('cave_world')
        .withDimension(
            'minecraft:overworld',
            'minecraft:overworld_caves',
            'minecraft:noise',
            generator => generator
                .noiseSettings('minecraft:caves')
                .biomeSource(
                    'minecraft:multi_noise',
                    biomeSource => biomeSource
                        .usingParameters(climate => {
                            climate.forBiome('minecraft:plains')
                                .depth(0, 2)
                                .continentalness(0, 2)
                                .erosion(1.5, 2)
                                .humidity(-1, 1)
                                .temperature(1, 2)
                                .weirdness(-2, 2)
                            climate.forBiome('minecraft:ice_spikes')
                                .depth(0, 2)
                                .continentalness(-1 , 2)
                                .erosion(-2, 2)
                                .humidity(-1, 2)
                                .temperature(-2, 1)
                                .weirdness(-2, 0)
                            climate.forBiome('minecraft:flower_forest')
                                .depth(-2, 1)
                                .continentalness(-0.5, 2)
                                .erosion(-2, 2)
                                .humidity(-2, 2)
                                .temperature(-1, 1)
                                .weirdness(-1, 0)
                            climate.forBiome('minecraft:cold_ocean')
                                .depth(-2, 0.25)
                                .continentalness(-2, 0.1)
                                .erosion(-2, 2)
                                .humidity(-2, 2)
                                .temperature(-2, -1)
                                .weirdness(-2, 2)
                            climate.forBiome('minecraft:ocean')
                                .depth(-2, 0.4)
                                .continentalness(-2, 0.1)
                                .erosion(-2, 2)
                                .humidity(-2, 2)
                                .temperature(-1, 2)
                                .weirdness(-2, 2)
                            climate.forBiome('minecraft:lush_caves')
                                .depth(-2, 2)
                                .continentalness(-1, 1)
                                .erosion(0, 2)
                                .humidity(0, 2)
                                .temperature(0.5, 2)
                                .weirdness(0, 2)
                            climate.forBiome('minecraft:deep_dark')
                                .depth(-2, -1.75)
                                .continentalness(1.5, 2)
                                .erosion(-0.1, 0.1)
                                .humidity(1, 2)
                                .temperature(1, 2)
                                .weirdness(1, 2)
                            climate.forBiome('minecraft:deep_dark')
                                .depth(-2, -1.75)
                                .continentalness(1.75, 2)
                                .erosion(0.1, 0.2)
                                .humidity(1.5, 2)
                                .temperature(1.5, 2)
                                .weirdness(0.5, 1)
                            climate.forBiome('minecraft:badlands')
                                .depth(-2, 2)
                                .continentalness(-2, 2)
                                .erosion(-2, 2)
                                .humidity(-2, 2)
                                .temperature(-2, 2)
                                .weirdness(-2, 2)
                                .offset(1)
                        })
                )
        )
        .withDimension(
            'minecraft:the_nether',
            'minecraft:the_nether',
            'minecraft:noise',
            generator => generator
                .noiseSettings('minecraft:nether')
                .biomeSource(
                    'minecraft:fixed',
                    biomeSource => biomeSource
                        .biome('minecraft:nether_wastes')
                )
        )
        .addToNormalPresetList()
        .asDefaultPreset()
})
```

### Chunk Generators

[Chunk generators](https://minecraft.wiki/w/Dimension_definition#Generator_types) define the shape and biomes of a dimension. WorldJS adds builders for the vanilla types, but other addons may add their own types

{% list chunk_gen_filter %}
{% worldjs %}
{% 1.21.1 %}
{% chunk_gen %}
{% endlist %}

{% assign gens = site.fragments | multi_where: 'cat', 'worldjs', '1.21.1', 'chunk_gen' | replace_in_fragments: replacements | clean_fragments | sort: 'title' %}

{% for gen in gens %}

- [`{{ gen.title }}`](#{{ gen.anchor }})

{% endfor %}

{% for gen in gens %}

{: #{{ gen.anchor }} }

#### `{{ gen.title }}`

{{ gen.clean }}

{% endfor %}

### Biome Sources

{% assign biome_sources = site.fragments | multi_where: 'cat', 'worldjs', '1.21.1', 'biome_source' | replace_in_fragments: replacements | clean_fragments | sort: 'title' %}

{% for source in biome_sources %}

- [`{{ source.title }}`](#{{ source.anchor }})

{% endfor %}

{% for source in biome_sources %}

{: #{{ source.anchor }} }

#### `{{ source.title }}`

{{ source.clean }}

{% endfor %}

## Dimension Type

[Dimension types](https://web.archive.org/web/20250612212826/https://minecraft.wiki/w/Dimension_type) define technical properties of a dimension like its building height limits and ambient light. WorldJS adds the ability to create dimension types through KubeJS's `ServerEvents.registry('dimension_type', event => {})`{:.language-kube-21} event vai the default (no type id) builder

{% capture d %}dimension-type-{% endcapture %}

- `.fixedTime(time: int)`{: .language-kube-21 #{{ d }}fixed-time }: Fixes the dimension at the given day time, in ticks
    - Defaults to un-fixed time
- `.withNosSkyLight()`{: .language-kube-21 #{{ d }}with-no-sky-light }: Marks the dimension as not having sky light
- `.withCeiling()`{: .language-kube-21 #{{ d }}with-ceiling }: Marks the dimension as having a *logical* ceiling
    - **Note**: This does not influence the actual generation of a ceiling in the dimension, that is controlled by the [chunk generator](#chunk-generators)
- `.ultraWarm()`{: .language-kube-21 #{{ d }}ultra-warm }: Marks the dimension as being ultra warm. Enables water evaporation and faster lava spread, among other effects
- `.unnatural()`{: .language-kube-21 #{{ d }}unnatural }: Marks the dimension as being unnatural, disabling compasses, beds, creaking spawns, and zombified piglins from spawn in nether portals
- `.disableBeds()`{: .language-kube-21 #{{ d }}disable-beds }: Disallow sleeping in the dimension, causing them to explode on interact
- `.disableRespawnAnchors()`{: .language-kube-21 #{{ d }}disable-respawn-anchors }: Disallow respawn anchors in the dimension, causing them to explode on interact
- `.coordinateScale(scale: number)`{: .language-kube-21 #{{ d }}coordinate-scale }: The multiplier applied to coordinates when leaving the dimension
    - Must be {% in_range 1E-5,3E7 %}
    - Defaults to `1`{:.n}
- `.minY(minY: int)`{: .language-kube-21 #{{ d }}min-y }: The minimum height at which blocks can exist in the dimension
    - Must be {% in_range -2032,2031 %}
    - Must be a multiple of `16`{:.n}
    - Defaults to `-64`{:.n}
- `.height(height: int)`{: .language-kube-21 #{{ d }}height }: The total height in which blocks can exist in the dimension
    - Must be {% in_range 16,4064 %}
    - Must be a multiple of `16`{:.n}
    - The maximum build height ([`minY`{:.v}](#{{ d }}min-y){:.preserve-color} + [`height`{:.v}](#{{ d }}min-y){:.preserve-color} - `1`{:.n}) cannot be greater than 2031
    - Defaults to `384`{:.n}
- `.logicalHeight(height: int)`{: .language-kube-21 #{{ d }}logical-height }: The maximum height 'natural' teleporters (nether portals, chorus fruit) can bring players
    - Must be {% in_range 0,4064 %}
    - Cannot be greater than [`height`{:.v}](#{{ d }}height){:.preserve-color}
    - Defaults to `384`{:.n}
- `.infiniburn(infiniburn: TagKey<Block>)`{: .language-kube-21 #{{ d }}infiniburn }: The blocks on which fires burn indefinitely on
    - Defaults to `'minecraft:infiniburn_overworld'`{:.s}
- `.effects(effects: ResourceLocation)`{: .language-kube-21 #{{ d }}effects }: The previously registered client-side effects of the dimension
    - Controls the cloud height, sky type, ambient light, and light map behaviors
    - Defaults to `'minecraft:overworld'`{:.s}
- `.ambientLight(ambientLight: number)`{: .language-kube-21 #{{ d }}ambient-light }: How much ambient light the dimension has. `0`{:.n} follows the light level and `1`{:.n} has no ambient lighting
    - Defaults to `0`{:.n}
- `.monsterSpawnLightTest(test: IntProvider)`{: .language-kube-21 #{{ d }}monster-spawn-light-test }: The weather-affected maximum light allowed when a mob spawns
    - Must be {% in_range 0,15 %}
    - Defaults to {% range 0,7 %}
- `.monsterSpawnBlockLightLimit(limit: int)`{: .language-kube-21 #{{ d }}monster-spawn-block-light-limit }: The maximum light allowed when a mob spawns
    - Must be {% in_range 0,15 %}
    - Defaults to `7`{:.n}
- `.safeForPiglins()`{: .language-kube-21 #{{ d }}safe-for-piglins }: Disables piglins and hoglins transforming into their zombified variants when in the dimension
- `.noRaids()`{: .language-kube-21 #{{ d }}no-raids }: Disables raids in the dimension

{: #dimension-type-example }

### Example

```js-21
ServerEvents.registry('dimension_type', event => {
    event.create('space')
        .withNoSkyLight()
        .coordinateScale(300)
        .minY(0)
        .height(64)
        .logicalHeight(64)
        .effects('minecraft:the_end')
        .noRaids()
})
```

## Noise Generator Settings

## Biome
