---
s: chunk_data
title: '`ChunkData`'
anchor: chunk-data
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

`ChunkData` is TFC's additional data it attaches to chunks during world generation for use during after world generation. It has the following methods available

{% capture lerp %}[`LerpFloatLayer`]({% link kubejs_tfc/1.21.1/bindings/worldgen.md %}#lerp-flaot-layer){% endcapture %}

- `.getPos(): ChunkPos`{: .language-kube-21 #{{ page.anchor }}-get-pos }: Get the `ChunkPos` the data is attached to
- `.getRockData(): RockData`{: .language-kube-21 #{{ page.anchor }}-get-rock-data }: Get the chunk's [`RockData`](#{{ page.anchor }}-rock-data)
- `.getAquiferSurfaceHeights(): int[16]`{: .language-kube-21 #{{ page.anchor }}-get-aquifer-surface-heights }: Gets the chunk's aquifer surface heights as an array of `16`{:.n}[^1] `int`{:.p}s representing the aquifer surface elevations
- `.getMinRainfallHydration(pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-min-rainfall-hydration }: Get the minimum hydration a block at the given position can experience due to rain
- `.getMaxRainfallHydration(pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-max-rainfall0hydration }: Get the maximum hydration a block at the given position can experience due to rain
- `.getAverageRainfall(pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-average-rainfall-0 }: Get the time-invariant rainfall at the given position
- `.getAverageRainfall(x: int, z: int): number`{: .language-kube-21 #{{ page.anchor }}-get-average-rainfall-1 }: Get the time-invariant rainfall at the given position
- `.getRainVariance(pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-rain-variance-0 }: Get the rain variance at the given position
- `.getRainVariance(x: int, z: int): number`{: .language-kube-21 #{{ page.anchor }}-get-rain-variance-1 }: Get the rain variance at the given position
- `.getBaseGroundwater(pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-base-groundwater }: Get the base groundwater at the given position
- `.getBaseGroundwater(x: int, z: int): number`{: .language-kube-21 #{{ page.anchor }}-get-base-groundwater-1 }: Gets the base groundwater at the given position
- `.getAverageGroundwater(pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-average-groundwater-0 }: Get the time-invariant total groundwater (rivers + rainfall) at the given position
- `.getAverageGroundwater(x: int, z: int): number`{: .language-kube-21 #{{ page.anchor }}-get-average-groundwater-1 }: Get the time-invariant total groundwater (rivers + rainfall) at the given position
- `.getAverageSeaLevelTemp(pos: BlockPos): number`{: .language-kube-21 #{{ page.anchor }}-get-average-sea-level-temp-0 }: Get the average sea-level temperature at the given position
- `.getAverageSeaLevelTemp(x: int, z: int)`{: .language-kube-21 #{{ page.anchor }}-get-average-sea-level-temp-1 }: Get the average sea-level temperature at the given position
- `.getForestType(): ForestType`{: .language-kube-21 #{{ page.anchor }}-get-forest-type }: Get the [`ForestType`{:.e}](#forest-type-enum){:.preserve-color} of the chunk
- `.status(): ChunkData$Status`{: .language-kube-21 #{{ page.anchor }}-status }: Get the `Status`{:.e} of the chunk
- `.lastRandomTick(): int`{: .language-kube-21 #{{ page.anchor }}-last-random-tick }: The last [calendar timestamp](#icalendar-get-timestamp) the chunk was random ticked in
- `.setLastRandomTick(chunk: ChunkAccess, lastRandomTick: int): void`{: .language-kube-21 #{{ page.anchor }}-set-last-random-tick }: Sets the last random tick of the chunk
    - `chunk: ChunkAccess`{:.language-kube-21}: The chunk the data is for, required to mark it as unsaved and sync the data to clients
    - `lastRandomTick: int`{:.language-kube-21}: The calendar tick at which the chunk was last randomly ticked
- `.getNextSnowPos(chunkPos: ChunkPos): BlockPos`{: .language-kube-21 #{{ page.anchor }}-get-next-snow-pos }: Get the next position that will be snowed on in the chunk, the y-coordinate will always be 0
- `.iterateSnowPos(chunk: ChunkAccess): void`{: .language-kube-21 #{{ page.anchor }}-iterate-snow-pos }: Moves the chunk to the next snow pos and marks the chunk as unsaved
- `.generatePartial(rainfallLayer: LerpFloatLayer, rainVarianceLayer: LerpFLoatLayer, baseGroundwaterLayer: LerpFloatLayer, temperatureLayer: LerpFloatLayer, forestType: ForestType): void`{: .language-kube-21 #{{ page.anchor }}-generate-partial }: Promotes the chunk data from `empty`{:.e} to `partial`{:.e} status by setting some of its properties
    - `rainfallLayer: LerpFloatLayer`{:.language-kube-21}: A {{ lerp }} of the yearly average rainfall at the corners of the chunk. Used in the default climate model to determine the rainfall at a position
    - `rainVarianceLayer: LerpFloatLayer`{:.language-kube-21}: A {{ lerp }} of the rainfall variance at the corners of the chunk. used by the default climate model for rain variance at a point
    - `baseGroundwaterLayer: LerpFloatLayer`{:.language-kube-21}: A {{ lerp }} of the base groundwater at the corners of the chunk. Used by the default climate model for base groundwater values
    - `temperatureLayer: LerpFloatLayer`{:.language-kube-21}: A {{ lerp }} of the average temperature at the corners of the chunk. Used by the default climate model for average seal-level temperatures
    - `forestType: ForestType`{:.language-kube-21}: The [`ForestType`{:.e}](#forest-type-enum){:.preserve-color} of the chunk
- `.generateFull(surfaceHeight: int[256], aquiferSurfaceHeight: int[16]): void`{: .language-kube-21 #{{ page.anchor }}-generate-full }: Promotes the chunk data from `partial`{:.e} to `full`{:.e} by setting the surface heights
    - `surfaceHeight: int[256]`{:.language-kube-21}: An array of integer values of size `256`{:.n}[^2] representing the surface height of the world. Values are indexed as `x + 16 * z`{:.language-kube-21} where `x` and `z` are the local x and z coordinates within the chunk and are {% in_range 0,15 %}. For custom chunk data providers, this is where the `surfaceY`{:.v} parameters of the `RocksGetter`{:.f} [callback]({% link kubejs_tfc/1.21.1/events.md %}#{{ page.anchor }}-provider-rocks) is gotten from
    - `aquiferSurfaceHeights[16]`{:.language-kube-21}: An array of integer values of size `16`{:.n}[^1] representing the height of aquifer surfaces. Only used by [`TFCAquifer`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/TFCAquifer.java)s
- `.modifyBaseGroundwater(surfaceHeight: int[256]): void`{: .language-kube-21 #{{ page.anchor }}-modify-base-groundwater }: Tweaks the chunks base groundwater layer according to the surface height
- `.modifyBaseGroundwaterPoint(height: int, startingWater: number): number`{: .language-kube-21 #{{ page.anchor }}-modify-base-groundwater-point }: Modifies an individual groundwater point, used by [`.modifyBaseGroundwater(int,number)`{:.language-kube-21}](#{{ page.anchor }}-modify-base-groundwater){:.preserve-color}

[^1]: `4`{:.n} * `4`{:.n}; `QuartPos` resolution
[^2]: `16`{:.n} * `16`{:.n}; `BlockPos` resolution

{: #{{ page.anchor }}-rock-data }

## `RockData`

`RockData` is a component of `ChunkData` focusing on rock-related information

- `.getSurfaceRock(x: int, z: int): RockSettings`{: .language-kube-21 #{{ page.anchor }}-rock-data-get-surface-rock }: Get the 'surface' (`y` = `0`{:.n}) [`RockSettings`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/settings/RockSettings.java)
- `.getRock(pos: BlockPos): RockSettings`{: .language-kube-21 #{{ page.anchor }}-rock-data-get-rock-0 }: Get the [`RockSettings`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/settings/RockSettings.java) at the position
- `.getRock(x: int, y: int, z: int): RockSettings`{: .language-kube-21 #{{ page.anchor }}-rock-data-get-rock-1 }: Get the [`RockSettings`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/world/settings/RockSettings.java) at the position

{% comment %}

## forest type enum

## icalendar-get-timestamp

{% endcomment %}
