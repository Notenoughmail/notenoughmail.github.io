---
layout: page
title: Worldgen
permalink: /kubejs_tfc/1.20.1/worldgen/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Worldgen

KubeJS TFC allows user to easily build some of TFC's world generation [features](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/)

In the `TFCEvents.worldgenData` event there are methods for:

- [Geodes](#geodes)
- [Boulders](#boulders)
- [Baby Boulders](#baby-boulders)
- [Thin Spikes](#thin-spikes)
- [Cluster Veins](#cluster-veins)
- [Pipe Veins](#pipe-veins)
- [Disc Veins](#disc-veins)
- [If-Then](#if-then)
- [Soil Disc](#soil-disc)
- [Hot Spring](#hot-spring)
- [Simple Block State](#simple-block-state)
- [Random Patch](#random-patch)
- [Tall Wild Crop](#tall-wild-crop)
- [Spreading Crop](#spreading-crop)
- [Spreading Bush](#spreading-bush)
- [Fissure](#fissure)
- [Forest](#forest)
- [Forest Entry](#forest-entry)
- [Overlay Tree](#overlay-tree)
- [Random Tree](#random-patch)
- [Stacked Tree](#stacked-tree)
- [Krummholz](#krummholz)
- [Generic Features](#generic)

This event goes in the `server_scripts` folder.

{: .notice #general-notice }
> Much of TFC's world generation configuration is done through [tags](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/tags/)
>
> Use the `ServerEvents.tag("worldgen/placed_feature", event => {})`{: .language-kube } event to add/remove entries from the correct tag
>
> Each example has a demonstration of this that uses the appropriate tag for the type it corresponds to

## Geodes

Creates a `tfc:geode` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#geode)!

{: #geode-signature }

### Method Signature

```js
event.geode(
    name: String,
    outer: String,
    middle: String,
    inner: String[],
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the string representation of a block state to be used as the outer block state
- 3rd argument: A string, the string representation of a block state to be used as the middle block state
- 4th argument: A list of strings, weighted string representations of block states to be used as the inner block states
- 5th argument: A [feature placement consumer](#feature-placement)

{: #geode-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.geode('example_geode', 'minecraft:oak_log[axis=z]', 'tfc:rock/hardened/basalt', ['6 tfc:rock/raw/quartzite', 'minecraft:cut_copper'], placement => {
        placement.tfcBiome()
        placement.rarityFilter(500)
        placement.inSquare()
        placement.jsonPlacement({
            type: 'minecraft:height_range',
            height: {
                type: 'uniform',
                min_inclusive: {
                    absolute: -48
                },
                max_inclusive: {
                    absolute: 32
                }
            }
        })
    })
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:in_biome/veins', 'kubejs_tfc:example_geode')
})
```

## Boulders

Creates a `tfc:boulder` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#boulder)!

{: #boulder-signature }

### Method Signature

```js
event.boulder(name: String, states: BoulderState[], placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [boulder states](#boulder-state) that define the blocks the boulder is made up of per rock
- 3rd argument: A [feature placement consumer](#feature-placement)

{: #boulder-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.boulder('ae2:example_boulder', [
        event.boulderState('tfc:rock/raw/dacite', ['ae2:skystone', 'ae2:polished_skystone'])
        event.boulderState('tfc:rock/raw/quartzite', ['ae2:skystone', 'ae2:polished_skystone'])
        event.boulderState('tfc:rock/raw/granite', ['ae2:skystone', 'ae2:polished_skystone'])
    ], placement => {
        placement.rarityFilter(12)
        placement.inSquare()
        placement.heightMap('world_surface_wg')
        placement.flatEnough(flat => {
            flat.flatness(0.4)
        })
    })
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:feature/boulders', 'ae2:example_boulder')
})
```

## Baby Boulders

Creates a `tfc:baby_boulder` configured feature and matching placed feature

{: #baby-boulder-signature }

### Method Signature

```js
event.babyBoulder(name: String, states: BoulderState[], placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [boulder states](#boulder-state) that define the blocks the baby boulder is made up of per rock
- 3rd argument: A [feature placement consumer](#feature-placement)

{: #baby-boulder-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.babyBoulder('example_baby_boulder', [
        event.boulderState('tfc:rock/raw/dolomite', ['minecraft:dirt', 'minecraft:gold_block'])
    ], placement => {
        placement.rarityFilter(45)
        placement.inSquare()
        placement.heightMap('world_surface_wg')
        placement.flatEnough(flat => {
            flat.flatness(0.73)
        })
    })
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:feature/boulders', 'kubejs_tfc:example_baby_boulder')
})
```

## Thin Spikes

Creates a `tfc:thin_spike` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#thin-spike)!

{: #thin-spike-signature }

### Method Signature

```js
event.thinSpike(
    name: String,
    state: String,
    radius: number,
    tries: number,
    minHeight: number,
    maxHeight: number,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the string representation of a block state to place, must be a thin spike block
- 3rd argument: A number, in the range [1, 16], the radius around the target location to place spikes in
- 4th argument: A number, the minimum height of the spike, must be positive
- 5th argument: A number, the maximum height of the spike, must be greater than the minimum height
- 6th argument: A [feature placement consumer](#feature-placement)

{: #thin-spike-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.thinSpike('example_thin_spike', 'kubejs:my_thin_spike', 8, 2, 10, placement => {
        placement.jsonPlacement({
            type: 'minecraft:count',
            count: 4
        })
        placement.inSquare()
        placement.jsonPlacement({
            type: 'minecraft:height_range',
            height: {
                type: 'biased_to_bottom',
                min_inclusive: {
                    absolute: -32
                },
                max_inclusive: {
                    absolute: 100
                }
            }
        })
    })
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:in_biome/underground_decoration', 'kubejs_tfc:example_thin_spike')
})
```

## Cluster Veins

Creates a `tfc:cluster_vein` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/veins/)!

{: #cluster-vein-signature }

### Method Signature

```js
event.clusterVein(
    name: String,
    replacementMap: BlockToWeightedBlockStateMapEntry[],
    rarity: number,
    density: number,
    minY: number,
    maxY: number,
    size: number,
    optionals: Consumer<BuildVeinProperties>,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [blocks to weighted block states](#blocks-to-block-states-replacement-entry), defines the replacement map of the vein
- 3rd argument: A number, defines the rarity of the vein in `1/N`{: .language-kube } chunks
- 4th argument: A number, in the range [0, 1], defines the density of the vein
- 5th argument: A number, the minimum y level the vein can spawn at
- 6th argument: A number, the maximum y level the vein can spawn at
- 7th argument: A number, the size of the vein
- 8th argument: A [vein properties consumer](#vein-properties) that defines the optional parameters of the vein
- 9th argument: A [feature placement consumer](#feature-placement)

{: #cluster-vein-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.clusterVein(
        'example_cluster_vein', [
            event.blockToWeightedBlockState(['tfc:rock/raw/dacite', 'tfc:rock/raw/granite'], ['8 minecraft:oak_log[axis=z]', 'minecraft:gold_block']),
            event.blockToWeightedBlockState(['tfc:rock/raw/andesite', 'tfc:rock/raw/rhyolite'], ['15 minecraft:dirt_block', '2 minecraft:moss_block'])
        ], 43, 0.75, -64, 15, 20, vein => {
            vein.indicator(15, 5, 7, 3, ['minecraft:diamond_block', '7 minecraft:iron_bars'])
            vein.nearLava(true)
        }, placement => {}
    )
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:in_biome/veins', 'kubejs_tfc:example_cluster_vein')
})
```

## Pipe Veins

Creates a `tfc:pipe-vein` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/veins/)!

{: #pipe-vein-signature }

### Method Signature

```js
event.pipeVein(
    name: String,
    replacementMap: BlockToWeightedBlockStateMapEntry[],
    rarity: number,
    density: number,
    minY: number,
    maxY: number,
    height: number,
    radius: number,
    minSkew: number,
    maxSkew: number,
    minSlant: number,
    maxSlant: number,
    sign: number,
    optionals: Consumer<BuildVeinProperties>,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [blocks to weighted block states](#blocks-to-block-states-replacement-entry), defines the replacement map of the vein
- 3rd argument: A number, defines the rarity of the vein in `1/N`{: .language-kube } chunks
- 4th argument: A number, in the range [0, 1], defines the density of the vein
- 5th argument: A number, the minimum y level the vein can spawn at
- 6th argument: A number, the maximum y level the vein can spawn at
- 7th argument: A number, the height of the vein
- 8th argument: A number, the radius of the vein
- 9th argument: A number, the minimum skew of the vein
- 10th argument: A number, the maximum skew of the vein
- 11th argument: A number, the minimum slant of the vein
- 12th argument: A number, the maximum slant of the vein
- 13th argument: A number, in the range [0, 1], the sign of the vein
- 14th argument: A [vein properties consumer](#vein-properties)
- 15th argument: A [feature placement consumer](#feature-placement)

{: #pipe-vein-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.pipeVein(
        'example_pipe_vein', [
            event.blockToWeightedBlockState(['tfc:rock/raw/shale', 'tfc:rock/raw/limestone'], ['7 minecraft:spruce_log[axis=z]', 'minecraft:stripped_spruce_log']),
            event.blockToWeightedBlockState(['tfc:rock/raw/chert', 'tfc:rock/raw/basalt'], ['minecraft:sponge'])
        ], 48, 0.43, -64, 100, 30, 4, 0, 2, 0, 4, 0.5, vein => {
            vein.indicator(15, 5, 7, 3, ['minecraft:sponge'])
            vein.project(true)
        }, placement => {}
    )
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:in_biome/veins', 'kubejs_tfc:example_pipe_vein')
})
```

## Disc Veins

Creates a `tfc:disc_vein` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/veins/)!

{: #disc-vein-signature }

### Method Signature

```js
event.discVein(
    name :string,
    replacementMap: BlockToWeightedBlockStateMapEntry[],
    rarity: number,
    density: number,
    minY: number,
    maxY: number,
    size: number,
    height: number
    optionals: Consumer<BuildVeinProperties>,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [blocks to weighted block states](#blocks-to-block-states-replacement-entry), defines the replacement map of the vein
- 3rd argument: A number, defines the rarity of the vein in 1/N chunks
- 4th argument: A number, in the range [0, 1], defines the density of the vein
- 5th argument: A number, the minimum y level the vein can spawn at
- 6th argument: A number, the maximum y level the vein can spawn at
- 7th argument: A number, the size of the vein
- 8th argument: A number, the height of the vein
- 9th argument: A [vein properties consumer](#vein-properties)
- 10th argument: A [feature placement consumer](#feature-placement)

{: #disc-vein-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.discVein(
        'example_disc_vein', [
            event.blockToWeightedBlockState(['tfc:rock/raw/dolomite'], ['kubejs:my_cool_ore', '15 kubejs:my_less-cool_ore'])
        ], 75, 0.15, -64, -32, 12, 3, vein => {
            vein.nearLava(true)
        }, placement => {}
    )
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:in_biome/veins', 'kubejs_tfc:example_disc_vein')
})
```

## If-Then

Creates a `tfc:if_then` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#if-then)!

{: #if-then-signature }

### Method Signature

```js
event.ifThen(name: String, if: String, then: String, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the id of a placed feature that will always try to place
- 3rd argument: A string, the id of a placed feature that will only place if the first feature places
- 4th argument: A [feature placement consumer](#feature-placement)

## Soil Disc

Creates a `tfc:soil_disc` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#soil-disc)!

{: #soil-disc-signature }

### Method Signature

```js
event.soilDisc(
    name: String,
    replacementMap: BlockToBlockStateMapEntry[],
    minRadius: number,
    maxRadius: number,
    height: number,
    integrity: @Nullable number,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [block to block state entries](#block-to-block-state-replacement-entry), defines the replacement map of the soil disc
- 3rd argument: A number, the minimum radius of the disc
- 4th argument: A number, the maximum radius of the disc
- 5th argument: A number, the height of the disc
- 6th argument: A number, in the range [0, 1], specifies the probability that any given block in the disc will place, may be `null`{:.p} to specify the default value of `1`{:.n}
- 7th argument: A [feature placement consumer](#feature-placement)

{:# soil-disc-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.soilDisc('example_soil_disc', [
        event.blockToBlockState('tfc:dirt/loam', 'kubejs:dirt')
        event.blockToBlockState('tfc:grass/loam', 'kubejs:dirt_grass')
    ], 3, 16, 5, 0.8, placement => {
        placement.climate(climate => {
            climate.minTemp(-3)
            climate.maxTemp(7)
        })
    })
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:in_biome/soil_discs/hills', 'kubejs_tfc:example_soil_disc')
})
```

## Hot Spring

Creates a `tfc:hot_spring` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#hot-spring)!

{: #hot-spring-signature }

### Method Signature

```js
event.hotSpring(
    name: String,
    wallState: @Nullable String,
    fluidState: String,
    radius: number,
    allowUnderwater: boolean,
    replacesFluidOnContact: @Nullable BlockToWeightedBlockStateMapEntry[],
    decoration: @Nullable FissureDecoration,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the block state to use for the hot spring, may be null to use the lowest rock layer
- 3rd argument: A string, the fluid to fill the spring with, may be air
- 4th argument: A number, in the range [1, 16], the approximate radius of the spring
- 5th argument: A boolean, if the hot spring should be allowed to generate underwater
- 6th argument: A list of [blocks to weighted block states](#blocks-to-block-states-replacement-entry), the blocks to place if placed underwater, may be `null`{:.p}
- 7th argument: A [fissure decoration](#fissure-decoration) object, may be `null`{:.p}
- 8th argument: A [feature placement consumer](#feature-placement)

{: #hot-spring-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.hotSpring('example_hot_Spring', 'minecraft:deepslate', 'minecraft:lava', 8, true, [
        event.blockToBlockState('tfc:rock/raw/dacite', 'tfc:rock/hardened/phyllite')
    ], event.fissureDecoration([
        event.blockToWeightedBlockState(['tfc:dirt/loam', 'tfc:grass/loam'], ['8 minecraft:stone', 'minecraft:cobblestone']),
        event.blockToWeightedBlockState(['tfc:dirt/sandy_loam', 'tfc:grass/sandy_loam'], ['minecraft:gold_block'])
    ], 5, 23, 40), placement => {}
    )
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:in_biome/large_features/old_mountains', 'kubejs_tfc:example_hot_spring')
})
```

## Simple Block State

Creates a `minecraft:simple_block` configured feature using a simple state provider

Notably used by TFC for its wild crops in tandem with [random patch](#random-patch) features

{: #simple-block-state-signature }

### Method Signature

```js
event.simpleBlockState(name: String, blockState: String, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string representation of a blockstate, the state to be placed
- 3rd argument: A [feature placement consumer](#feature-placement)

{: #simple-block-state-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.simpleBlockState('example_crop_placement', 'kubejs:example_crop', placement => {
        placement.heightMap('world_surface_wg')
        placement.jsonPlacement({
            type: 'block_predicate_filter',
            predicate: {
                type: 'tfc:replaceable'
            }
        })
        placement.jsonPlacement({
            type: 'block_predicate_filter',
            predicate: {
                type: 'would_survive',
                state: {
                    Name: 'kubejs:example_crop',
                    Properties: {}
                }
            }
        })
    })
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:feature/crops', 'kubejs_tfc:example_crop_placement')
})
```

## Random Patch

Creates a `minecraft:random_patch` configured feature

{: #random-patch-signature }

### Method Signature

```js
event.randomPatch(
    name: String,
    tries: @Nullable number,
    xzSpread: @Nullable number,
    ySpread: @nullable number,
    feature: String,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A number, how many times the feature should attempt to place, may be `null`{:.p} to default to `128`{:.n}
- 3rd argument: A number, the horizontal spread of the patch, may be `null`{:.p} to default to `7`{:.n}
- 4th argument: A number, the vertical spread of the patch, may be `null`{:.p} to default to `3`{:.n}
- 5th argument: A string, the name of the feature to attempt to place
- 6th argument: A [feature placement consumer](#feature-placement)

{: #random-patch-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.randomPatch('example_crop_patch', 30, 15, 10, 'kubejs_tfc:example_crop_placement', placement => {
        placement.rarityFilter(80)
        placement.inSquare()
        placement.climate(climate => {
            climate.minTemp(5)
            climate.maxTemp(18)
            cliamte.maxForest('normal')
        })
    })
})
ServerEvents.tags('worldgen/placed_feature', event => {
    event.add('tfc:feature/crops', 'kubejs_tfc:example_crop_patch')
})
```

{: .notice #random-patch-notice }
> This feature type places multiple of another feature, which may also have its own placement filters. Those filters will apply after this feature's placement filters.
>
> In this pair of examples, the patch feature limits where the crops can be placed and how often they appear in the world, while the individual block feature specifies local restrictions on placement.
>
> The placement filters of these examples mirror those used by TFC's crops

## Tall Wild Crop

Creates a `tfc:tall-wild_crop` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#tall-wild-crop)!

{: #tall-wild-crop-signature }

### Method Signature

```js
event.tallWildCrop(name: String, block: String, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the block to place, must be an instance of [WildDoubleCropBlock]({% link kubejs_tfc/1.20.1/custom.md %}#wild_crop)
- 3rd argument: A [feature placement consumer](#feature-placement)

## Spreading Crop

Creates a `tfc:spreading_crop` configured feature and matching placed feature

```js
event.spreadingCrop(name: String, block: String, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the block to place, must be an instance of [WildSpreadingCropBlock]({% link kubejs_tfc/1.20.1/custom.md %}#wild-crops)
- 3rd argument: A [feature placement consumer](#feature-placement)

## Spreading Bush

Creates a `tfc:spreading_bush` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#spreading-bush)!

{: #spreading-crop-signature }

### Method Signature

```js
event.spreadingBush(name: String, block: String, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the block to place, must be an instance of [SpreadingBushBlock]({% link kubejs_tfc/1.20.1/custom.md %}#spreading-berry-bush)
- 3rd argument: A [feature placement consumer](#feature-placement)

## Fissure

Creates a `tfc:fissure` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#fissure)!

{: #fissure-signature }

### Method Signature

```js
event.fissure(
    name: String,
    wallState: @Nullable String,
    fluidState: String,
    count: @Nullable number,
    radius: @Nullable number,
    minDepth: @Nullable JsonObject,
    minPieces: @Nullable number,
    maxPieces: @Nullable number,
    maxPieceLength: @Nullable number,
    fissureDecoration: @Nullable FissureDecoration,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string representation of a block state, the block to use for the walls of the fissure. May be `null`{:.p} to use the existing blocks for the walls
- 3rd argument: A string representation of a block state, the block to use as the fluid of the fissure. May be air
- 4th argument: A number, how many fissures to place. May be `null`{:.p} to default to `5`{:.n}
- 5th argument: A number, How far from the target position to place fissures. May be `null`{:.p} to default to `12`{:.n}
- 6th argument: A `JsonObject`, the [vertical anchor](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/common-types/#vertical-anchor) to tie the fissure to. May be `null`{:.p}
- 7th argument: A positive number, the minimum number of segments a fissure can be made up of. May be `null`{:.p} to default to `10`{:.n}
- 8th argument: A positive number, the maximum number of segments a fissure can be made up of. May be `null`{:.p} to default to `24`{:.n}
- 9th argument: A positive number, the maximum length a fissure segment can be. May be `null`{:.p} to default to `6`{:.n}
- 10th argument: A [fissure decoration](#fissure-decoration) object, may be `null`{:.p}
- 11th argument: A [feature placement consumer](#feature-placement)

{: #fissure-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.fissure(
        'example_fissure',
        null,
        'minecraft:lava',
        3,
        15,
        {
            above_bottom: 17
        },
        5,
        null,
        12,
        event.fissureDecoration([
            event.blockToWEightedBlockState([
                'tfc:rock/raw/chert',
                'tfc:rock/raw/dacite'
            ], [
                '7 minecraft:deepslate[axis=z]',
                '7 minecraft:deepslate[axis=x]',
                '7 minecraft:deepslate[axis=y]',
                'minecraft:cobblestone'
            ])
        ], 5, 3, 17),
        placement => {
            placement.climate(climate => {
                climate.minTemp(20)
            })
        }
    )
})
```

## Forest

Creates a `tfc:forest` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/trees/#forest-feature)!

{: #forest-signature }

### Method Signature

```js
event.forest(
    name: String,
    entriesTag: String,
    types: ForestTypesMapEntry[],
    useWeirdness: @Nullable boolean,
    placement: Consumer<PlacedFeatureProeprties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, a configured feature tag. All elements of the tag must be [forest entries](#forest-entry)
- 3rd argument: A list of [forest type map entries](#forest-types-map-entry). There must be an entry for every `ForestType`{:.e}
- 4th argument: A boolean, if forest weirdness should be used to smooth the edges between forest entries. May be `null`{:.p} to default to `true`{:.p}
- 5th argument: A [feature placement consumer](#feature-placement)

{: #forest-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.forest(
        'example_forest',
        'kubejs:example_forest_entries',
        [
            event.forestTypesMapEntry('none', null, null, 0, null, null, null, null),
            event.forestTypesMapEntry('sparse', [ 0, 1 ], null, 0.1, null, false, false, null),
            event.forestTypesMapEntry('edge', [ 0, 2 ], null, 0.2, null, false, false, null),
            event.forestTypesMapEntry('normal', [ 1, 9 ], [ 2, 3 ], 0.5, null, false, false, [ 0, 2 ]),
            event.forestTypesMapEntry('old_growth', [ 3, 15 ], [ 2, 5 ], 0.7, [ 0, 5 ], true, true, [ 1, 3 ])
        ],
        null,
        placement => {}
    )
})
```

## Forest Entry

Creates a `tfc:forest_entry` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/trees/#forest-entry)!

{: #forest-entry-signature }

### Method Signature

```js
event.forestEntry(
    name: String,
    climate: Consumer<ClimateModifer>,
    bushLog: @Nullable String,
    bushLeaves: @Nullable String,
    fallenLog: @Nullable String,
    fallenleaves: @Nullable String,
    groundCover: String @Nullable [],
    normalTreeFeature: String,
    deadTreeFeature: String,
    oldGrowthTreeFeature: @Nullable String,
    krummholzFeature: @Nullable String,
    oldGrowthChance: @Nullable number,
    spoilerOldGrowthChance: @Nullable number,
    fallenTreeChance: @Nullable number,
    deadChance: @Nullable number,
    floating: @Nullable boolean,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A [climate modifier](#climate)
- 3rd argument: A string, the block to use for the log of bushes. May be `null`{:.p} to not have bushes
- 4th argument: A string, the block to use for the leaves of bushes. May be `null`{:.p} to not have bushes
- 5th argument: A string, the block to place for the logs of fallen trees. May be `null`{:.p} to not have fallen trees
- 6th argument: A string, the block to place for the leaves of fallen trees. May be `null`{:.p} to not have fallen trees
- 7th argument: A list of strings, each the string representation of a weighted block state, the blocks to be placed for other ground cover. May be `null`{:.p}
- 8th argument: A string, the id of a configure feature to place for normal trees. See [overlay](#overlay-tree), [random](#random-tree), and [stack](#stacked-tree) trees
- 9th argument: A string, the id of a configured feature to place for dead trees
- 10th argument: A string, the id of a configured feature to place for old growth trees. May be `null`{:.p} to not have old growth trees
- 11th argument: A string, the id of a configured feature to place for krummholz. May be `null`{:.p} to not have krummholz
- 12th argument: A number, the chance, as `1 / N`{: .language-kube }, a tree will be old growth. May be `null`{:.p} to default to `6`{:.n}
- 13th argument: A number, the chance, as `1 / N`{: .language-kube }, an old growth tree will be placed in non-old-growth forests. May be `null`{:.p} to default to `200`{:.n}
- 14th argument: A number, the chance, in `1 / N`{: .language-kube } chunks, a fallen tree will spawn. May be `null`{:.p} to default to `14`{:.n}
- 15th argument: A number, the chance, as `1 /N`{: .language-kube }, a tree will be a dead tree on place. May be `null`{:.p} to default to `75`
- 16th argument: A boolean, if the placement height should use the world surface instead of ocean floor. May be `null`{:.p} to default to `false`{:.p} (ocean floor)
- 17th argument: A [feature placement consumer](#feature-placement)

{: #forest-entry-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.forestEntry(
        'example_forest_entry',
        climate => {
            climate.minRain(325)
        },
        'tfc:wood/log/oak',
        'tfc:wood/leaves/oak',
        null,
        null,
        null,
        'tfc:tree/oak',
        'kubejs_tfc:example_tree',
        'tfc:tree/pine_large',
        null,
        80,
        53,
        null,
        62,
        true,
        placement => {}
    )
})
```

## Overlay Tree

Creates a `tfc:overlay_tree` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/trees/#overlay-tree)!

{: #overlay-tree-signature }

### Method Signature

```js
event.overlayTree(
    name: String,
    baseStructure: String,
    overlayStructure: String,
    trunk: @Nullable Trunk,
    overlayIntegrity: @Nullable number,
    treeplacement: TreePlacement,
    rootSystem: @Nullable Root,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the id of a structure. The base structure to place
- 3rd argument: A string, the id of a structure. The overlay structure to place
- 4th argument: A [trunk](#trunk). The trunk below the structure. May be `null`{:.p}
- 5th argument: A number, in the range [0, 1], the percentage of the overlay structure that will be placed. may be `null`{:.p} to default to `0.5`{:.n}
- 6th argument: A [tree placement](#tree-placement)
- 7th argument: A [root](#root), may be `null`{:.p}
- 8th argument: A [feature placement consumer](#feature-placement)

{: #overlay-tree-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.overlayTree(
        'example_tree',
        'tfc:white_cedar/base',
        'tfc:white_cedar/overlay',
        event.trunk('minecraft:dirt', 0, 3, false),
        0.3,
        event.treePlacement(1, 5, 'shallow_water'),
        null,
        placement => {}
    )
})
```

## Random Tree

Creates a `tfc:random_tree` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/trees/#random-tree)!

{: #random-tree-signature }

### Method Signature

```js
event.randomTree(
    name: String,
    structure: String[],
    trunk: @Nullable Trunk,
    treePlacement: TreePlacement,
    rootSystem: @Nullable Root,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of strings, the ids of structures to place at random
- 3rd argument: A [trunk](#trunk). The trunk below the structure. May be `null`{:.p}
- 4th argument: A [tree placement](#tree-placement)
- 5th argument: A [root](#root), may be `null`{:.p}
- 6th argument: A [feature placement consumer](#feature-placement)

{: #random-tree-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.randomTree(
        'willow_replica',
        [ 
            'tfc:willow/1',
            'tfc:willow/2',
            'tfc:willow/3'
        ],
        null,
        event.treePlacement(1, 3, 'shallow_water'),
        event.root([
            event.blockToWeightedBlockState([ 'tfc:grass/silt' ], [ 'tfc:rooted_dirt/silt' ]),
            event.blockToWeightedBlockState([ 'tfc:dirt/silt' ], [ 'tfc:rooted_dirt/silt' ])
        ], 4, 2, 15, null, null),
        placement => {}
    )
})
```

## Stacked Tree

Creates a `tfc:stacked_tree` configured feature and matching placed feature

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/trees/#stacked-tree)!

{: #stacked-tree-signature }

### Method Signature

```js
event.stackedTree(
    name: String,
    layers: TreeLayer[],
    trunk: Trunk,
    treePlacement: TreePlacement,
    rootSystem: @Nullable Root,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [tree layers](#tree-layer)
- 3rd argument: A [trunk](#trunk)
- 4th argument: A [tree placement](#tree-placement)
- 5th argument: A [root](#root), may be `null`{:.p}
- 6th argument: A [feature placement consumer](#feature-placement)

{: #stacked-tree-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.stackedTree(
        'example_stacked_tree',
        [
            event.treeLayer([ 'tfc:douglas_fir_large/layer1_1', 'tfc:douglas_fir_large/layer1_2' ], 2, 3),
            event.treeLayer([ 'tfc:douglas_fir_large/layer2_1', 'tfc:douglas_fir_large/layer2_2' ], 2, 4)
        ],
        event.trunk('minecraft:oak_log', 1, 5, false),
        event.treePlacement(5, 2, null),
        null,
        placement => {}
    )
})
```

## Krummholz

Creates a `tfc:krummholz` configured feature and matching placed feature

{: #krummholz-signature }

### Method Signature

```js
event.krummholz(
    name: String,
    block: String,
    height: IntProvider,
    spawnsOnStone: @Nullable boolean,
    spawnsOnGravel: @Nullable boolean,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the id of the block to place
- 3rd argument: An `IntProvider`, how high the krummholz may be
- 4th argument: A boolean, if the krummholz can spawn on stone. May be `null`{:.p} to default to `false`
- 5th argument: A boolean, if the krummholz can spawn on gravel. May be `null`{:.p} to default to `false`
- 6th argument: A [feature placement consumer](#feature-placement)

{: #krummholz-example }

### Example

```js
TFCEvents.worldgenData(event => {
    event.krummholz(
        'example_krummholz',
        'tfc:plant/spruce_krummholz',
        [ 1, 4 ],
        true,
        false,
        placement => {}
    )
})
```

## Generic

Creates a configured feature of the given type using the given config

{: #generic-feature-signature }

### Method Signature

```js
event.generic(name: String, type: String, featureConfig: JsonObject, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature; if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the type of configured feature to be created
- 3rd argument: A json object, the `config` object of a normal configured feature
- 4th argument: A [feature placement consumer](#feature-placement)

## Boulder State

This defines an entry to a boulder feature's `state` value

{: #boulder-state-signature }

### Method Signature

```js
event.boulderState(rock: String, blockStates: String[])
```

- 1st argument: The registry name of a block, the raw rock block of a rock layer for the `blockStates` to spawn in
- 2nd argument: A list of block states in their string representation, i.e. `minecraft:grass[snowy=true]`, the blocks to be placed for the boulder in that rock

See the [boulder](#boulders) example for an example of usage

## Blocks to Block States Replacement Entry

This defines an entry to a blocks to weighted blockstates map

{: #block-to-block-states-replacement-entry-signature }

### Method Signature

```js
event.blockToWeightedBlockState(replace: String[], with: String[])
```

- 1st argument: A list of strings, the registry name of blocks to be replaced
- 2nd argument: A list of strings, string representations of a weighted block state, i.e. `8 minecraft:oak_log[axis=z]`, the blocks to be placed as part of the vein

See the [cluster](#cluster-veins), [pipe](#pipe-veins), and [disc](#disc-veins) vein examples for usage

## Block to Block State Replacement Entry

This defines an entry to a block to blockstate map

{: #block-to-block-state-replacement-entry-signature }

### Method Signature

```js
event.blockToBlockState(block: String, state: String)
```

- 1st argument: A string, the block to be replaced
- 2nd argument: A string representation of a block state, the state to be placed

## Fissure Decoration

Hot springs and fissures may have additional decorations around them, this is used to define them

{: #fissure-decoration-signature }

### Method Signature

```js
event.fissureDecoration(
    replacementMap: BlockToWeightedBlockStateMapEntry[],
    rarity: number,
    radius: number,
    count: number
)
```

- 1st argument: A list of [blocks to weighted block states](#blocks-to-block-states-replacement-entry), the additional ores that should spawn around the fissure
- 2nd argument: A number, the rarity of blocks being replaced
- 3rd argument: A number, the radius around the fissure that blocks should be replaced
- 4th argument: A number, the number of blocks that should be placed, actual amount will be `count / rarity`{: .language-kube }

## Forest Types Map Entry

Defines an entry in a `ForestType`{:.e} to forest properties map

For an example, see the [forest](#forest-example) example

{: #forest-types-map-entry-signature }

### Method Signature

```js
event.forestTypesMapEntry(
    type: ForestType,
    treeCount: @Nullable IntProvider,
    groundcoverCount: @Nullable IntProvider,
    perChunkChance: @Nullable number,
    bushCount: @Nullable IntProvider,
    hasSpoilerOldGrowth: @Nullable boolean,
    allowsOldGrowth: @Nullable boolean,
    leafPileCount: @Nullable IntProvider
)
```

- 1st argument: A `ForestType`{:.e}, the key in the map. May be `none`{:.e}, `sparse`{:.e}, `edge`{:.e}, `normal`{:.e}, or `old_growth`{:.e}
- 2nd argument: An `IntProvider`, how many trees should spawn. May be `null`{:.p} to default to `[ 0, 0 ]`{: .language-kube }
- 3rd argument: An `IntProvider`, how much ground cover should spawn. May be `null`{:.p} to default to `[ 0, 0 ]`{: .language-kube }
- 4th argument: A number, in the range [0, 1], per chunk, that forests will spawn. May be `null`{:.p} to default to `1`{:.n}
- 5th argument: An `IntProvider`, how many bushes will try to spawn. May be `null`{:.p} to not have bushes
- 6th argument: A boolean, if old growth trees will randomly spawn among existing tree. May be `null`{:.p} to default to `false`{:.p}
- 7th argument: A boolean, if old growth trees spawn in this forest type. May be `null`{:.p} to default to `false`{:.p}
- 8th argument: A `IntProvider`, how many leaf piles to place. May be `null`{:.p} to default to `[ 0, 0 ]`{: .language-kube }

## Trunk

Creates a new trunk object for use with [overlay](#overlay-tree), [random](#random-tree), and [stacked](#stacked-tree) trees

Used to add extra height to tree structures for variance within forests. See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/trees/#trunk)!

For an example, see the [stacked tree](#stacked-tree-example) example

{: #trunk-signature }

### Method Signature

```js
event.trunk(
    state: String,
    minHeight: number,
    maxHeight: number,
    wide: boolean
)
```

- 1st argument: A string representation of a block state, the state to place as the trunk
- 2nd argument: A number, the minimum height of the trunk
- 3rd argument: A number, the maximum height of the trunk
- 4th argument: A boolean, if the trunk is 2x2

## Tree Placement

Creates a new tree placement object for use with [overlay](#overlay-tree), [random](#random-tree), and [stacked](#stacked-tree) trees

Used to determine the where the tree can place. See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/trees/#tree-placement)!

For an example, see the [stacked tree](#stacked-tree-example) example

{: #tree-placement-signature }

### Method Signature

```js
event.treePlacement(
    width: number,
    height: number,
    groundType: @Nullable GroundType
)
```

- 1st argument: A non-negative number, the horizontal distance to check
- 2nd argument: A non-negative number, the vertical distance to check
- 3rd argument: A `GroundType`{:.e}, determines what sort of ground to spawn in. Accepts `normal`{:.e}, `sand`{:.e}, `shallow_water`{:.e}, `submerged`{:.e}, `shallow_allow_saltwater`{:.e}, `submerged_allow_saltwater`{:.e}, or `floating`{:.e}. May be `null`{:.p} to default to `normal`{:.e}

## Root

Creates a new root object for use with [overlay](#overlay-tree), [random](#random-tree), and [stacked](#stacked-tree) trees

Used to replace the soil around a tree, akin to vanilla's spruce trees and podzol

For an example, see the [random tree](#random-tree-example) example

{: #root-signature }

### Method Signature

```js
event.root(
    blocks: BlockToWeightedBlockStateMapEntry[],
    width: @Nullable number,
    height: @Nullable number,
    tries: @Nullable number,
    specialPlacerSkewChance: @Nullable number,
    required: @Nullable number
)
```

- 1st argument: A list of [blocks to weighted block states](#blocks-to-block-states-replacement-entry), what soil blocks should be replaced with
- 2nd argument: A number, the horizontal distance to attempt to place roots. May be `null`{:.p} to default to `4`{:.n}
- 3rd argument: A number, the vertical distance to attempt to place roots. May be `null`{:.p} to default to `3`{:.n}
- 4th argument: A number, how many attempts should be made to place roots. May be `null`{:.p} to default to `5`{:.n}
- 5th argument: A number, the chance, in the range [0, 1], for extra roots to be placed. May be `null`{:.p}
- 6th argument: A boolean, if roots must be placed. May be `null`{:.p} to default to `false`{:.p}

## Tree layer

Create a tree layer for use with [stacked trees](#stacked-tree)

Used to provide a variety of structures to create a stacked appearance

{: #tree-layer-signature }

### Method Signature

```js
event.treelayer(
    templates: String[],
    minCount: number,
    maxCount: number
)
```

- 1st argument: A list of strings, the ids of structures to choose from for this layer
- 2nd argument: A number, the minimum number of structures to have in this layer
- 3rd argument: A number, the maximum number of structures to have in this layer

## Vein Properties

When creating veins in TFC, certain parameters are optional. This is used to define those optional values

### Indicator

Defines the vein's indicator

Method signature:

```js
vein.indicator(depth: number, rarity: number, undergroundRarity: number, undergroundCount: number, indicators: String[])
```

- 1st argument: A number, the number of blocks above the top of the vein the indicators may spawn
- 2nd argument: A number, how rare the indicator blocks should be
- 3rd argument: A number, how rare underground indicators should be
- 4th argument: A number, the number of indicators should spawn underground (i.e. in caves)
- 5th argument: A list of strings, string representations of a weighted block state

### Project

Determines the `project` value of the vein

Method signature:

```js
vein.project(b: boolean)
```

- 1st argument: A boolean, defaults to false

### Project Offset

Determines the `project_offset` value of the vein

Method signature:

```js
vein.projectOffset(b: boolean)
```

- 1st argument: A boolean, defaults to false

### Biomes

Determines the `biomes` values of the vein

Method signature:

```js
vein.biomes(biomeTag: String)
```

- 1st argument: A string, a biome tag that the vein may spawn in, defaults to allowing all biomes

### Near Lava

Determines the `near_lava` value of the vein

Method signature:

```js
vein.nearLava(b: boolean)
```

- 1st argument: A boolean, defaults tot false

## Feature Placement

World generation features are made up of two parts, their configuration and their placement, typically in separate files, but due to not being restricted to using raw json files, KubeJS TFC allows you to define a feature's placement with its configuration through a feature placement consumer. Several of the methods can be seen in the above examples, but a full list will be provided here:

### Simple Placement

Adds a placement of the provided type with no arguments

Method signature:

```js
placement.simplePlacement(type: String)
```

- 1st argument: A string, the type of the placement modifier to be added

### Json Placement

Adds the provided json object as a placement modifier

Method signature:

```js
placement.jsonPlacement(json: JsonObject)
```

- 1st argument: A json object to be added as a placement modifier

### TFC Biome

Adds a placement modifier of type `tfc:biome`

Method Signature:

```js
placement.tfcBiome()
```

### Climate

Adds a placement modifier of type `tfc:climate`

Method signature:

```js
placement.climate(climate: Consumer<ClimateModifier>)
```

- 1st argument: A consumer with several methods:
    - `.minRain(f: number)`{: .language-kube #climate-placement-min-rain }: Accepts a number, sets the minimum rainfall
    - `.maxRain(f: number)`{: .language-kube #climate-placement-max-rain }: Accepts a number, sets the maximum rainfall
    - `.minTemp(f: number)`{: .language-kube #climate-placement-min-temp }: Accepts a number, sets the minimum temperature
    - `.maxTemp(f: number)`{: .language-kube #climate-placement-max-temp }: Accepts a number, sets the maximum temperature
    - `.minForest(forest: String)`{: .language-kube #climate-placement-min-forest }: Accepts `none`{:.e}, `sparse`{:.e}, `edge`{:.e}, `normal`{:.e}, and `old_growth`{:.e}, sets the minimum forest level
    - `.maxForest(forest: String)`{: .language-kube #climate-placement-max-forest }: Accepts `none`{:.e}, `sparse`{:.e}, `edge`{:.e}, `normal`{:.e}, and `old_growth`{:.e}, sets the maximum forest level
    - `.fuzzy(b: boolean)`{: .language-kube #climate-placement-fuzzy }: Accepts a boolean, determines if the temperature and rainfall calculations should be probabilistic relative to the center point

### Flatness

Adds a placement modifier of type `tfc:flat_enough`

Method signature:

```js
placement.flatEnough(flatness: Consumer<FlatnessModifier>)
```

- 1st argument: A consumer with several methods:
    - `.flatness(f: number)`{: .language-kube #flat-placement-flatness }: Accepts a number, in the range [0, 1], sets the required flatness of the surrounding area, defaults to `0.5`{:.n}
    - `.radius(i: number)`{: .language-kube #flat-placement-radius }: Accepts a number, sets the radius around the initial position the area is checked for flatness, defaults to `2`{:.n}
    - `.maxDepth(i: number)`{: .language-kube #flat-placement-max-depth }: Accepts a number, sets how deep from the initial position the modifier should search, defaults to `4`{:.n}

### Near Water

Adds a placement modifier of type `tfc:near_water`

Method signature:

```js
placement.nearWater(radius: number)
```

- 1st argument: A number, sets the `radius` property of the modifier

### Shallow Water

Adds a placement modifier of type `tfc:shallow_water`

Method Signature:

```js
placement.shallowWater(depth: number)
```

- 1st argument: A number, sets the `max_depth` property of the modifier

### Underground

Adds a placement modifier of type `tfc:underground`

Method signature:

```js
placement.underground()
```

### Volcano

Adds a placement modifier of type `tfc:volcano`

Method signature:

```js
placement.volcano(center: boolean, distance: number)
```

- 1st argument: A boolean, if true the feature will be placed at the exact center of the volcano and disregard the `distance`{:.v} parameter
- 2nd argument: A number, in the range [0, 1], sets the distance from the center of the volcano the feature needs to generate

### In Square

Adds a placement modifier of type `minecraft:in_square`

Method signature:

```js
placement.inSquare()
```

### Rarity Filter

Adds a placement modifier of type `minecraft:rarity_filter`

Method signature:

```js
placement.rarityFilter(chance: number)
```

- 1st argument: A number, sets the `chance` property of the modifier

### Height Map

Adds a placement modifier of type `minecraft:heightmap`

Method signature:

```js
placement.heightMap(heightMap: String)
```

- 1st argument: A string, the name of the height map to use

{% comment %}

### Forest Example

### Stacked Tree Example

### Random Tree Example

{% endcomment %}
