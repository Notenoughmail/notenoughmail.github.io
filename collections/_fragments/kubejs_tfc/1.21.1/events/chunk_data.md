---
type: server
target-type: String
name: createChunkDataProvider
title: Create Chunk Data Provider
anchor: create-chunk-data-provider
cat:
    - kubejs_tfc
    - 1.21.1
    - event
target: nether
example:
    - ''
    - '// Use a LayeredArea for the rocks as noises can be slow when used with the rock rule source'
    - 'const randomSource = event.stableRandomSource()'
    - '// This rock layer mirrors how TFC does its own rock layer'
    - 'const rockLayer = TFC.worldgen.uniformLayeredArea(randomSource.nextLong())'
    - 'for (let i = 0 ; i < 3 ; i++) {'
    - '    rockLayer'
    - '        .zoom(true, randomSource.nextLong())'
    - '        .smooth(randomSource.nextLong())'
    - '}'
    - 'for (let i = 0 ; i < 6 ; i++) {'
    - '    rockLayer.zoom(true, randomSource.nextLong())'
    - '}'
    - 'rockLayer'
    - '    .smooth(randomSource.nextLong())'
    - '    .zoom(true, randomSource.nextLong())'
    - '    .smooth(randomSource.nextLong())'
    - ''
    - '// Since The nether does not have rain, pre-create an empty float layer to use'
    - 'const rain = TFC.worldgen.lerpFloatLayer(0, 0, 0, 0)'
    - 'const tempLayer = TFC.noise.openSimplex2D(event.getWorldSeed() + 7545452354354)'
    - '    .spread(0.2)'
    - '    .octaves(3)'
    - '    scaled(95, 140)'
    - 'const forestLayer = TFC.noise.openSimplex2D9event.getWorldSeed() + 14694769526)'
    - '    .spread(0.8)'
    - '    .terraces(9)'
    - '    .affine(6, 12)'
    - '    .scaled(6, 18, 0, 28)'
    - 'const rockLayerHeightNoise = TFC.noise.openSimplex2D(event.getWorldSeed() + 6315343547)'
    - '    .octaves(6)'
    - '    .scaled(12, 34)'
    - '    .spread(0.009)'
    - ''
    - '// Precompute the aquifer heights as a constant since this is the nether'
    - 'const aquifer = []'
    - 'var i = 0'
    - 'while (1 < 16) {'
    - '    aquifer.push(0)'
    - '    i++'
    - '}'
    - ''
    - 'event.partial(data => {'
    - '    let { pos } = data'
    - '    let { minBlockX: X, minBlockZ: z } = pos'
    - '    var temp = tempLayer.overChunk(pos)'
    - '    data.generatePartial('
    - '        rain,'
    - '        rain,'
    - '        rain,'
    - '        temp,'
    - '        forestLayer.noise(x, z) // Kube accepts ordinal numbers for enum constants'
    - '    )'
    - '})'
    - ''
    - 'event.full((data, chunk) => {'
    - '    var heights = []'
    - '    // In the nether this will always return 127, but this is'
    - '    // included as a demonstration of using height maps and'
    - '    // properly indexing the height values within the array'
    - '    for (let x = 0 ; x < 16 ; x++) {'
    - '         for (let z = 0 ; z < 16 ; z++) {'
    - "             var height = chunk.getHeight('ocean_floor_wg', x, z)"
    - '             heights[x + 16 * z] = height'
    - '         }'
    - '    }'
    - '    data.generateFull(heights, aquifer)'
    - '})'
    - ''
    - 'event.rocks((x, y, z, surfaceY, cache, rockLayers) => {'
    - '    var layer = 0'
    - '    var layerHeight = 0'
    - '    var deltaY = surfaceY - y'
    - ''
    - '    do {'
    - '        // A simplified version of what TFC does for its layer depth'
    - '        // Of note is the lack of skewing for either the rock'
    - '        // layer or the heights and the non-use of the cache'
    - '        layerHeight = rockLayerHeightNoise.noise(x >> 5, z >> 5)'
    - '        if (deltaY <= layerHeight) {'
    - '            break'
    - '        }'
    - '        deltaY -= layerHeight'
    - '        layer++'
    - '    } while (deltaY > 0)'
    - ''
    - '    return rockLayer.sampleAtLayer(rockLayer.getAt(x, z), layer)'
    - '})'
---

When used with a specific chunk generator type, this event allows for custom generation of TFC's [`ChunkData`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#chunk-data), permitting [fauna definitions](#fauna-spawns); [climate placement modifiers]({% link kubejs_tfc/1.21.1/worldgen.md %}#climate); TFC's climate based structure modifier; and many other features which are reliant on the chunk generator being TFC-like to function properly with chunk generator's other than TFC's

