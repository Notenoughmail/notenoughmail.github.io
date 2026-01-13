---
layout: page
title: Miscellaneous Bindings
permalink: /kubejs_tfc/1.20.1/bindings/misc/
parent: Bindings
grand_parent: 1.20.1
---

# Miscellaneous Bindings

- [Rock Map](#rock-map)
- [Wood Map](#wood-map)
- [Metal Map](#metal-map)
- [Heat utilities](#heat-utilities)
- [Food utilities](#food-utilities)
- [Size Utilities](#size-utilities)
- [Collapse Utilities](#collapse-utilities)
- [Chunk Data Utilities](#chunk-data-utilities)
- [Noise Utils](#noise-utils)
- [Metal Utils](#metal-utils)
- [Other Data Utils](#other-data-utils)

## Rock Map

A string to `RegistryRock` map of all of TFC's rock types

### Example

```js-20
TFC.misc.rock.get('dacite')
```

## Wood Map

A string to [`NamedRegistryWood`]({% link kubejs_tfc/1.20.1/type-explanations.md %}#named-registry-wood) map of all of TFC's wood types

### Example

```js-20
TFC.misc.wood.get('oak')
```

## Metal Map

A string to [`NamedRegistryMetal`]({% link kubejs_tfc/1.20.1/type-explanations.md %}#named-registry-metal) map of all of TFC's metals

### Example

```js-20
TFC.misc.metal.get('bronze')
```

## Heat Utilities

### Get Heat

Gets the `IHeat` of a given item stack, may be null

Method Signature:

```js-20
TFC.misc.getHeat(stack: ItemStack): @Nullable IHeat
```

Example:

```js-20
TFC.misc.getHeat('tfc:metal/ingot/cast_iron').getWeldingTemperature()
```

### Has Heat

Returns true if the given item stack has an `IHeat`

Method Signature:

```js-20
TFC.misc.hasHeat(stack: ItemStack): boolean
```

Example:

```js-20
TFC.misc.hasHeat('tfc:powder/sulfur')
```

### Get Heat Level

Gets the `Heat` of the given temperature (°C), will be null for temperatures less than 1°C

```js-20
TFC.misc.getHeatLevel(96)
```

### Heat Levels

A string to `Heat` map of all of TFC's heat levels

Example:

```js-20
TFC.misc.heatLevels.get('orange')
```

## Food Utilities

### Get Food

Gets the `IFood` of the given stack, may be null

Method Signature:

```js-20
TFC.misc.getFood(stack: ItemStack): @Nullable IFood
```

Example:

```js-20
TFC.misc.getFood('tfc:food/red_apple').getDecayDateModifier()
```

### Has Food

Returns true if the given item stack has an `IFood`

Method Signature:

```js-20
TFC.misc.hasFood(stack: ItemStack): boolean
```

Example:

```js-20
TFC.misc.hasFood('minecraft:dirt')
```

### Set Rotten

Makes the provided stack rotten if possible and returns it

Method Signature:

```js-20
TFC.misc.setRotten(stack: ItemStack): ItemStack
```

### Set Never Expires

Makes it so the provided stack never expires

Method Signature:

```js-20
TFC.misc.setNeverExpires(stack: ItemStack): void
```

### Get Food Trait

Retrieves the food trait with the given registry name or null if not found

Method Signature:

```js-20
TFC.misc.getFoodTrait(id: String): FoodTrait
```

Example:

```js-20
TFC.misc.getFoodTrait('kubejs:my_food_trait')
```

### Get Food Trait ID

Returns the id of the given food trait

Method Signature

```js-20
TFC.misc.getFoodTraitId(trait: FoodTrait): String
```

### Apply Trait

Applies the given trait to the stack, modifying it

Method Signature:

```js-20
TFC.misc.applyFoodTrait(stack: ItemStack, trait: ResourceLocation): void
```

### Remove Trait

Removes the given trait to the stack, modifying it

Method Signature:

```js-20
TFC.misc.removeFoodTrait(stack: ItemStack, trait: ResourceLocation): void
```

## Size Utilities

### Get Size

Returns the `Size` of the given item stack

Method Signature:

```js-20
TFC.misc.getSize(stack: ItemStack): Size
```

### Get Weight

Returns the `Weight` if the given item stack

Method Signature:

```js-20
TFC.misc.getWeight(stack: ItemStack): Weight
```

## Collapse Utilities

### Can Start Collapse

Returns true if the given level and position can start a collapse

Method Signature:

```js-20
TFC.misc.canStartCollapse(level: LevelAccessor, pos: BlockPos): boolean
```

- `level: LevelAccessor`{: .language-kube-20 }: The level being checked
- `pos: BlockPos`{: .language-kube-20 }: The block pos being checked

### Try Collapse

Attempts to cause a collapse at the given level and position, returns false if no collapse or a fake collapse occurred

Method Signature:

```js-20
TFC.misc.tryCollapse(level: Level, pos: BlockPos): boolean
```

- `level: Level`{: .language-kube-20 }: The level where the collapse is trying to be created
- `pos: BlockPos`{: .language-kube-20 }: The center of where the collapse is trying to be created

### Force Collapse

Forces a collapse to happen at a position, returns true if any blocks started collapsing

Method Signature:

```js-20
TFC.misc.forceCollapse(level: Level, pos: BlockPos): boolean
```

- `level: Level`{: .language-kube-20 }: The level where the collapse will occur
- `pos: BlockPos`{: .language-kube-20 }: The center of the collapse

### Find Unsupported Positions

Finds all positions in the given area that are unsupported

Methods Signatures:

```js-20
TFC.misc.findUnsupportedPositions(level: BlockGetter, from_: BlockPos, to: BlockPos): Set<BlockPos>
```

- `level: BlockGetter`{: .language-kube-20 }: The level to check in
- `from_: BlockPos`{: .language-kube-20 }: The minimum corner to check
- `to: BlockPos`{: .language-kube-20 }: The maximum corner to check

```js-20
TFC.misc.findUnsupportedPositions(level: BlockGetter, center: BlockPos, horizontal: number, up: number, down: number): Set<BlockPos>
```

- `level: BlockGetter`{: .language-kube-20 }: The level to check in
- `center: BlockPos`{: .language-kube-20 }: The center position to check
- `horizontal: number`{: .language-kube-20 }: The number of blocks around the center to check horizontally
- `up: number`{: .language-kube-20 }: The number of blocks to check above the center
- `down: number`{: .language-kube-20 }: The number of blocks to check below the center

### Is Supported

Returns true if the position is supported

Method Signature:

```js-20
TFC.misc.isSupported(level: BlockGetter, pos: BlockPos): boolean
```

### Supported Area

#### Maximum Supported Area Around

Returns an iterable of all positions that could possibly be supported around the min and max positions

Method Signature:

```js-20
TFC.misc.getMaximumSupportedAreaAround(minPoint: BlockPos, maxPoint: BlockPos): Iterable<BlockPos>
```

#### Get Support Check Range

Returns the `SupportRange` that is used as a maximum for checking if an area is supported

Method Signature:

```js-20
TFC.misc.getSupportCheckRange(): SupportRange
```

#### Get Support

Gets the support from the block, or null if it is not a supporting block

Method Signatures:

```js-20
TFC.misc.getSupport(state: BlockState): @Nullable Support
TFC.misc.getSupport(level: BlockGetter, pos:BlockPos): @Nullable Support
```

## Chunk Data Utilities

### Chunk Data

Gets TFC's [`ChunkData`]({% link kubejs_tfc/1.20.1/type-explanations.md %}#chunk-data) for the given level and position

Method Signature:

```js-20
TFC.misc.getChunkData(level: LevelReader, pos: BlockPos): ChunkData
```

- `level: LevelReader`{: .language-kube-20 }: The level to get the data from
- `pos: BlockPos`{: .language-kube-20 }: The position to get the data from

### Rock Data

Get's TFC's `RockData` for the given level and position, may be null

Method Signature:

```js-20
TFC.misc.getRockData(level: LevelReader, pos: BlockPos): @Nullable RockData
```

- `level: LevelReader`{: .language-kube-20 }: The level to get the data from
- `pos: BlockPos`{: .language-kube-20 }: The position to get the data from

### Rock Settings

Gets TFC's `RockSettings`, a collection of blocks that define a rock layer, see [custom rock settings]({% link kubejs_tfc/1.20.1/events.md %}#rock-settings), may be null

Method Signatures:

```js-20
TFC.misc.getRockSettings(level: LevelReader, pos: BlockPos): @Nullable RockSettings
```

- `level: LevelReader`{: .language-kube-20 }: The level to get the settings from
- `pos: BlockPos`{: .language-kube-20 }: The position to get the settings from

```js-20
TFC.misc.getRockSettings(level: LevelAccessor, block: Block): @Nullable RockSettings
```

- `level: LevelAccessor`{: .language-kube-20 }: The level to check in
- `block: Block`{: .language-kube-20 }: The block to check

### Forest Type

Gets TFC's `ForestType`{:.e} for the given level and position

Method Signature:

```js-20
TFC.misc.getForestType(level: LevelReader, pos: BlockPos): ForestType
```

- `level: LevelReader`{: .language-kube-20 }: The level to get the forest type from
- `pos: BlockPos`{: .language-kube-20 }: The position to get the forest type from

### Get Hydration

Returns a number, {% in_range 0,100 %}, an expression of how hydrated soil at the position would be

```js-20
TFC.misc.getHydration(level: LevelAccessor, pos: BlockPos): number
```

- `level: LevelAccessor`{: .language-kube-20 }: The level to get the hydration level from
- `pos: BlockPos`{: .language-kube-20 }: The position to get the hydration level from

### Lerp Float Layer

Returns a `LerpFloatLayer`, an interpolated square of numbers which are known at corners and interpolated between for intermediate values

```js-20
TFC.misc.lerpFloatLayer(value00: number, value01: number, value10: number, value11: number): LerpFloatLayer
```

- `value00: number`{: .language-kube-20 }: The value at the [low x, low z] corner
- `value01: number`{: .language-kube-20 }: The value at the [low x, high z] corner
- `value10: number`{: .language-kube-20 }: The value at the [high x, low z] corner
- `value11: number`{: .language-kube-20 }: The value at the [high x, high z] corner

## Noise Utils

### Open Simplex

TFC uses open simplex noise, a type of [noise]({% link kubejs_tfc/1.20.1/type-explanations.md %}#noise2d), for most, if not all, of its custom worldgen noises, these methods provide the ability to create and customize new 2D and 3D versions of TFC's open simplex noise implementation

Method Signatures:

```js-20
TFC.misc.newOpenSimplex2D(seed: number): OpenSimplex2D
TFC.misc.newOpenSimplex3D(seed: number): OpenSimplex3D
```

- `seed: number`{: .language-kube-20 }: The seed for the noise's algorithm

### Cellular Noise

Cellular noises are [noises]({% link kubejs_tfc/1.20.1/type-explanations.md %}#noise2d) specialized to have polygonal/polyhedral blobs of constant value, instead of smooth, constantly changing values

Method Signatures:

```js-20
TFC.misc.cellular2D(seed: number): Cellular2D
TFC.misc.cellular2D(seed: number): Cellular3D
```

### FastNoiseLite

FastNoiseLite is a [MIT Noise Library](https://github.com/Auburn/FastNoiseLite) for producing noise and is used in the implementations of open simplex and cellular noises. These methods provide the ability to create an actual `FastNoiseLite` object and converting it into a `Noise2D` or `Noise3D`

Method Signatures:

```js-20
TFC.misc.fnl(seed: number): FastNoiseLite
TFC.misc.fnl2Noise2D(fnl: FastNoiseLite): Noise2D
TFC.misc.fnl2Noise3D(fnl: FastNoiseLite): Noise3D
```

### Custom Noises

These methods convert a JS callback to a full [noise]({% link kubejs_tfc/1.20.1/type-explanations.md %}#noise2d) object

Method Signatures:

```js-20
TFC.misc.customNoise2D(noise: Noise2D): Noise2D
TFC.misc.customNoise3D(noise: Noise3D): Noise3D
```

### Noise Inspection Registration

These methods 'register' a [noise]({% link kubejs_tfc/1.20.1/type-explanations.md %}#noise2d) object for use with the [2D]({% link kubejs_tfc/1.20.1/commands.md %}#inspect-2d-noise) and [3D]({% link kubejs_tfc/1.20.1/commands.md %}#inspect-3d-noise) noise inspection commands

Method Signatures

```js-20
TFC.misc.register2DNoiseForInspection(name: String, noise: Noise2D): void
TFC.misc.register3DNoiseForInspection(name: String, noise: Noise3D): void
```

### LayeredArea

These methods create a [`LayeredArea`]({% link kubejs_tfc/1.20.1/type-explanations.md %}#layered-area)

```js-20
TFC.misc.layeredAreaFromNoise(noise: Noise2D, rounder?: DoubleToIntFunction, seed: number): LayeredArea
TFC.misc.layeredArea(source: SourceLayer, seed: number): LayeredArea
TFC.misc.uniformLayeredArea(seed: number): LayeredArea
```

### Metaballs

TFC uses [metaballs](https://en.wikipedia.org/wiki/Metaballs) for its generation of cluster veins, these methods provide the ability to create new 2D and 3D versions of TFC's implementation

Method Signatures:

```js-20
TFC.misc.newMetaballs2D(random: RandomSource, minBalls: number, maxBalls: number, minSize: number, maxSize: number, radius: number): metaballs2D
TFC.misc.newMetaballs3D(random: RandomSource, minBalls: number, maxBalls: number, minSize: number, maxSize: number, radius: number): Metaballs3D
```

- `random: RandomSource`{: .language-kube-20 }: The random source used by the metaballs to create variance between instances
- `minBalls: number`{: .language-kube-20 }: The minimum number of individual balls
- `maxBalls: number`{: .language-kube-20 }: The maximum number of individual balls
- `minSize: number`{: .language-kube-20 }: The minimum size of the metaballs
- `maxSize: number`{: .language-kube-20 }: The maximum size of the metaballs
- `radius: number`{: .language-kube-20 }: The maximum radius of an individual ball

## Metal Utils

### Metal from Fluid

Returns the `Metal` associated with the given fluid, may be null

```js-20
TFC.misc.getMetal(fluid: Fluid): Metal
```

### Metal from Ingot

Returns the first `Metal` whose ingots match the given stack, may be null

```js-20
TFC.misc.getMetalFromIngot(ingot: ItemStack): Metal
```

### Metal from Plate

Returns the first `Metal` whose sheets match the given stack, may be null

```js-20
TFC.misc.getMetalFromSheet(stack: ItemStack): Metal
```

## Other Data Utils

### Lamp Fuel

Gets the first `LampFuel` that matches the given fluid and blockstate, may be null

```js-20
TFC.misc.getLampFuel(fluid: Fluid, state: BlockState): LampFuel
```

### Drinkable

Gets the first `Drinkable` that matches the given fluid, may be null

```js-20
TFC.misc.getDrinkable(fluid: Fluid): Drinkable
```

### Fertilizer

Gets the first `Fertilizer` that matches the given stack, may be null

```js-20
TFC.misc.getFertilizer(stack ItemStack): Fertilizer
```

### Fuel

Gets the first `Fuel` that matches the given stack, may be null

```js-20
TFC.misc.getFuel(stack: ItemStack): Fuel
```

### Pannable

Gets the first `Pannable` that matches the given block state, may be null

```js-20
TFC.misc.getPannable(state: BlockState): Pannable
```

### Sluiceable

Gets the first `Sluiceable` that matches the given item, may be null

```js-20
TFC.misc.getSluiceable(stack: ItemStack): Sluiceable
```
