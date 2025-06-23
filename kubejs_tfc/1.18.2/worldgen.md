---
layout: page
title: World Generation
permalink: /kubejs_tfc/1.18.2/worldgen/
parent: 1.18.2
grand_parent: KubeJS TFC
---

# World Generation

KubeJS TFC allows users to easily build some of TFC's world generation [features](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/features/)

In the `tfc.worldgen.data` event there are methods for:

- [Adding Features to TFC's World](#adding-features)
- [Geodes](#geodes)
- [Boulders](#boulders)
- [Thin Spikes](#thin-spikes)
- [Veins](#veins)
- [If-Then](#if-then)

Have a look through some [examples](#examples) at the bottom of the page

Additionally, there is a new startup event `tfc.rock_settings.register` which is used to add, remove, and modify rock layers in TFC's default world generation, the methods can be found [here](#rock-layers)

## Adding Features

Much of TFC's world generation configuration is done through tags. In the `tags.worldgen.placed_feature` server event features will have to be added to their respective tags, in each example this will be done with the appropriate tag for the feature

A full list of available tags is also available [here](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/tags/#placed-feature-tags)

## Geodes

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/features/#geode)!

- 1st argument: A string, the name of the feature, if no namespace is provided, it will default to `kubejs_tfc`
- 2nd argument: A consumer with several methods
    - `.outer(String)`{: .language-javascript }: Accepts a block state and sets the outer layer of the geode
    - `.middle(String)`{: .language-javascript }: Accepts a block state and sets the middle layer of the geode
    - `.inner(String...)`{: .language-javascript }: Accepts an array of weighted block states and sets the inner layer of the geode
- 3rd argument: A [feature placement consumer](#placing-features)

### Example

```js
// Builds a geode with an outer state of logs in the z direction, middle state of hardened basalt, and inner state of raw quartzite with 6 weight
// and cut copper with 1 weight. The placement is identical to TFC's default geode placement
onEvent('tfc.worldgen.data', event => {
    event.buildTFCGeode('geode_test', e => {
        e.outer('minecraft:oak_log[axis=z]')
        e.middle('tfc:rock/hardened/basalt')
        e.inner('6x tfc:rock/raw/quartzite', 'minecraft:cut_copper')
    }, e => {
        e.tfcBiome()
        e.rarityFilter(500)
        e.inSquare()
        e.placement({
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
onEvent('tags.worldgen.placed_feature', event => {
    event.add('tfc:in_biome/veins', 'kubejs_tfc:geode_test')
})
```

## Boulders

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/features/#boulder)!

- 1st argument: A string, the name of the feature, if no namespace is provided, it will default to `kubejs_tfc`
- 2nd argument: A consumer with one method:
    - `state`
        - 1st argument: A block state, representing the ‘raw’ rock block of a rock type
        - 2nd argument: A block state array, representing the blocks to be used when placing the boulder
- 3rd argument: A [feature placement consumer](#placing-features)

### Example

```js
// Builds a boulder which is made of the gravel and cobble corresponding to the type the boulder is in for limestone and shale
// The placement is identical to TFC's default boulder placement
onEvent('tfc.worldgen.data', event => {
    event.buildTFCBoulder('ae2:boulder_test', e => {
        e.state('tfc:rock/raw/limestone', 'tfc:rock/gravel/limestone', 'tfc:rock/cobble/limestone')
        e.state('tfc:rock/raw/shale', 'tfc:rock/gravel/shale', 'tfc:rock/cobble/limestone')
    }, e => {
        e.rarityFilter(12)
        e.inSquare()
        e.heightMap('WORLD_SURFACE_WG')
        e.flatEnough(e => {
            e.flatness(0.4)
       })
    })
})
onEvent('tags.worldgen.placed_feature', event => {
    event.add('tfc:feature/boulders', 'ae2:boulder_test')
})
```

## Thin Spikes

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/features/#thin-spike)!

- 1st argument: A string, the name of the feature, if no namespace is provided, it will default to `kubejs_tfc`
- 2nd argument: A consumer with several methods:
    - `.state(String)`{: .language-javascript }: Accepts a block state and sets the block to be used. **Note:** must be a [thin spike block](https://github.com/Notenoughmail/KubeJS-TFC/wiki/Items-and-Blocks#thin-spike)
    - `.radius(integer)`{: .language-javascript }: Accepts an integer, in the range [1, 16], and sets the radius which to place spikes in
    - `.tries(integer)`{: .language-javascript }: Accepts an integer and sets how many attempts should be made to place spikes
    - `.heights(integer, integer)`{: .language-javascript }: Accepts two integers, the first setting the minimum height of the spike, and the second the maximum
- 3rd argument: A [feature placement consumer](#placing-features)

### Example

```js
// Builds a thin spike feature using a custom block 'lava_spike'. The placement is identical to TFC's default for calcite
onEvent('tfc.worldgen.data', event => {
    event.buildTFCThinSpike('thin_spike_test', e => {
        e.state('kubejs:lava_spike')
        e.radius(8)
        e.tries(4)
        e.heights(2, 6)
    }, e => {
        e.placement({
            type: 'minecraft:count',
            count: 4
        })
        e.inSquare()
        e.placement({
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
onEvent('tags.worldgen.placed_feature', event => {
    event.add('tfc:in_biome/underground_decoration', 'kubejs_tfc:thin_spike_test')
})
```

## Veins

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/features/veins/)!

- 1st argument: A string, the name of the feature, if no namespace is provided, it will default to `kubejs_tfc`
- 2nd argument: A consumer with several methods:
    - `.type(String)`{: .language-javascript }: Accepts a `cluster`, `disc`, or `pipe` and sets the type of vein this feature will be, defaults to `cluster`
    - `.rarity(integer)`{: .language-javascript }: Accepts an integer and sets the rarity, defaults to 60
        - **Note:** the rarity is 1 over the provided value, i.e. .rarity(3) would make the vein occur in 1/3 chunks on average
    - `.size(integer)`{: .language-javascript }: Accepts an integer and sets the size, defaults to 8
    - `.density(number)`{: .language-javascript }: Accepts a number, in the range [0, 1], and sets the density of the vein, defaults to 0.2
    - `.minY(object)`{: .language-javascript }: Accepts either a [vertical anchor](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/common-types/#vertical-anchor) json object or an integer, which will be treated as an absolute vertical anchor. Sets the minimum y level the vein will spawn at
    - `.maxY(object)`{: .language-javascript }: Accepts either a [vertical anchor](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/common-types/#vertical-anchor) json object or an integer, which will be treated as an absolute vertical anchor. Sets the maximum y level the vein will spawn at
    - `.indicator(consumer)`{: .language-javascript }: Accepts a consumer with several methods:
        - `.depth(integer)`{: .language-javascript }: Accepts an integer and sets the maximum depth below the surface the vein will spawn surface indicators, defaults to 35
        - `.spread(integer)`{: .language-javascript }: Accepts an integer and sets the maximum horizontal distance from a vein that an indicator will spawn, defaults to 15
        - `.rarity(integer)`{: .language-javascript }: Accepts an integer and sets the rarity to spawn indicators, as a fraction of horizontal locations the vein places ore blocks, defaults to 10
        - `.indicators(String...)`{: .language-javascript }: Accepts an array of weighted block states and sets the indicator(s) to use
    - `.replacementMap(consumer)`{: .language-javascript }: Accepts a consumer with a method pair:
        - `.replace(String...)`{: .language-javascript }: A string array representing the list of blocks to replaced with:
        - `.with(String...)`{: .language-javascript }: An array of weighted block states, representing the ores of the vein, this method *must* be attached to a `replace` method
    - `.salt(integer)`{: .language-javascript }: Accepts an integer and sets the salt of the placement algorithm, defaults to the world's seed
    - `.biomeFilter(String)`{: .language-javascript }: Accepts string matching a biome tag and sets the filter for allowed biomes, defaults to allowing all biomes
    - If the type is `disc` the following method is also available:
        - `.height(integer)`{: .language-javascript }: Accepts an integer and sets the height of the vein, the size parameter will be interpreted as the radius
    - If the type is `pipe` the following methods are also available:
        - `.radius(integer)`{: .language-javascript }: Accepts an integer and sets the radius of the vein, defaults to 3
        - `.minSkew(integer)`{: .language-javascript }: Accepts an integer and sets the minimum skew of the vein, defaults to 0
        - `.maxSkew(integer)`{: .language-javascript }: Accepts an integer and sets the maximum skew of the vein, defaults to 0
        - `.minSlant(integer)`{: .language-javascript }: Accepts an integer and sets the minimum slant of the vein, defaults to 0
        - `.maxSlant(integer)`{: .language-javascript }: Accepts an integer and sets the maximum slant of the vein, defaults to 0
        - `.sign(number)`{: .language-javascript }: Accepts a number, in the range [0, 1], and sets the sign of the slant, defaults to 0.5

### Example

```js
// Builds a vein that places
//      copper blocks in dacite,
//      gold and iron blocks in andesite,
//      and dark oak and oak logs in rhyolite and basalt
//      with an indicator of a custom loose rock[3]
onEvent('tfc.worldgen.data', event => {
    event.buildTFCVein('vein_test', e => {
        e.rarity(5)
        e.size(20)
        e.density(0.7)
        e.minY(-20)
        e.maxY(80)
        e.indicator(e => {
            e.depth(70)
            e.spread(10)
            e.rarity(17)
            e.indicators('kubejs:custom_rock')
        })
        e.replacementMap(e => {
            e.replace('tfc:rock/raw/rhyolite', 'tfc:rock/raw/basalt').with('8 minecraft:oak_log', '3 minecraft:dark_oak_log')
            e.replace('tfc:rock/raw/andesite').with('9 minecraft:gold_block', '2 minecraft:iron_block')
            e.replace('tfc:rock/raw/dacite').with('minecraft:copper_block')
        })
    })
})
onEvent('tags.worldgen.placed_feature', event => {
    event.add('tfc:in_biome/veins', 'kubejs_tfc:vein_test')
})
```

[3]: see [custom loose rocks](https://github.com/Notenoughmail/KubeJS-TFC/wiki/Items-and-Blocks#loose-rock)

## If-Then

See the [main page](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/features/#if-then)!

- 1st argument: A string, the name of the feature, if no namespace is provided, it will default to `kubejs_tfc`
- 2nd argument: A string, the name of a feature to be placed
- 3rd argument: A string, the name of a feature to be placed if the first feature successfully places
- 4th argument: A [feature placement consumer](#placing-features)

## Placing Features

World generation features are made up of two parts, their configuration and their placement, typically in separate files, but due to not being restricted to using raw json files, KubeJS TFC allows you to define a feature's placement with its configuration through a feature placement consumer. Several of the methods can be seen in the above examples, but a full list will be provided here:

### .tfcBiome()

Adds TFC's [biome](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/decorators/#biome) placement modifier

### .climate(consumer)

Adds TFC's [climate](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/decorators/#climate) placement modifier

Accepts a consumer with several methods:

- `.minTemp(number)`{: .language-javascript }: Accepts a number and sets the minimum allowed average yearly temperature
- `.maxTemp(number)`{: .language-javascript }: Accepts a number and sets the maximum allowed average yearly temperature
- `.minRain(number)`{: .language-javascript }: Accepts a number and sets the minimum allowed rainfall
- `.maxRain(number)`{: .language-javascript }: Accepts a number and sets the maximum allowed rainfall
- `.minForest(String)`{: .language-javascript }: Accepts a [forest type](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/common-types/#forest-type) and sets the minimum required forest density
- `.maxForest(number)`{: .language-javascript }: Accepts a [forest type](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/common-types/#forest-type) and sets the maximum required forest density
- `.fuzzy(boolean)`{: .language-javascript }: Accepts a boolean (default false). If true, the temperature and rainfall requirements will be probabilistic relative to the center point, with maximum density at the exact center, and zero density at the edges

### .flatEnough(consumer)

Adds TFC's [flat enough](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/decorators/#flat-enough) placement modifier

Accepts a consumer with several methods:

- `.flatness(number)`{: .language-javascript }: Accepts a number, in the range [0, 1]. It describes the how many solid blocks, as a percentage the surrounding area must contain. Defaults to 0.5
- `.radius(integer)`{: .language-javascript }: Accepts an integer and sets the radius around the initial position that the area is checked for solid blocks, defaults to 2
- `.maxDepth(integer)`{: .language-javascript }: Accepts an integer and sets how deep from the original position the decorator should try and search, defaults to 4

### .nearWater(integer)

Adds TFC's [near water](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/decorators/#near-water) placement modifier

Accepts an integer representing the distance to search for water

### .shallowWater(*optional integer*)

Adds TFC's [shallow water](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/decorators/#shallow-water) placement modifier

Accepts an optional integer specifying the max depth of the water, defaults to 3

### .underground()

Adds TFC's [underground](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/decorators/#underground) placement modifier

### .volcano(*optional boolean*, number)

Adds TFC's [volcano](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/decorators/#volcano) placement modifier

Accepts:

- An optional boolean which if true will place the feature at the exact center of any volcanoes, defaults to false
- A number, in the range [0, 1], representing the distance from the center of a volcano that this position must be in order to generate. 1 is the maximum radius of the volcano

### .inSquare()

Adds Vanilla's `in_square` placement modifier

### .rarityFilter(integer)

Adds Vanilla's `rarity_filter` placement modifier

Accepts an integer and sets the `chance` parameter

### .heightMap(String)

Adds Vanilla's `heightmap` placement modifier

Accepts a string and sets the `height_map` parameter

### .placement(object)

Adds any arbitrary placement modifier

Accepts either a json object, which will be treated as a placement modifier; a string, which will be treated as a placement modifier with the type specified by the given string; or a list containing json objects or strings, which will be individually processed

## Examples

Please note these features are added to to the world using an outdated method of tagging, for how it should actually be done please refer to [Adding Features](#adding-features) above

The test boulder:
![boulder_example](https://github.com/Notenoughmail/KubeJS-TFC/assets/78008321/a7c8f261-5b42-4d83-8265-30e5ff6b7abc)
The test geode:
![geode_example](https://github.com/Notenoughmail/KubeJS-TFC/assets/78008321/dc12adf1-08bb-44e4-9f71-fb5e10b24ffe)
The test thin spike:
![thin_spike_example](https://github.com/Notenoughmail/KubeJS-TFC/assets/78008321/84d95792-dc6c-4815-a40f-c4c10eb7aa3d)
A test vein indicator on the surface:
![vein_example_indicator](https://github.com/Notenoughmail/KubeJS-TFC/assets/78008321/9b198be0-959d-4aa0-8ced-5d20e934718a)
A test vein in shale:
![vein_example_vein](https://github.com/Notenoughmail/KubeJS-TFC/assets/78008321/54df0c92-32ad-4ce3-893b-dfd0df187fa1)
A test vein in gabbro:
![vein_example_vein_2](https://github.com/Notenoughmail/KubeJS-TFC/assets/78008321/48991af2-e062-4118-8f3f-573a3a26f489)

## Rock Layers

TFC's world is built around rock layers which can be modified through the modification of the `rock_layer_settings` property of TFC's [dimension source](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/dimension/), KubeJS TFC allows you to add to, remove, or modify these values through the `tfc.rock_settings.register` startup event.

**Note**: These will only apply to worlds which do not have a `data/minecraft/dimension/overworld.json` file in their applied datapacks, however their names can be referenced in the file just like TFC's defaults

### Adding a Layer

- 1st argument: The resource location of the rock layer you will be adding. Generally advised to use `kubejs` as the namespace as to not overwrite or be overwritten by another mod
- 2nd argument: A consumer with several methods:
    - `.raw(String)`{: .language-javascript }: Accepts a string representing the registry name of a block, sets the 'raw' block type for the rock layer
    - `.hardened(String)`{: .language-javascript }: Accepts a string representing the registry name of a block, sets the 'hardened' block type for the rock layer
    - `.gravel(String)`{: .language-javascript }: Accepts a string representing the registry name of a block, sets the 'gravel' block type for the rock layer
    - `.cobble(String)`{: .language-javascript }: Accepts a string representing the registry name of a block, sets the 'cobble' block type for the rock layer
    - `.sand(String)`{: .language-javascript }: Accepts a string representing the registry name of a block, sets the 'sand' block type for the rock layer
    - `.sandstone(String)`{: .language-javascript }: Accepts a string representing the registry name of a block, sets the 'sandstone' block type for the rock layer
    - `.spike(String)`{: .language-javascript }: Accepts a string representing the registry name of a block, sets the 'spike' block type for the rock layer. This value is optional
        - **Note**: The provided block *must* be an instance of [RockSpikeBlock](https://github.com/Notenoughmail/KubeJS-TFC/wiki/Items-and-Blocks#rock-spike) or the game may crash due to lacking the required block states
    - `.loose(String)`{: .language-javascript }: Accepts a string representing the registry name of a block, sets the 'loose' block type for the rock layer. This value is optional
        - **Note**: The provided block *must* be an instance of [LooseRockBlock](https://github.com/Notenoughmail/KubeJS-TFC/wiki/Items-and-Blocks#loose-rock) or the game may crash due to lacking the required block states
    - `.top()`{: .language-javascript }: Allows the rock layer to spawn on the top rock layer in the world
    - `.middle()`{: .language-javascript }: Allows the rock layer to spawn on the middle rock layer in the world
    - `.bottom()`{: .language-javascript }: Allows the rock layer to spawn on the bottom rock layer in the world
    - `.noWarnings()`{: .language-javascript }: A utility method which will disable non-critical warnings about the rock layer

#### Example

```js
// Adds a default rock layer consisting of vanilla blocks and spawning only in the top rock layer of the world
onEvent('tfc.rock_settings.register', event => {
    event.addDefaultLayer('kubejs:my_rock_layer', rock => {
         rock.raw('minecraft:stone')
         rock.hardened('minecraft:deepslate')
         rock.cobble('minecraft:cobblestone')
         rock.gravel('minecraft:gravel')
         rock.sand('minecraft:sand')
         rock.sandstone('minecraft:sandstone')
         rock.top()
    })
})
```

### Removing a Layer

- 1st argument: The resource location of the rock layer you will be removing
    - TFC's layers are `tfc:` + the name of the rock ('chert', 'conglomerate', etc.)

#### Example

```js
// Removes the chert rock type from the list of available rock layers
onEvent('tfc.rock_settings.register', event => {
    event.removeDefaultLayer('tfc:chert')
})
```

### Modifying a Layer

- 1st argument: The resource location of the rock layer you will be modifying
    - TFC's layer are `tfc:` + the name of the rock ('andesite', 'basalt', etc.)
- 2nd argument: A consumer with the same methods as adding a layer and some additional methods:
    - `.top(boolean)`{: .language-javascript }: Accepts a boolean, determines if the layer is allowed to generate in the top rock layer of the world or not
    - `.middle(boolean)`{: .language-javascript }: Accepts a boolean, determines if the layer is allowed to generate in the middle rock layer of the world or not
    - `.bottom(boolean)`{: .language-javascript }: Accepts a boolean, determines if the layer is allowed to generate in the bottom rock layer of the world or not

#### Example

```js
// Modifies the dacite rock layer to have no spike blocks and pink sand as its sand block
onEvent('tfc.rock_settings.register', event => {
    event.modifyDefaultLayer('tfc:dacite', rock => {
        rock.spike(null)
        rock.sand('tfc:sand/pink')
    })
})
```