{: #{{ page.anchor }}-chunk-generator }

## Chunk Generator

Due to how TFC's chunk data works, this functionality is inherently tied to a `ChunkGenerator`. KubeJS TFC adds a new generator type, `kubejs_tfc:wrapped`, which will wrap any arbitrary chunk generator an imitate its function while providing TFC's additional values

In its json definition, the generator has the following fields

- `type` must be `kubejs_tfc:wrapped`
- `event_key`: The key for which the event is fired for. A string
- `settings`: The same as `tfc_settings` in [TFC's chunk generator type](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/generated/resources/data/tfc/worldgen/world_preset/overworld.json#L11-L408). These values are available during the event via [`.getSettings()`{:.language-kube-21}](#{{ page.anchor }}-get-settings){:.preserve-color}
- `generator`: A [chunk generator](https://minecraft.wiki/w/Dimension_definition?oldid=3350482#Generator_types)

{: #{{ page.anchor }}-chunk-generator-example }

### Example

```json
{
    "type": "kubejs_tfc:wrapped",
    "event_key": "nether",
    "generator": {
        "type": "minecraft:noise",
        "biome_source": {
            "type": "minecraft:multi_noise",
            "preset": "minecraft:nether"
        },
        "settings": "minecraft:nether"
    },
    "settings": {
        "flat_bedrock": true,
        "spawn_distance": 10000,
        "spawn_center_x": 0,
        "spawn_center_z": 0,
        "temperature_scale": 20000,
        "rainfall_scale": 1,
        "continentalness": 0.5,
        "finite_continents": false,
        "grass_density": 0,
        "rock_layer_settings": {
            "rocks": {
                "nether": {
                    "raw": "minecraft:netherack",
                    "hardended": "minecraft:basalt",
                    "gravel": "minecraft:gravel",
                    "cobble": "minecraft:blackstone",
                    "sand": "minecraft:soul_sand",
                    "sandstone": "minecraft:soul_soil"
                }
            },
            "bottom": [ "nether" ],
            "layers": [
                {
                    "id": "nether",
                    "layers": {
                        "nether": "bottom"
                    }
                }
            ],
            "ocean_bottom": [ "nether" ],
            "volcanic": [ "nether" ],
            "land": [ "nether" ],
            "uplift": [ "nether" ]
        }
    }
}
```

{: #{{ page.anchor }}-surface-rule-source }

## Rock Surface Rule Source

In addition, a custom surface rule source that uses the blocks of the `RockSettings`, as provided by the [rocks callback](#{{ page.anchor }}-rocks) of the provider, is available. This rule source only works with the `kubejs_tfc:wrapped` generator  wrapping a `minecraft:noise`[^1] chunk generator

[^1]: Or any generator type which extends `NoisebasedChunkGenerator` and overrides `.buildSurface(ChunkAccess,WorldGenerationContext,RandomState,StructureManager,BiomeManager,Registry<Biome>,Blender)`{:.language-java}

In its json, the rule source has the following fields

- `type` must be `kubejs_tfc:rock`
- `fallback_state`: A [lenient block state](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/common-types/#lenient-blockstate). Used when the `RockSettings` at a position could not be found or the chunk generator is not compatible with this rule source
- `rock_block`: A string, one of `raw`, `hardened`, `gravel`, `cobble`, `sand`, or `sandstone`. Specified which block from the `RockSettings` to use. Optional, defaults to `raw`

{: #{{ page.anchor }}-surface-rule-source-example }

### Example

```json
{
    "type": "kubejs_tfc:rock",
    "rock_block": "sandstone",
    "fallback_state": "minecraft:sandstone"
}
```

{: #{{ page.anchor }}-methods }

## Methods

{% capture exp %}{% link kubejs_tfc/1.21.1/type-explanations.md %}{% endcapture %}

- `.getWorldSeed(): int`{: .language-kube-21 #{{ page.anchor }}-get-world-seed }: Get the world seed
- `.getNormalNoise(id: ResourceKey<NormalNoise$NoiseParameters>): NormalNoise`{: .language-kube-21 #{{ page.anchor }}-get-normal-noise }: Get the `NormalNoise` defined by the noise parameters with the given id
- `.stableRandomSource(): RandomSource`{: .language-kube-21 #{{ page.anchor }}-stable-random-source }: Get a thread-unsafe `RandomSource` seeded by the world seed
- `.unstableRandomSource(): RandomSource`{: .language-kube-21 #{{ page.anchor }}-unstable-random-source }: Get a thread-unsafe `RandomSource` with an arbitrary seed
- `.getSettings(): Settings`{: .language-kube-21 #{{ page.anchor }}-get-settings }: Get the TFC [`Settings`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/settings/Settings.java) of the chunk generator
- `.partial(gen: Consumer<ChunkData>): void`{: .language-kube-21 #{{ page.anchor }}-partial }: Set the calculation for the information required to promote a chunk's `ChunkData` to `partial`{:.e}. [`ChunkData.generatePartial(...)`{:.language-kube-21}]({{ exp }}#chunk-data-generate-partial){:.preserve-color} should be called here. [`ChunkData.generateFull(...)`{:.language-kube-21}]({{ exp }}#chunk-data-generate-full){:.preserve-color} *may* be called here, however chunk information is not available. If a chunk is not promoted to `partial`{:.e}, the provider will automatically do so with `0`{:.n} values
- `.full(gen: BiConsumer<ChunkData, ChunkAccess>): void`{: .language-kube-21 #{{ page.anchor }}-full }: Set the calculation for the information required to promote a chunk's `ChunkData` from `partial`{:.e} to `full`{:.e}. [`ChunkData.generateFull(...)`{:.language-kube-21}]({{ exp }}#chunk-data-generate-full){:.preserve-color} should be called here. If a chunk is not promoted to `full`{:.e}, the provider will automatically do so with values derived from the `ocean_floor_wg`{:.e} heightmap. Accepts a callback with two parameters
    - `data: ChunkData`{:.language-kube-21}: The `ChunkData` being promoted to `full`{:.e}
    - `chunk: ChunkAcess`{:.language-kube-21}: The chunk the data is being generated for. The `ocean_floor_wg` and `world_surface_wg` heightmaps are available
- `.erosionalAquifer(maker: Function<ChunkAccess, Aquifer>): void`{: .language-kube-21 #{{ page.anchor }}-erosional-aquifer }: Set the calculation for the `Aquifer` of a given chunk. The aquifer is used by TFC's erosion feature to place subterranean fluids. If not set, defaults to an aquifer that places air at at y -2^31. Accepts a callback with the params
    - `chunk: ChunkAccess`{:.language-kube-21}: The chunk the aquifer is being generated for
    - `return: Aquifer`{:.language-kube-21}: An `Aquifer`. See [`TFCAquifer`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/TFCAquifer.java) for TFC's implementation
- `.rocks(rocksGetter: RocksGetter): void`{: .language-kube-21 #{{ page.anchor }}-rocks }: Set the calculation for the `RockSettings` at a position. Used by several configured feature types and the [rock surface rule source](#{{ page.anchor }}-surface-rule-source) to determine what blocks to place. If not set, or `null`{:.p} is returned in the callback, a `RockSettings` made entirely of air is used. Accepts a callback with the params
    - `x: int`{:.language-kube-21}: The x coordinate
    - `y: int`{:.language-kube-21}: The y coordinate
    - `z: int`{:.language-kube-21}: The z coordinate
    - `surfaceY: int`{:.language-kube-21}: The surface elevation of the block column, as determined by the surface elevations used to [promote the chunk to `full`{:.e}]({{ exp }}#chunk-data-generate-full)
    - `cache: @Nullable ChunkRockDataCache`{:.language-kube-21}: A potentially `null`{:.p} [`ChunkRockDataCache`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkRockDataCache.java). Holds per-layer height and skew values
    - `rockLayers: RockLayerSettings`{:.language-kube-21}: The [`RockLayerSettings`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/settings/RockLayerSettings.java) defined in the chunk generator's `settings` object. This has a method, `.sampleAtLayer(pointRock: int, layerN: int)`{:.language-kube-21}, which returns a `RockSettings`. The parameters are
        - `pointRock: int`{:.language-kube-21}: A 32-bit signed integer. The top 30 bits are used as a seed for a random number generator used to pick from the layer's mappings for the next layer when `layerN`{:.v} is greater than `0`{:.n}. The bottom two bits are used to select which primary rock type is used at the 0th layer
            - `0b00`{:.n}: Ocean layer
            - `0b01`{:.n}: Volcanic layer
            - `0b10`{:.n}: Land layer
            - `0b11`{:.n}: Uplift layer
        - `layerN: int`{:.language-kube-21}: How many times to iterate to the layer's next layer as described by the layer's mapping. Accepts any non-negative number; the `bottom` pseudo-layer points towards itself
    - `return: RockSettings`{:.language-kube-21}: A [`RockSettings`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/settings/RockSettings.java) describing the rock at the position. Ideally retrieved from `rockLayers`{:.v}

{% comment %}

## fauna spawns

{% endcomment %}
