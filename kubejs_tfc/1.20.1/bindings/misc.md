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
- [Foo utilities](#food-utilities)
- [Size Utilities](#size-utilities)
- [Collapse Utilities](#collapse-utilities)

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

- `level`: THe level where the collapse will occur
- `pos`: The center of the collapse