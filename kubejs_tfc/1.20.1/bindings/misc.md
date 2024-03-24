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

## Rock Map

A string to `RegistryRock` map of all of TFC's rock types

### Example

```js
TFC.misc.rock.get('dacite')
```

## Wood Map

A string to `RegistryWood` map of all of TFC's wood types

### Example

```js
TFC.misc.wood.get('oak')
```

## Heat Utilities

### Get Heat

Gets the `IHeat` of a given item stack, may be null

Method Signature:

```ts
TFC.misc.getHeat(stack: ItemStack): @Nullable IHeat
```

Example:

```js
TFC.misc.getHeat('tfc:metal/ingot/cast_iron').getWeldingTemperature()
```

### Has Heat

Returns true if the given item stack has an `IHeat`

Method Signature:

```ts
TFC.misc.hasHeat(stack: ItemStack): boolean
```

Example:

```js
TFC.misc.hasHeat('tfc:powder/sulfur')
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

```ts
TFC.misc.getFood(stack: ItemStack): @Nullable IFood
```

Example:

```js
TFC.misc.getFood('tfc:food/red_apple').getDecayDateModifier()
```

### Has Food

Returns true if the given item stack has an `IFood`

Method Signature:

```ts
TFC.misc.hasFood(stack: ItemStack): boolean
```

Example:

```js
TFC.misc.hasFood('minecraft:dirt')
```

### Set Rotten

Makes the provided stack rotten if possible and returns it

Method Signature:

```ts
TFC.misc.setRotten(stack: ItemStack): ItemStack
```

### Set Never Expires

Makes it so the provided stack never expires

Method Signature:

```ts
TFC.misc.setNeverExpires(stack: ItemStack): void
```

### Get Food Trait

Retrieves the food trait with the given registry name or null if not found

Method Signature:

```ts
TFC.misc.getFoodTrait(id: string): FoodTrait
```

Example:

```js
TFC.misc.getFoodTrait('kubejs:my_food_trait')
```

### Get Food Trait ID

Returns the id of the given food trait

Method Signature

```ts
TFC.misc.getFoodTraitId(trait: FoodTrait): string
```

## Size Utilities

### Get Size

Returns the `Size` of the given item stack

Method Signature:

```ts
TFC.misc.getSize(stack: ItemStack): Size
```

### Get Weight

Returns the `Weight` if the given item stack

Method Signature:

```ts
TFC.misc.getWeight(stack: ItemStack): Weight
```

## Collapse Utilities

### Can Start Collapse

Returns true if the given level and position can start a collapse

Method Signature:

```ts
TFC.misc.canStartCollapse(level: LevelAccessor, pos: BlockPos): boolean
```

- `level`: The level being checked
- `pos`: The block pos being checked

### Try Collapse

Attempts to cause a collapse at the given level and position, returns false if no collapse or a fake collapse occurred

Method Signature:

```ts
TFC.misc.tryCollapse(level: Level, pos: BlockPos): boolean
```

- `level`: The level where the collapse is trying to be created
- `pos`: The center of where the collapse is trying to be created

### Force Collapse

Forces a collapse to happen at a position, returns true if any blocks started collapsing

Method Signature:

```ts
TFC.misc.forceCollapse(level: Level, pos: BlockPos)
```

- `level`: The level where the collapse will occur
- `pos`: The center of the collapse

## Chunk Data Utilities

### Chunk Data

Gets TFC's `ChunkData` for the given level and position

Method Signature:

```ts
TFC.misc.getChunkData(level: LevelReader, pos: BlockPos): ChunkData
```

- `level`: The level to get the data from
- `pos`: The position to get the data from

### Rock Data

Get's TFC's `RockData` for the given level and position, may be null

Method Signature:

```ts
TFC.misc.getRockData(level: LevelReader, pos: BlockPos): @Nullable RockData
```

- `level`: The level to get the data from
- `pos`: The position to get the data from

### Rock Settings

Gets TFC's `RockSettings`, a collection of blocks that define a rock layer, see [custom rock settings](https://notenoughmail.github.io/kubejs_tfc/1.20.1/events/#rock-settings), may be null

Method Signature:

```ts
TFC.misc.getRockSettings(level: LevelReader, pos: BlockPos): @Nullable RockSettings
```

- `level`: The level to get the settings from
- `pos`: The position to get the settings from

### Forest Type

Gets TFC's `ForestType` for the given level and position

Method Signature:

```ts
TFC.misc.getForestType(level: LevelReader, pos: BlockPos): ForestType
```

- `level`: The level to get the forest type from
- `pos`: The position to get the forest type from

## Noise Utils

### Open Simplex

TFC uses open simplex noise for most, if not all, of its custom worldgen, these methods provide the ability to create and customize new 2D and 3D versions of TFC's open simplex noise implementation

Method Signatures:

```ts
TFC.misc.newOpenSimplex2D(seed: number)
TFC.misc.newOpenSimplex3D(seed: number)
```

- `seed`: The seed for the noise's algorithm

### Metaballs

TFC uses [metaballs](https://en.wikipedia.org/wiki/Metaballs) for its generation of cluster veins, these methods provide the ability to create new 2D and 3D versions of TFC's implementation

Method Signatures:

```ts
TFC.misc.newMetaballs2D(random: RandomSource, minBalls: number, maxBalls: number, minSize: number, maxSize: number, radius: number)
TFC.misc.newMetaballs3D(random: RandomSource, minBalls: number, maxBalls: number, minSize: number, maxSize: number, radius: number)
```

- `random`: The random source used by the metaballs to create variance between instances
- `minBalls`: The minimum number of individual balls
- `maxBalls`: The maximum number of individual balls
- `minSize`: The minimum size of the metaballs
- `maxSize`: The maximum size of the metaballs
- `radius`: The maximum radius of an individual ball
