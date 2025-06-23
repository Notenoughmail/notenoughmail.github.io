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

```js
TFC.misc.rock.get('dacite')
```

## Wood Map

A string to [NamedRegistryWood](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/util/implementation/NamedRegistryWood.java) map of all of TFC's wood types

### Example

```js
TFC.misc.wood.get('oak')
```

## Heat Utilities

### Get Heat

Gets the `IHeat` of a given item stack, may be null

Method Signature:

```js
TFC.misc.getHeat(stack: ItemStack): @Nullable IHeat
```

Example:

```js
TFC.misc.getHeat('tfc:metal/ingot/cast_iron').getWeldingTemperature()
```

### Has Heat

Returns true if the given item stack has an `IHeat`

Method Signature:

```js
TFC.misc.hasHeat(stack: ItemStack): boolean
```

Example:

```js
TFC.misc.hasHeat('tfc:powder/sulfur')
```

### Get Heat Level

Gets the `Heat` of the given temperature (°C), will be null for temperatures less than 1°C

```js
TFC.misc.getHeatLevel(96)
```

### Heat Levels

A string to `Heat` map of all of TFC's heat levels

Example:

```js
TFC.misc.heatLevels.get('orange')
```

## Food Utilities

### Get Food

Gets the `IFood` of the given stack, may be null

Method Signature:

```js
TFC.misc.getFood(stack: ItemStack): @Nullable IFood
```

Example:

```js
TFC.misc.getFood('tfc:food/red_apple').getDecayDateModifier()
```

### Has Food

Returns true if the given item stack has an `IFood`

Method Signature:

```js
TFC.misc.hasFood(stack: ItemStack): boolean
```

Example:

```js
TFC.misc.hasFood('minecraft:dirt')
```

### Set Rotten

Makes the provided stack rotten if possible and returns it

Method Signature:

```js
TFC.misc.setRotten(stack: ItemStack): ItemStack
```

### Set Never Expires

Makes it so the provided stack never expires

Method Signature:

```js
TFC.misc.setNeverExpires(stack: ItemStack): void
```

### Get Food Trait

Retrieves the food trait with the given registry name or null if not found

Method Signature:

```js
TFC.misc.getFoodTrait(id: String): FoodTrait
```

Example:

```js
TFC.misc.getFoodTrait('kubejs:my_food_trait')
```

### Get Food Trait ID

Returns the id of the given food trait

Method Signature

```js
TFC.misc.getFoodTraitId(trait: FoodTrait): String
```

### Apply Trait

Applies the given trait to the stack, modifying it

Method Signature:

```js
TFC.misc.applyFoodTrait(stack: ItemStack, trait: ResourceLocation): void
```

### Remove Trait

Removes the given trait to the stack, modifying it

Method Signature:

```js
TFC.misc.removeFoodTrait(stack: ItemStack, trait: ResourceLocation): void
```

## Size Utilities

### Get Size

Returns the `Size` of the given item stack

Method Signature:

```js
TFC.misc.getSize(stack: ItemStack): Size
```

### Get Weight

Returns the `Weight` if the given item stack

Method Signature:

```js
TFC.misc.getWeight(stack: ItemStack): Weight
```

## Collapse Utilities

### Can Start Collapse

Returns true if the given level and position can start a collapse

Method Signature:

```js
TFC.misc.canStartCollapse(level: LevelAccessor, pos: BlockPos): boolean
```

- `level`: The level being checked
- `pos`: The block pos being checked

### Try Collapse

Attempts to cause a collapse at the given level and position, returns false if no collapse or a fake collapse occurred

Method Signature:

```js
TFC.misc.tryCollapse(level: Level, pos: BlockPos): boolean
```

- `level`: The level where the collapse is trying to be created
- `pos`: The center of where the collapse is trying to be created

### Force Collapse

Forces a collapse to happen at a position, returns true if any blocks started collapsing

Method Signature:

```js
TFC.misc.forceCollapse(level: Level, pos: BlockPos): boolean
```

- `level`: The level where the collapse will occur
- `pos`: The center of the collapse

### Find Unsupported Positions

Finds all positions in the given area that are unsupported

Methods Signatures:

```js
TFC.misc.findUnsupportedPositions(level: BlockGetter, from: BlockPos, to: BlockPos): Set<BlockPos>
```

- `level`: The level to check in
- `from`: The minimum corner to check
- `to`: The maximum corner to check

```js
TFC.misc.findUnsupportedPositions(level: BlockGetter, center: BlockPos, horizontal: number, up: number, down: number): Set<BlockPos>
```

- `level`: The level to check in
- `center`: The center position to check
- `horizontal`: The number of blocks around the center to check horizontally
- `up`: The number of blocks to check above the center
- `down`: The number of blocks to check below the center

### Is Supported

Returns true if the position is supported

Method Signature:

```js
TFC.misc.isSupported(level: BlockGetter, pos: BlockPos): boolean
```

### Supported Area

#### Maximum Supported Area Around

Returns an iterable of all positions that could possibly be supported around the min and max positions

Method Signature:

```js
TFC.misc.getMaximumSupportedAreaAround(minPoint: BlockPos, maxPoint: BlockPos): Iterable<BlockPos>
```

#### Get Support Check Range

Returns the `SupportRange` that is used as a maximum for checking if an area is supported

Method Signature:

```js
TFC.misc.getSupportCheckRange(): SupportRange
```

#### Get Support

Gets the support from the block, or null if it is not a supporting block

Method Signatures:

```js
TFC.misc.getSupport(state: BlockState): @Nullable Support
TFC.misc.getSupport(level: BlockGetter, pos:BlockPos): @Nullable Support
```

## Chunk Data Utilities

### Chunk Data

Gets TFC's `ChunkData` for the given level and position

Method Signature:

```js
TFC.misc.getChunkData(level: LevelReader, pos: BlockPos): ChunkData
```

- `level`: The level to get the data from
- `pos`: The position to get the data from

### Rock Data

Get's TFC's `RockData` for the given level and position, may be null

Method Signature:

```js
TFC.misc.getRockData(level: LevelReader, pos: BlockPos): @Nullable RockData
```

- `level`: The level to get the data from
- `pos`: The position to get the data from

### Rock Settings

Gets TFC's `RockSettings`, a collection of blocks that define a rock layer, see [custom rock settings]({% link kubejs_tfc/1.20.1/events.md %}#rock-settings), may be null

Method Signatures:

```js
TFC.misc.getRockSettings(level: LevelReader, pos: BlockPos): @Nullable RockSettings
```

- `level`: The level to get the settings from
- `pos`: The position to get the settings from

```js
TFC.misc.getRockSettings(level: LevelAccessor, block: Block): @Nullable RockSettings
```

- `level`: The level to check in
- `block`: The block to check

### Forest Type

Gets TFC's `ForestType` for the given level and position

Method Signature:

```js
TFC.misc.getForestType(level: LevelReader, pos: BlockPos): ForestType
```

- `level`: The level to get the forest type from
- `pos`: The position to get the forest type from

### Get Hydration

Returns a number, in the range [0, 100], an expression of how hydrated soil at the position would be

```js
TFC.misc.getHydration(level: LevelAccessor, posL BlockPos): number
```

- `level`: The level to get the hydration level from
- `pos`: The position to get the hydration level from

### Lerp Float Layer

Returns a `LerpFloatLayer`, an interpolated square of numbers which are known at corners and interpolated between for intermediate values

```js
TFC.misc.lerpFloatLayer(value00: number, value01: number, value10: number, value11: number): LerpFloatLayer
```

- `value00`: The value at the [low x, low z] corner
- `value01`: The value at the [low x, high z] corner
- `value10`: The value at the [high x, low z] corner
- `value11`: The value at the [high x, high z] corner

## Noise Utils

### Open Simplex

TFC uses open simplex noise for most, if not all, of its custom worldgen, these methods provide the ability to create and customize new 2D and 3D versions of TFC's open simplex noise implementation

Method Signatures:

```js
TFC.misc.newOpenSimplex2D(seed: number): OpenSimplex2D
TFC.misc.newOpenSimplex3D(seed: number): OpenSimplex3D
```

- `seed`: The seed for the noise's algorithm

### Metaballs

TFC uses [metaballs](https://en.wikipedia.org/wiki/Metaballs) for its generation of cluster veins, these methods provide the ability to create new 2D and 3D versions of TFC's implementation

Method Signatures:

```js
TFC.misc.newMetaballs2D(random: RandomSource, minBalls: number, maxBalls: number, minSize: number, maxSize: number, radius: number): metaballs2D
TFC.misc.newMetaballs3D(random: RandomSource, minBalls: number, maxBalls: number, minSize: number, maxSize: number, radius: number): Metaballs3D
```

- `random`: The random source used by the metaballs to create variance between instances
- `minBalls`: The minimum number of individual balls
- `maxBalls`: The maximum number of individual balls
- `minSize`: The minimum size of the metaballs
- `maxSize`: The maximum size of the metaballs
- `radius`: The maximum radius of an individual ball

## Metal Utils

### Metal from Fluid

Returns the `Metal` associated with the given fluid, may be null

```js
TFC.misc.getMetal(fluid: Fluid): Metal
```

### Metal from Ingot

Returns the first `Metal` whose ingots match the given stack, may be null

```js
TFC.misc.getMetalFromIngot(ingot: ItemStack): Metal
```

### Metal from Plate

Returns the first `Metal` whose sheets match the given stack, may be null

```js
TFC.misc.getMetalFromSheet(stack: ItemStack): Metal
```

## Other Data Utils

### Lamp Fuel

Gets the first `LampFuel` that matches the given fluid and blockstate, may be null

```js
TFC.misc.getLampFuel(fluid: Fluid, state: BlockState): LampFuel
```

### Drinkable

Gets the first `Drinkable` that matches the given fluid, may be null

```js
TFC.misc.getDrinkable(fluid: Fluid): Drinkable
```

### Fertilizer

Gets the first `Fertilizer` that matches the given stack, may be null

```js
TFC.misc.getFertilizer(stack ItemStack): Fertilizer
```

### Fuel

Gets the first `Fuel` that matches the given stack, may be null

```js
TFC.misc.getFuel(stack: ItemStack): Fuel
```

### Pannable

Gets the first `Pannable` that matches the given block state, may be null

```js
TFC.misc.getPannable(state: BlockState): Pannable
```

### Sluiceable

Gets the first `Sluiceable` that matches the given item, may be null

```js
TFC.misc.getSluiceable(stack: ItemStack): Sluiceable
```
