---
layout: page
title: Events
permalink: /kubejs_tfc/1.20.1/events/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Events

{: .notice }
Work In Progress!

KubeJS TFC adds several JS events for use in your scripts

- [Rock Settings](#rock-settings)
- [Limiting Containers](#limiting-containers)
- [Register Climate Model](#register-climate-model)
- [Select Climate Model](#select-climate-model)
- [Start Fire](#start-fire)
- [Prospect](#prospect)
- [Logging](#logging)
- [Animal Product](#animal-product)
- [Collapse](#collapse)
- [Douse Fire](#douse-fire)
- [Custom Food Traits](#custom-food-traits)

## Rock Settings

Defines a new layer or overrides an existing layer which can be referenced from a [world preset json](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/data/tfc/worldgen/world_preset/overworld.json)

This event is fired in the `startup_scripts` folder

### Method Signature

```ts
event.defineLayer(
    id: string,
    raw: string,
    hardened: sting,
    gravel: string,
    cobble: string,
    sand: string,
    sandstone: string,
    spike: @Nullable string,
    loose: @Nullable string,
    mossyLoose: @Nullable string
)
```

- 1st argument: A string, the registry name of the rock layer
- 2nd argument: A string, the registry name of a block to be used as the raw stone block of the layer
- 3rd argument: A string, the registry name of a block to be used as the hardened stone block of the layer
- 4th argument: A string, the registry name of a block to be used as the gravel block of the layer
- 5th argument: A string, the registry name of a block to be used as the cobble block of the layer
- 6th argument: A string, the registry name of a block to be used as the sand block of the layer
- 7th argument: A string, the registry name of a block to be used as the sandstone block of the layer
- 8th argument: A string, the registry name of a block to be used as the spike block of the layer, may be null
- 9th argument: A string, the registry name of a block to be used as the loose rock block of the layer, may be null
- 10th argument: A string, the registry name of a block to be used as the mossy loose rock block of the layer, may be null

### Example

```js
TFCEvents.rockSettings(event => {
    event.defineLayer('kubejs:vanilla_layer', 'minecraft:stone', 'minecraft:deepslate', 'minecraft:gravel', 'minecraft:cobblestone', 'minecraft:sand', 'minecraft:sandstone', null, null, null)
})
```

## Limiting Containers

{: .deprecated }
> In its current state, this event is, not bad, but suboptimal and my be reworked in the future to be more flexible 

TFC has an item size feature which it uses to limit which items can go into its containers. KubeJS TFC allows you to somewhat replicate this behavior with other mods' containers, with some limitations

- It will only be able to apply to a container which registers a `MenuType`
- It only applies to player interactions
- It only applies upon *closing* a menu

The basic functionality and idea is based off of a 1.12 [addon](https://github.com/DoubleDoorDevelopment/OversizedItemInStorageArea) that did much the same. It is licensed under the [BSD License](https://www.curseforge.com/minecraft/mc-mods/oversized-item-in-storage-area/comments#license)

Upon a player closing a container limited through this event, any items that are 1) in the limited slots and 2) greater than the provided size will be removed from the container and spawned in world around the player

This event is fired in the `startup_scripts` folder

### Method Signature

```ts
event.limitContainerSize(containerName: string, size: Size, range?: Integer[])
```

- 1st argument: A string, the registry name of a menu to be limited[^1]
- 2nd argument: A `Size`, the maximum size of items allowed in the declared slots, accepts `tiny`, `very_small`, `small`, `normal`, `large`, `very_large`, and `huge`
- *Optional 3rd argument*: An integer array, representing the specific range of slot indexes of the container which should be limited, defaults to all slots of the container. Only accepts integers in multiples of 2, i.e. `0, 2` or `1, 5, 7, 16`

### Examples

```js
TFCEvents.limitContainerSize(event => {
    event.limitContainerSize('minecraft:hopper', 'small')
    event.limitContainerSize('minecraft:shulker_box', 'very_small', 0, 8, 18, 26) // Does not limit the middle row
})
```

[^1]: A full list of `MenuType`s can be accessed by running `/kubejs dump_registry minecraft:menu` in-game

## Register Climate Model

{: .notice }
Work in progress!

TFC implements a system for local temperature, rainfall, fog, wind, and more. This is done through a `ClimateModel`

This event is fired in the `startup_scripts` folder

### Method Signatures

```ts
event.registerClimateModel(name: string, model: Consumer<KubeJSClimateModel>)
event.registerAdvancedClimateModel(name: string, model: Consumer<AdvancedKubeJSClimateModel>)
```

- 1st argument: A string, the registry name of the model
- 2nd argument: A consumer with several methods:
    - `setCurrentTemperatureCalculation(callback)`: Sets the model's calculation for the current temperature at a position. The callback provides a `LevelReader`, `BlockPos`, `long`, and `int` and expects a number to be returned
        - `LevelReader`: The level reader
        - `BlockPos`: The position
        - `long`: The calendar tick
        - `int`: The number of days in a month
    - `setAverageTemperatureCalculation(callback)`: Sets the model's calculation for the average yearly temperature at a position. The callback provides a `LevelReader` and `BlockPos` and expects a number to be returned
        - `LevelReader`: The level reader
        - `BlockPos`: The position
    - `setAverageRainfallCalculation(callback)`: Sets the model's calculation for the average yearly rainfall at a position. The callback provides a `LevelReader` and `BlockPos` and expects a number to be returned
        - `LevelReader`: The level reader
        - `BlockPos`: The position
        - `.setAirFog(callback)`: Sets the model's calculation for fogginess at a position and time. The callback provides a `LevelReader`, `BlockPos`, and `long` and expects a number, in the range [0, 1], to be returned
            - `LevelReader`: The level reader
            - `BlockPos`: The position
            - `long`: The calendar tick
        - `.setWaterFog(callback)`: Sets the model's calculation for water fogginess at a position and time. The callback provides a `LevelReader`, `BlockPos`, and `long` and expects a number, in the range [0, 1], to be returned
            - `LevelReader`: The level reader
            - `BlockPos`: The position
            - `long`: The calendar tick
        - `.setWindVector(callback)`: Sets the model's calculation for the wind vector

## Select Climate Model

This event is fired when a world is loading and selecting the climate model to use

This event is fired in the `server_scripts` folder

### Method Signatures

```ts
declare class SelectClimateModelEventJS {
    getLevel(): Level
    getModel(): ClimateModel
    getModelName(): ResourceLocation
    setModel(model: ClimateModel): void
}
```

- `.getLevel()`: Returns the event's level
- `.getModel()`: Returns the events current model, defaults to a biome based model, TFC sets the overworld to use its own overworld model
- `.getModelName()`: Returns the registry name of the event's current model
- `setModel(model: ClimateModel)`: Sets the events climate model

### Example

```js
TFCEvents.selectClimateModel(event => {
    if (event.level.dimensionKey.location() == 'minecraft:nether') {
        event.setModel('kubejs:hell')
    }
})
```

## Start Fire

TFC uses this event for lighting fires or optionally light-able blocks. This event *should* be cancelled if it was handled here. If you want your items to act like Flint and Steel or Torches, add them to either the `tfc:starts_fires_with_items` tag or the `tfc:starts_fires_with_durability` tags.

This event is fired in the `server_scripts` folder

### Method Signatures

```ts
declare class StartFireEventJS {
    getLevel(): Level
    getBlock(): BlockContainerJS
    getTargetedFace(): Direction
    getEntity(): @Nullable Player
    getItem(): ItemStack
    isString(): boolean
}
```

- `.getLevel()`: Returns the level of the event
- `.getBlock()`: Returns the `BlockContainerJS` of the event
- `getTargetedFace()`: Returns the direction of the clicked face
- `.getEntity()`: Returns the player of the event, may be null
- `.getItem()`: Returns the item stack used to start the fire
- `.isString()`: Returns true if the event is strong

### Example

```js
// Enables the player to light a charcoal forge underneath a Create fluid tank
const CharcoalForgeBlock = Java.loadClass("net.dries007.tfc.common.blocks.devices.CharcoalForgeBlock")
const CharcoalForge = Java.loadClass("net.dries007.tfc.common.blockentities.CharcoalForgeBlockEntity")

TFCEvents.startFire(event =>{
    if (event.block.id == 'create:fluid_tank' && CharcoalForgeBlock.isValid(event.level, event.block.down.pos,) && event.isStrong()) {
        let be = event.block.down.entity
        if (be instanceof CharcoalForge && be.light(event.block.down.blockState)) {
            event.cancel()
        }
    }
})
```

## Prospect

Whenever a prospector's pick is used, this event is fired. It is purely informational and cannot change anything

This event is fired in the `server_scripts` folder

## Logging

## Animal Product

## Collapse

## Douse Fire

## Custom Food Traits