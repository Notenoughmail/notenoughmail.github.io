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

{: .notice }
> Much of TFC's world generation configuration is done through [tags](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/tags/)
>
> Use the `ServerEvent.tag('worldgen/placed_feature', event => {})` event to add to/remove entries from the correct tag
>
> Each example will have a demonstration of this with using the appropriate tag for the example

## Geodes

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#geode)!

### Method Signature

```ts
event.geode(name: string, outer: string, middle: string, inner: List<string>, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the string representation of a block state to be used as the outer block state
- 3rd argument: A string, the string representation of a block state to be used as the middle block state
- 4th argument: A list of strings, weighted string representations of block states to be used as the inner block states
- 5th argument: A [feature placement consumer](#feature-placement)

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#boulder)!

### Method Signature

```ts
event.boulder(name: string, states: List<BoulderState>, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [boulder states](#boulder-state) that define the blocks the boulder is made up of per rock
- 3rd argument: A [feature placement consumer](#feature-placement)

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

### Method Signature

```ts
event.babyBoulder(name: string, states: List<BoulderState>, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [boulder states](#boulder-state) that define the blocks the baby boulder is made up of per rock
- 3rd argument: A [feature placement consumer](#feature-placement)

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#thin-spike)!

### Method Signature

```ts
event.thinSpike(name: string, state: string, radius: number, tries: number, minHeight: number, maxHeight: number, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the string representation of a block state to place, must be a thin spike block
- 3rd argument: A number, in the range [1, 16], the radius around the target location to place spikes in
- 4th argument: A number, the minimum height of the spike, must be positive
- 5th argument: A number, the maximum height of the spike, must be greater than the minimum height
- 6th argument: A [feature placement consumer](#feature-placement)

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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/veins/)!

### Method Signature

```ts
event.clusterVein(
    name: string,
    replacementMap: List<BlockToWeightedBlockStateMapEntry>,
    rarity: number,
    density: number,
    minY: number,
    maxY: number,
    size: number,
    optionals: Consumer<BuildVeinProperties>,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [VeinReplacementEntries](#blocks-to-block-states-replacement-entry), defines the replacement map of the vein
- 3rd argument: A number, defines the rarity of the vein in 1/N chunks
- 4th argument: A number, in the range [0, 1], defines the density of the vein
- 5th argument: A number, the minimum y level the vein can spawn at
- 6th argument: A number, the maximum y level the vein can spawn at
- 7th argument: A [vein properties consumer](#vein-properties) that defines the optional parameters of the vein
- 8th argument: A [feature placement consumer](#feature-placement)

### Example

```js
TFCEvents.worldgenData(event => {
    event.clusterVein(
        'example_cluster_vein', [
            event.veinReplacement(['tfc:rock/raw/dacite', 'tfc:rock/raw/granite'], ['8 minecraft:oak_log[axis=z]', 'minecraft:gold_block']),
            event.veinReplacement(['tfc:rock/raw/andesite', 'tfc:rock/raw/rhyolite'], ['15 minecraft:dirt_block', '2 minecraft:moss_block'])
        ], 43, 0.75, -64, 15, vein => {
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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/veins/)!

### Method Signature

```ts
event.pipeVein(
    name: string,
    replacementMap: List<BlockToWeightedBlockStateMapEntry>,
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

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [vein replacement entries](#blocks-to-block-states-replacement-entry), defines the replacement map of the vein
- 3rd argument: A number, defines the rarity of the vein in 1/N chunks
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

### Example

```js
TFCEvents.worldgenData(event => {
    event.pipeVein(
        'example_pipe_vein', [
            event.veinReplacement(['tfc:rock/raw/shale', 'tfc:rock/raw/limestone'], ['7 minecraft:spruce_log[axis=z]', 'minecraft:stripped_spruce_log']),
            event.veinReplacement(['tfc:rock/raw/chert', 'tfc:rock/raw/basalt'], ['minecraft:sponge'])
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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/veins/)!

### Method Signature

```ts
event.discVein(
    name :string,
    replacementMap: List<BlockToWeightedBlockStateMapEntry>,
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

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [vein replacement entries](#blocks-to-block-states-replacement-entry), defines the replacement map of the vein
- 3rd argument: A number, defines the rarity of the vein in 1/N chunks
- 4th argument: A number, in the range [0, 1], defines the density of the vein
- 5th argument: A number, the minimum y level the vein can spawn at
- 6th argument: A number, the maximum y level the vein can spawn at
- 7th argument: A number, the size of the vein
- 8th argument: A number, the height of the vein
- 9th argument: A [vein properties consumer](#vein-properties)
- 10th argument: A [feature placement consumer](#feature-placement)

### Example

```js
TFCEvents.worldgenData(event => {
    event.discVein(
        'example_disc_vein', [
            event.veinReplacement(['tfc:rock/raw/dolomite'], ['kubejs:my_cool_ore', '15 kubejs:my_less-cool_ore'])
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

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#if-then)!

### Method Signature

```ts
event.ifThen(name: string, if_: string, then: string, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the id of a placed feature that will always try to place
- 3rd argument: A string, the id of a placed feature that will only place if the first feature places
- 4th argument: A [feature placement consumer](#feature-placement)

## Soil Disc

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#soil-disc)!

### Method Signature

```ts
event.soilDisc(
    name: string,
    replacementMap: List<BlockToBlockStateMapEntry>,
    minRadius: number,
    maxRadius: number,
    height: number,
    integrity: @Nullable number,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A list of [block to block state entries](#block-to-block-state-replacement-entry), defines the replacement map of the soil disc
- 3rd argument: A number, the minimum radius of the disc
- 4th argument: A number, the maximum radius of the disc
- 5th argument: A number, the height of the disc
- 6th argument: A number, in the range [0, 1], specifies the probability that any given block in the disc will place, may be null to specify the default value of `1`
- 7th argument: A [feature placement consumer](#feature-placement)

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
ServerEvents.tags('worldgen/placed_features', event => {
    event.add('tfc:in_biome/soil_discs/hills', 'kubejs_tfc:example_soil_disc')
})
```

## Hot Spring

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#hot-spring)!

### Method Signature

```ts
event.hotSpring(
    name: string,
    wallState: @Nullable string,
    fluidState: string,
    radius: number,
    allowUnderwater: boolean,
    replacesFluidOnContact: @Nullable List<BlockToWeightedBlockStateMapEntry>,
    decoration: @Nullable FissureDecoration,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the block state to use for the hot spring, may be null to use the lowest rock layer
- 3rd argument: A string, the fluid to fill the spring with, may be air
- 4th argument: A number, in the range [1, 16], the approximate radius of the spring
- 5th argument: A boolean, if the hot spring should be allowed to generate underwater
- 6th argument: A list of [blocks to weighted block states](#blocks-to-block-states-replacement-entry), the blocks to place if placed underwater, may be null
- 7th argument: A [fissure decoration](#fissure-decoration) object, may be null
- 8th argument: A [feature placement consumer](#feature-placement)

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
ServerEvents.tags('worldgen/placed_features', event => {
    event.add('tfc:in_biome/large_features/old_mountains', 'kubejs_tfc:example_hot_spring')
})
```

## Simple Block State

Creates a `minecraft:simple_block` configured feature using a simple state provider

### Method Signature

```ts
event.simpleBlockState(name: string, blockState: string, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string representation of a blockstate, the state to be placed
- 3rd argument: A [feature placement consumer](#feature-placement)

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
ServerEvents.tags('worldgen/placed_features', event => {
    event.add('tfc:feature/crops', 'kubejs_tfc:example_crop_placement')
})
```

## Random Patch

Creates a `minecraft:random_patch` configured feature

### Method Signature

```ts
event.randomPatch(
    name: string,
    tries: @Nullable number,
    xzSpread: @Nullable number,
    ySpread: @nullable number,
    feature: string,
    placement: Consumer<PlacedFeatureProperties>
)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A number, how many times the feature should attempt to place, may be null to default to 128
- 3rd argument: A number, the horizontal spread of the patch, may be null to default to 7
- 4th argument: A number, the vertical spread of the patch, may be null to default to 3
- 5th argument: A string, the name of the feature to attempt to place
- 6th argument: A [feature placement consumer](#feature-placement)

### Example

```js
TFCEvents.worldgenData(event => {
    event.randomPatch('example_crop_patch', 30, 15, 10, 'kubejs_tfc:example_crop_placement', placement => {})
})
ServerEvents.tags('worldgen/placed_features', event => {
    event.add('tfc:feature/crops', 'kubejs_tfc:example_crop_patch')
})
```

## Tall Wild Crop

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#tall-wild-crop)!

### Method Signature

```ts
event.tallWildCrop(name: string, block: string, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the block to place, must be an instance of [WildDoubleCropBlock](../custom/#wild_crop)
- 3rd argument: A [feature placement consumer](#feature-placement)

## Spreading Crop

```ts
event.spreadingCrop(name: string, block: string, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the block to place, must be an instance of [WildSpreadingCropBlock](../custom/#wild-crops)
- 3rd argument: A [feature placement consumer](#feature-placement)

## Spreading Bush

See the [main page](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/features/#spreading-bush)!

### Method Signature

```ts
event.spreadingBush(name: string, block: string, placement: Consumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the block to place, must be an instance of [SpreadingBushBlock](../custom/#spreading-berry-bush)
- 3rd argument: A [feature placement consumer](#feature-placement)

## Generic

Creates a configured feature of the given type using the given config

### Method Signature

```ts
event.generic(name: string, type: string, featureConfig: JsonObject, placement: COnsumer<PlacedFeatureProperties>)
```

- 1st argument: A string, the name of the configured feature, if no namespace is set, defaults to `kubejs_tfc`
- 2nd argument: A string, the type of configured feature to be created
- 3rd argument: A json object, the `config` object of a normal configured feature
- 4th argument: A [feature placement consumer](#feature-placement)

## Boulder State

This defines an entry to a boulder feature's `state` value

### Method Signature

```ts
event.boulderState(rock: string, blockStates: List<string>)
```

- 1st argument: The registry name of a block, the raw rock block of a rock layer for the `blockStates` to spawn in
- 2nd argument: A list of block states in their string representation, i.e. `minecraft:grass[snowy=true]`, the blocks to be placed for the boulder in that rock

See the [boulder](#boulders) example for an example of usage

## Blocks to Block States Replacement Entry

This defines an entry to a blocks to weighted blockstates map

### Method Signature

```ts
event.blockToWeightedBlockState(replace: List<string>, with: List<string>)
```

- 1st argument: A list of strings, the registry name of blocks to be replaced
- 2nd argument: A list of strings, string representations of a weighted block state, i.e. `8 minecraft:oak_log[axis=z]`, the blocks to be placed as part of the vein

See the [cluster](#cluster-veins), [pipe](#pipe-veins), and [disc](#disc-veins) vein examples for usage

## Block to Block State Replacement Entry

This defines an entry to a block to blockstate map

### Method Signature

```ts
event.blockToBlockState(block: string, state: string)
```

- 1st argument: A string, the bloc kto be replaced
- 2nd argument: A string representation of a block state, the state to be placed

## Fissure Decoration

Hot springs and fissures may have additional decorations around them, this is used to define them

### Method Signature

```ts
event.fissureDecoration(
    replacementMap: List<BlockToWeightedBlockStateMapEntry>,
    rarity: number,
    radius: number,
    count: number
)
```

- 1st argument: A list of [blocks to weighted block states](#blocks-to-block-states-replacement-entry), the additional ores that should spawn around the fissure
- 2nd argument: A number, the rarity of block s being replaced
- 3rd argument: A number, the radius around the fissure that blocks should be replaced
- 4th argument: A number, the number of blocks that should be placed, actual amount will be `count / rarity`

## Vein Properties

When creating veins in TFC, certain parameters are optional. This is used to define those optional values

### Indicator

Defines the vein's indicator

Method signature:

```ts
vein.indicator(depth: number, rarity: number, undergroundCount: number, indicators: List<string>)
```

- 1st argument: A number, the number of blocks above the top of the vein the indicators may spawn
- 2nd argument: A number, how rare the indicator blocks should be
- 3rd argument: A number, the number of indicators should spawn underground
- 4th argument: A list of strings, string representations of a weighted block state

### Project

Determines the `project` value of the vein

Method signature:

```ts
vein.project(b: boolean)
```

- 1st argument: A boolean, defaults to false

### Project Offset

Determines the `project_offset` value of the vein

Method signature:

```ts
vein.projectOffset(b: boolean)
```

- 1st argument: A boolean, defaults to false

### Biomes

Determines the `biomes` values of the vein

Method signature:

```ts
vein.biomes(biomeTag: string)
```

- 1st argument: A string, a biome tag that the vein may spawn in, defaults to allowing all biomes

### Near Lava

Determines the `near_lava` value of the vein

Method signature:

```ts
vein.nearLava(b: boolean)
```

- 1st argument: A boolean, defaults tot false

## Feature Placement

World generation features are made up of two parts, their configuration and their placement, typically in separate files, but due to not being restricted to using raw json files, KubeJS TFC allows you to define a feature's placement with its configuration through a feature placement consumer. Several of the methods can be seen in the above examples, but a full list will be provided here:

### Simple Placement

Adds a placement of the provided type with no arguments

Method signature:

```ts
placement.simplePlacement(type: string)
```

- 1st argument: A string, the type of the placement modifier to be added

### Json Placement

Adds the provided json object as a placement modifier

Method signature:

```ts
placement.jsonPlacement(json: JsonObject)
```

- 1st argument: A json object to be added as a placement modifier

### TFC Biome

Adds a placement modifier of type `tfc:biome`

Method Signature:

```ts
placement.tfcBiome()
```

### Climate

Adds a placement modifier of type `tfc:climate`

Method signature:

```ts
placement.climate(climate: Consumer<ClimateModifier>)
```

- 1st argument: A consumer with several methods:
    - `.minRain(f: number)`: Accepts a number, sets the minimum rainfall
    - `.maxRain(f: number)`: Accepts a number, sets the maximum rainfall
    - `.minTemp(f: number)`: Accepts a number, sets the minimum temperature
    - `.maxTemp(f: number)`: Accepts a number, sets the maximum temperature
    - `.minForest(forest: string)`: Accepts `none`, `sparse`, `edge`, `normal`, and `old_growth`, sets the minimum forest level
    - `.maxForest(forest: string)`: Accepts `none`, `sparse`, `edge`, `normal`, and `old_growth`, sets the maximum forest level
    - `.fuzzy(b: boolean)`: Accepts a boolean, determines if the temperature and rainfall calculations should be probabilistic relative to the center point

### Flatness

Adds a placement modifier of type `tfc:flat_enough`

Method signature:

```ts
placement.flatEnough(flatness: Consumer<FlatnessModifier>)
```

- 1st argument: A consumer with several methods:
    - `.flatness(f: number)`: Accepts a number, in the range [0, 1], sets the required flatness of the surrounding area, defaults to `0.5`
    - `.radius(i: number)`: Accepts a number, sets the radius around the initial position the area is checked for flatness, defaults to 2
    - `.maxDepth(i: number)`: Accepts a number, sets how deep from the initial position the modifier should search, defaults to 4

### Near Water

Adds a placement modifier of type `tfc:near_water`

Method signature:

```ts
placement.nearWater(radius: number)
```

- 1st argument: A number, sets the `radius` property of the modifier

### Shallow Water

Adds a placement modifier of type `tfc:shallow_water`

Method Signature:

```ts
placement.shallowWater(depth: number)
```

- 1st argument: A number, sets the `max_depth` property of the modifier

### Underground

Adds a placement modifier of type `tfc:underground`

Method signature:

```ts
placement.underground()
```

### Volcano

Adds a placement modifier of type `tfc:volcano`

Method signature:

```ts
placement.volcano(center: boolean, distance: number)
```

- 1st argument: A boolean, if true the feature will be placed at the exact center of the volcano and disregard the `distance` property
- 2nd argument: A number, in the range [0, 1], sets the distance from the center of the volcano the feature needs to generate

### In Square

Adds a placement modifier of type `minecraft:in_square`

Method signature:

```ts
placement.inSquare()
```

### Rarity Filter

Adds a placement modifier of type `minecraft:rarity_filter`

Method signature:

```ts
placement.rarityFilter(chance: number)
```

- 1st argument: A number, sets the `chance` property of the modifier

### Height Map

Adds a placement modifier of type `minecraft:heightmap`

Method signature:

```ts
placement.heightMap(heightMap: string)
```

- 1st argument: A string, the name of the height map to use
