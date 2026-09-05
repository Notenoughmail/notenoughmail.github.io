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

{% capture required %}**Must** be set{% endcapture %}
{% capture def_0 %}Defaults to `0`{:.n}{% endcapture %}

{% map replacements %}
{% required %}{{ required }}{% end_required %}
{% def_0 %}{{ def_0 }}{% end_def_0 %}
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

{% assign gens = site | fragments_replace: replacements, 'worldjs', '1.21.1', 'chunk_gen' | sort: 'title' %}

{% for gen in gens %}

- [`{{ gen.title }}`](#{{ gen.anchor }})

{% endfor %}

{% for gen in gens %}

{: #{{ gen.anchor }} }

#### `{{ gen.title }}`

{{ gen.clean }}

{% endfor %}

### Biome Sources

{% assign biome_sources = site | fragments_replace: replacements, 'worldjs', '1.21.1', 'biome_source' | sort: 'title' %}

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
    - {{ def_0 }}
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

{% capture n %}noise-generator-settings-{% endcapture %}
{% capture density %}[`DensityFunction`]({% link worldjs/1.21.1/wrappers.md %}#density-function){% endcapture %}

[Noise generator settings](https://minecraft.wiki/w/Noise_settings?oldid=3691431) define the parameters used for the shape of terrain in [noise-based](#chunk-generator-noise) chunk generators. WorldJS adds the ability to create noise generator settings through KubeJS's `ServerEvents.registry('worldgen/noise_settings', event => {})`{:.language-kube-21} event via the default (no type id) builder

- `.noiseSettings(minY: int, height: int, horizontalSize: int, verticalSize: int)`{: .language-kube-21 #{{ n }}noise-settings }: The world settings
    - `minY: int`{:.language-kube-21}: The minimum y coordinate where terrain will generate
        - Must be {% in_range -2032,2031 %}
        - Must be divisible by `16`{:.n}
        - Defaults to `-64`{:.language-kube-21}
    - `height: int`{:.language-kube-21}: The total height where terrain will generate
        - Must be {% in_range 0,4064 %}
        - Must be divisible by `16`{:.n}
        - `height`{:.v} plus `minY`{:.v} may not exceed `2032`{:.n}
        - Defaults to `384`{:.n}
    - `horizontalSize: int`{:.language-kube-21}: The horizontal size of the noise
        - Must be {% in_range 1,4 %}
        - Defaults to `1`{:.n}
    - `verticalSize: int`{:.language-kube-21}: The vertical size of the noise
        - Must be {% in_range 1,4 %}
        - Defaults to `2`{:.n}
- `.defaults(block: BlockState, fluid: BlockState)`{: .language-kube-21 #{{ n }}defaults }: The default block and fluid of the world
    - `block: BlockState`{:.language-kube-21}: The default block used for terrain
    - `fluid: BlockState`{:.language-kube-21}: The default block used for seas and lakes
    - {{ required }}
- `.noiseRouter(router: NoiseRouter)`{: .language-kube-21 #{{ n }}noise-router }: The density functions used for [generation parameters](https://minecraft.wiki/w/Noise_router?oldid=2780412). Can be made as an object with the following params:
    - `barrierNoise: DensityFunction`{:.language-kube-21}: The {{ density }} for separation of aquifers and open areas in caves
        - {{ required }}
    - `fluidLevelFloodednessNoise: DensityFunction`{:.language-kube-21}: The {{ density }} for the probability of generating fluids in a cave for aquifers
        - Values will be clamped to {% range -1,1 %}
        - {{ required }}
    - `fluidLevelSpreadNoise: DensityFunction`{:.language-kube-21}: The {{ density }} for the height of the liquid surface at a horizontal position
        - {{ required }}
    - `lavaNoise: DensityFunction`{:.language-kube-21}: The {{ density }} for if an aquifer should use lava instead
        - The threshold is `0.3`{:.n}
        - {{ required }}
    - `temperature: DensityFunction`{:.language-kube-21}: The {{ density }} for the temperature value used in biome placement
        - {{ required }}
    - `vegetation: DensityFunction`{:.language-kube-21}: The {{ density }} for the humidity value used in biome placement
        - {{ required }}
    - `continents: DensityFunction`{:.language-kube-21}: The {{ density }} for the continentalness value used in biome placement
        - {{ required }}
    - `erosion: DensityFunction`{:.language-kube-21}: The {{ density }} for the erosion values used in biome and aquifer placement
        - {{ required }}
    - `depth: DensityFunction`{:.language-kube-21}: The {{ density }} for the depth values used in biome and aquifer placement
        - {{ required }}
    - `ridges: DensityFunction`{:.language-kube-21}: The {{ density }} for the weirdness values in biome placement
        - {{ required }}
    - `initialDensityWithoutJaggedness: DensityFunction`{:.language-kube-21}: The {{ density }} for used for the initial terrain height for world generation
        - {{ required }}
    - `finalDesnity: DensityFunction`{:.language-kube-21}: The {{ density }} for determining if air or a [default block](#{{ n }}defaults) is placed
        - If positive, a block that can be replaced by the [surface rule]({{ n }}surface-rule). Otherwise, an air block where aquifers can generate
        - {{ required }}
    - `veinToggle: DensityFunction`{:.language-kube-21}: The {{ density }} for special, large ore veins
        - If greater than `0`{:.n} the vein is copper
        - If less than or equal to `0`{:.n} the vein is iron
        - {{ required }}
    - `veinRidged: DensityFunction`{:.language-kube-21}: The {{ density }} for which blocks are part of a vein
        - If greater than or equal to `0`{:.n}, the block is not part of a vein
        - If less than `0`{:.n}, the block is either the vein's stone or ore block
        - {{ required }}
    - `veinGap: DensityFunction`{:.language-kube-21}: The {{ density }} for determining which blocks in a vein are ore blocks
        - {{ required }}
    - {{ required }}
- `.surfaceRule(source: RuleSource)`{: .language-kube-21 #{{ n }}surface-rule }: The [surface rule source]({% link worldjs/1.21.1/wrappers.md %}#surface rule source) for the terrain's blocks
    - {{ required }}
- `.addSpawnTarget(builder: Consumer<ParameterEntry>)`{: .language-kube-21 #{{ n }}add-spawn-target }: Add a climate parameter point for where the player is allowed to spawn. The consumer has the methods available on [`ParameterEntry`s of noise biome sources](#biome-source-multi-noise-climate-parameter-entry)
- `.seaLevel(seaLevel: int)`{: .language-kube-21 #{{ n }}sea-level }: The (world generation) sea level
- `.disableMobGeneration()`{: .language-kube-21 #{{ n }}disable-mob-generation }: Disables mob generation on chunk load
- `.disableAquifers()`{: .language-kube-21 #{{ n }}disable-aquifers }: Disables the generation of aquifers
- `.disableOreVeins()`{: .language-kube-21 #{{ n }}disable-ore-veins }: Disables the generation of special ore veins
- `.useLegacyRandomSource()`{: .language-kube-21 #{{ n }}use-legacy-random-source }: Use the pre-1.18 random number generator

{: #noise-generator-settings-example }

### Example

```js
ServerEvents.registry('worldgen/noise_settings', event => {
    event.create('noisy')
        .defaults('minecraft:pink_glazed_terracotta', 'minecraft:lava')
        .noiseRouter({
            barrierNoise: {
                noise: {
                    noise: 'minecraft:aquifer_barrier',
                    xz_scale: 1,
                    y_scale: 1
                }
            },
            fluidLevelFloodednessNoise: {
                noise: {
                    noise: 'minecraft:aquifer_fluid_level_floodedness',
                    xz_scale: 1,
                    y_scale: 1
                }
            },
            fluidLevelSpreadNoise: {
                noise: {
                    noise: 'minecraft:aquifer_fluid_level_spread',
                    xz_scale: 1,
                    y_scale: 1
                }
            },
            lavaNoise: {
                noise: {
                    noise: 'minecraft:aquifer_lava',
                    xz_scale: 1,
                    y_scale: 1
                }
            },
            temperature: {
                cube: {
                    squeeze: {
                        mul: {
                            first: 0.1,
                            second: {
                                noise: {
                                    noise: 'minecraft:temperature',
                                    xz_scale: 0.13,
                                    y_scale: 1
                                }
                            }
                        }
                    }
                }
            },
            vegetation: 2,
            continents: {
                beardifier: {}
            },
            erosion: {
                end_islands: {}
            },
            depth: -2,
            ridges: {
                square: {
                    y_clamped_gradient: {
                        from_y: -64,
                        to_y: 320,
                        from_value: -3.68,
                        to_value: 1.49
                    }
                }
            },
            initialDensityWithoutJaggedness: 5,
            finalDensity: 5.1,
            veinToggle: 0,
            veinRidged: 0,
            veinGap: 0
        })
        .disableOreVeins()
        .seaLevel(92)
        .surfaceRule([
            {
                condition: {
                    if_true: {
                        noise_threshold: {
                            noise: 'minecraft:surface',
                            min_threshold: 0.2,
                            max_threshold: 0.8
                        }
                    },
                    then_run: 'badlands'
                }
            },
            {
                condition: {
                    if_true: {
                        y_above: {
                            anchor: 120,
                            surface_depth_multiplier: 1
                        }
                    },
                    then_run: 'minecraft:lime_stained_glass'
                }
            },
            'minecraft:pink_glazed_terracotta'
        ])
        .addSpawnTarget(builder =>
            builder.humidity(2)
                .temperature(-0.1, 0.1)
                .depth(-2)
        )
})
```

## Biome

[Biomes](https://minecraft.wiki/w/Biome_definition?oldid=2731942) define the environment of a location in the world. WorldJS adds the ability to create new biomes through KubeJS's `ServerEvents.registry('worldgen/biome', event => {})`{:.language-kube-21} event via the default (no type id) builder

{% capture b %}biome-{% endcapture %}

- `.temperature(temp: number)`{: .language-kube-21 #{{ b }}temperature }: Controls the grass/foliage color and height-adjusted temperature. Not related to the `temperature`{:.v} of [noise generators](#noise-generator-settings)
    - {{ def_0 }}
- `.downfall(downfall: number)`{: .language-kube-21 #{{ b }}downfall }: Controls the grass/foliage color
    - {{ def_0 }}
- `.fogColor(color: KubeColor)`{: .language-kube-21 #{{ b }}fog-color }: The color used for fog
    - {{ def_0 }}
- `.waterColor(color: KubeColor)`{: .language-kube-21 #{{ b }}water-color }: The color used for water blocks and cauldrons
    - {{ def_0 }}
- `.waterFogColor(color: KubeColor)`{: .language-kube-21 #{{ b }}water-fog-color }: The color used for water fog
    - {{ def_0 }}
- `.skyColor(color: KubeColor)`{: .language-kube-21 #{{ b }}sky-color }: The color used for the sky
    - {{ def_0 }}
- `.foliageColor(color: KubeColor)`{: .language-kube-21 #{{ b }}foliage-color }: The color used for leaves and vines
    - If not set, a color derived from the [`temperature`{:.v}](#{{ b }}temperature){:.preserve-color} and [`downfall`{:.v}](#{{ b }}downfall){:.preserve-color} is used
- `.grassColor(color: KubeColor)`{: .language-kube-21 #{{ b }}grass-color }: The color used for grass blocks, short and tall grass, (tall) ferns, and sugarcane
    - If not set, a color derived from the [`temperature`{:.v}](#{{ b }}temperature){:.preserve-color} and [`downfall`{:.v}](#{{ b }}downfall){:.preserve-color} is used
- `.grassColorModifier(modifier: GrassColorModifier)`{: .language-kube-21 #{{ b }}grass-color-modifier }: A modifier to apply to the grass color
    {% include enum_list.html summary='Reveal/hide valid grass color modifiers' values='none,dark_forest,swamp' %}
    Mods may add additional values
    - Defaults to `none`{:.e}
- `.particle(particleOptions: ParticleOptions, probability: number)`{: .language-kube-21 #{{ b }}particle }: The ambient particle of the biome
    - `particleOptions: ParticleOptions`{:.language-kube-21}: The particle to spawn
    - `probability: number`{:.language-kube-21}: How often the particle spawns
- `.ambientSound(sound: Holder$Reference<SoundEvent>)`{: .language-kube-21 #{{ b }}ambient-sound }: The ambient sound
- `.moodSound(sound: Holder$Reference<SoundEvent>, tickDelay: int, blockSearchExtent: int, offset: number)`{: .language-kube-21 #{{ b }}mood-sound }: The [mood](https://minecraft.wiki/w/Ambience#Mood_algorithm) properties
    - `sound: Holder$Reference<SoundEvent>`{:.language-kube-21}: The mood sound
    - `tickDelay: int`{:.language-kube-21}: The minimum delay between two plays
    - `blockSearchExtent: int`{:.language-kube-21}: The range at which the mood algorithm can check
    - `offset: number`{:.language-kube-21}: How far the sound source should be from the player
- `.additionsSound(sound: Holder$Reference<SoundEvent>, tickChance: double)`{: .language-kube-21 #{{ b }}additions-sound }: Settings for additions sound
    - `sound: Holder$Reference<SoundEvent>`{:.language-kube-21}: The sound to play
    - `tickChance: number`{:.language-kube-21}: The chance the sound will play each tick
- `.music(sound: Holder$Reference<SoundEvent>, minDelay: int, maxDelay: int, replaceCurrentMusic: boolean)`{: .language-kube-21 #{{ b }}music }: Specific music that should play in the biome
    - `sound: Holder$Refence<SoundEvent>`{:.language-kube-21}: The music sound
    - `minDelay: int`{:.language-kube-21}: The minimum delay between two music tracks
    - `maxDelay: int`{:.language-kube-21}: The maximum delay between two music tracks
    - `replaceCurrentMusic: boolean`{:.language-kube-21}: If currently playing music should be replaced
- `.temperatureModifier(modifier: TemperatureModifier)`{: .language-kube-21 #{{ b }}temperature-modifier }: Modifier for the temperature before calculating the height adjusted temperature
    {% include enum_list.html summary='Reveal/hide valid temperature modifiers' values='none,frozen' %}
    - Defaults to `none`{:.e}
- `.withoutPrecipitation()`{: .language-kube-21 #{{ b }}without-precipitation }: Disables precipitation in the biome
- `.carving(carvingStep: GenerationStep$Carving, carver: HolderSet<ConfiguredWorldCarver<?>>)`{: .language-kube-21 #{{ b }}carving }: The world carvers to use in the given carving step
    - `carvingStep: GenerationStep$Carving`{:.language-kube-21}: The carving step
        {% include enum_list.html summary='Reveal/hide valid carving steps' values='air,liquid' %}
    - `carver: HolderSet<ConfiguredWorldCarver<?>>`{:.language-kube-21}: The carvers that will carve during the given `carvingStep`{:.v}
- `.features(step: GenerationStep$Decoration, feature: HolderSet<PlacedFeature>)`{: .language-kube-21 #{{ b }}features }: The placed features to place in the given decoration step
    - `step: GenerationStep$Decoration`{:.language-kube-21}: The decoration step to place `feature`{:.v} in
        {% include enum_list.html summary='Reveal/hide valid decoration steps' values='raw_generation,lakes,local_modifications,underground_structures,surface_structures,strongholds,underground_ores,underground_decoration,fluid_springs,vegetal_decoration,top_layer_modification' %}
    - `feature: HolderSet<PlacedFeature>`{:.language-kube-21}: The placed features that will be placed during the decoration `step`{:.v}
- `.addSpawn(category: MobCategory, type: EntityType<?>, weight: int, minCount: int, maxCount: int)`{: .language-kube-21 #{{ b }}add-spawn }: Add a mob spawn
    - `category: MobCategory`{:.language-kube-21}: The category of the spawn
        {% include enum_list.html summary='Reveal/hide valid mob categories' values='monster,creature,ambient,axolotls,underground_water_creature,water_creature,water_ambient,misc' %}
    - `type: EntityType<?>`{:.language-kube-21}: The entity type to spawn
    - `weight: int`{:.language-kube-21}: How often the mob should spawn. Higher values means more spawns
    - `minCount: int`{:.language-kube-21}: The minimum number of the mob to spawn
    - `maxCount: int`{:.language-kube-21}: The maximum number of the mob to spawn
- `.addMobCharge(type: EntityType<?>, charge: number, energyBudget: number)`{: .language-kube-21 #{{ b }}add-mob-charge }: Add a spawn cost for an entity
    - `type: EntityType<?>`{:.language-kube-21}: The entity type to add a spawn cost for
    - `charge: number`{:.language-kube-21}: The charge of the mob
    - `energyBudget: number`{:.language-kube-21}: The mob's maximum potential
- `.creatureSpawnProbability(probability: number)`{: .language-kube-21 #{{ b }}creature-spawn-probability }: The probability of creatures being spawned during world generation
    - Must be {% in_range 0,0.9999999 %}
    - Defaults to `0.1`{:.n}

{: #biome-example %}

### Example

```js-21
ServerEvents.registry('worldgen/biome', event => {
    event.create('juice')
        .temperature(0.4)
        .downfall(2)
        .fogColor('#e83581')
        .waterColor('#e83581')
        .waterFogColor('#e83581')
        .skyColor('#e23aac')
        .foliageColor('#e9c034')
        .grassColor('#8662bb')
        .ambientSound('kubejs:juice/ambient')
        .moodSound('kubejs:juice/mood', 200, 4, 1.4)
        .additionsSound('kubejs:juice/additions', 0.2)
        .music('kubejs:juice/music', 200, 500, true)
        .carving('air', '#kubejs:silly_straws')
        .features('lakes', '#kubejs:juice_pools')
        .features('underground_ores', '#kubejs:gushers')
        .features('fluid_springs', '#kubejs:soda_machines')
        .features('underground_structures', ['kubejs:juice_dungeon'])
        .addSpawn('water_ambient', 'juice_mod:juice_fish', 100, 5, 17)
})
```

{% comment %}

## chunk generator noise

## biome source multi noise climate parameter entry

{% endcomment %}
