---
layout: page
title: Events
permalink: /kubejs_tfc/1.18.2/events/
parent: 1.18.2
grand_parent: KubeJS TFC
---

# Events

KubeJS TFC adds several JS events for use in your scripts

- [Rock Settings](../worldgen/#rock-layers)
- [limiting Containers](#limiting-containers)
- [Register Climate Model](#register-climate-model)
- [Select Climate model](#select-climate-model)
- [Start Fire](#start-fire)
- [Prospect](#prospect)
- [Logging](#logging)
- [Animal product](#animal-product)
- [Collapse](#collapse)

It is highly recommended to use [ProbeJS](https://www.curseforge.com/minecraft/mc-mods/probejs) when working with these

---

# Limiting Containers

This event can be used in the `startup_scripts` folder.

TFC has an item size feature which it uses to limit which items can go into its containers. KubeJS TFC allows you to somewhat replicate this for other mod's containers, with some limitations:
- It will only be able to apply to a container which registers a MenuType
- It only applies to player interactions
- It only applies upon *closing* a menu

The basic functionality of this is based off of a 1.12 [addon](https://github.com/DoubleDoorDevelopment/OversizedItemInStorageArea) that did much the same. It is licensed under the [BSD License](https://www.curseforge.com/minecraft/mc-mods/oversized-item-in-storage-area/comments#license)

Upon a player closing a limited container any items that are (1) in the limited slots and (2) greater than the provided size will be removed from the container and spawned in world around the player

## Usage
This is available through a new startup event, `tfc.limit_container_size`, with a single method, `limitContainerSize`, available
- 1st argument: A string, the registry name of a menu
  - A full list of available menus can be found by running the command `/kubejs dump_registry minecraft:menu` in-game
- 2nd argument: A string, the maximum size of items allowed in the declared slots
  - Valid values: 
    - tiny
    - very_small
    - small
    - normal
    - large
    - very_large
    - huge
- *optional 3rd argument*: An integer array, representing the specific range of indexes of the container's slots which should be limited, defaults to all slots in the container
  - This will accept any multiple of 2 number of integers (i.e. {0, 2} or {1, 3, 5, 7})

## Examples
```js
onEvent('tfc.limit_container_size', event => {
    // Limits the hopper to only have normal or smaller item sizes
    event.limitContainerSize('minecraft:hopper', 'normal')
    // Limits shulker boxes to very small or smaller items for slots 0 through 8 and 18 through 26
    event.limitContainerSize('minecraft:shulker_box', 'very_small', 0, 8, 18, 26)
})
```

# Register Climate Model

This event can be used in the `startup_scripts` folder

TFC implements local temperature and rainfall, this is done through the use of climate models. This event has two methods `registerClimateModel` and `registerAdvancedClimateModel`. Both events take a resource location, the name of the model being registered, and a climate model consumer, which defines how your custom model behaves; the second method has the ability to set custom behaviors on world and chunk load in its consumer.

## Consumer
- `setCurrentTemperatureCalculation(callback)`: Sets the calculation for current temperature at a position. The callback provides:
  - A `LevelReader`, the level
  - A `BlockPos`, the position
  - A `Long`, the calendar ticks
  - An `Integer`, the number of days in a month
  - And expects a number
- `setAverageTemperatureCalculation(callback)`: Sets the calculation for the average temperature at a position. The callback provides: 
  - A `LevelReader`, the level
  - A `BlockPos`, the position
  - And expects a number
- `setAverageRainfallCalculation(callback)`: Sets the calculation for the average rainfall at a position. The callback provides:
  - A `LevelReader`, the level
  - A `BlockPos`, the position
  - And expects a number between 0 and 500
- `setAirFog(callback)`: Sets the fogginess at a position and time. The callback provides:
  - A `LevelReader`, the level
  - A `BlockPos`, the position
  - A `Long`, the calendar ticks
  - And expects a number between 0 and 1
- `setWaterFog(callback)`: Sets the water fogginess at a position and time. The callback provides:
  - A `LevelReader`, the level
  - A `BlockPos`, the position
  - A`Long`, the calendar ticks
  - And expects a number between 0 and 1
- `getClimateSeed()`: Returns the climate seed, a number based on the level's seed
- `getNewnoise()`: Returns an OpenSimplex2D noise generator.
- `getTemperatureSettings()`: Returns the level's temperature [climate settings](https://terrafirmacraft.github.io/Documentation/1.18.x/worldgen/dimension/#climate-settings), or the default if none
- `getRainfallSettings()`: Returns the level's rainfall climate settings, or default if none
- `averageTemperature`: Returns a reference to the model's average temperature calculation, use `getValue(LevelReader, BlockPos)` to get its value
- `averageRainfall`: Returns a reference to the model's average rainfall calculation, use `getValue(LevelReader, BlockPos)` to get its value
- `currentTemperature`: Returns a reference to the model's current temperature calculation, use `getValue(LevelReader, BlockPos, Long, Int) to get its value
- `airFog`: Returns a reference to the model's air fog calculation, use `getValue(LevelReader, BlockPos, Long)` to get its value
- `waterFog`: Returns a reference to the model's water fog calculation, use `getValue(LevelReader, BlockPos, Long)` to get its value

If registering an advanced model the following are also available
- `setOnWorldLoad(callback)`: Sets what should be done upon the world loading. The callback provides:
  - A `ServerLevel`, the level
- `setOnChunkLoad(callback)`: Sets what should be done upon a chunk loading, by default this is only called during world generation and TFC's update climate command. The callback provides:
  - A `WorldGenLevel`, the level
  - A `ChunkAccess`, the chunk
  - A `ChunkData`, the chunk's TFC data

## Example
```js
onEvent('tfc.climate_model.register', event => {
    event.registerClimateModel('kubejs:my_model', model => {
        model.setAverageTemperatureCalculation((level, pos) => {
            return (pos.x + pos.z) / 2000 + (pos.y / 60)
        })
        model.setAirFog((level, pos, calendarTicks) => {
            return JavaMath.sin(Calendar.getCalendar(level).getCalendarDayTime() / 12000 * JavaMath.PI);
        })
    })
    event.registerAdvancedClimateModel('kubejs:my_advanced_model', model => {
         model.setOnWorldLoad(level => {
             console.log(`Loading into dimension: ${level.dimension}`)
         })
    })
})
```

# Select Climate Model

This event can be used in the `startup_scripts`or `server_scripts` folders. It can be reloaded at any time.

TFC implements local temperature and rainfall, this is done through the use of climate models. Whenever a world is loading or selecting its climate model, this event is fired. It is only fired on the server.

## Methods
### getLevel()
Returns the level
### getModel()
Returns the climate model that applies to the level, defaults to BiomeBasedClimateModel. TFC sets the Overworld to use the OverworldCliamteModel.
### getmodelName()
Returns the climate model's id
### setModel(ClimateModel)
Sets the climate model to use for the associated level. This will accept the name of a climate model or a direct reference to a climate model object

## Example
```js
onEvent('tfc.climate_model.select', event => {
    event.getLevel()
    event.getModel()
    event.setModel('kubejs:my_model')
})
```

# Start Fire

This event can be used in the `startup_scripts` or `server_scripts` folders. It can be reloaded at any time. It can be cancelled.

TFC uses this event for lighting fires or optionally light-able blocks. This event *should* be cancelled if it was handled here. If you want your items to act like Flint and Steel or Torches, add them to either the `tfc:starts_fires_with_items` tag or the `tfc:starts_fires_with_durability` tags.

## Methods
### getLevel()
Returns the level
### getBlock()
Returns a BlockContainerJS of the clicked position
### getTargetedFace()
Returns the block face that was clicked
### getItem()
Returns the ItemStackJS representing the item used
### getFireResult()
Returns the [FireResult](../misc/#fireresult) of the event. Defaults to FireResult.IF_FAILED.
### setFireResult(FireResult)
Sets the event's FireResult
### isStrong()
Returns a boolean indicating if the event's [FireStrength](../misc/#firestrength) is strong
### getEntity()
Returns the EntityJS of the player that performed the fire start, may be null
### getServer()
Returns the ServerJS of the level, may be null

## Example
```js
onEvent('tfc.start_fire', event => {
    if (event.getBlock().getCanSeeLight() && event.getFireResult() === FireResult.IF_FAILED) {
         console.info(event.getFireResult())
         event.setFireResult(FireResult.ALWAYS)
         event.cancel()
    }
}) 
```

# Prospect

This event can be used in the `startup_scripts` or `server_scripts` folders. It can be reloaded at any time.

Whenever a prospector's pick used this event is fired. It is purely informational and cannot change anything.

## Methods
### getEntity()
Returns the EntityJS of the player that prospected
### getPlayer()
Returns the PlayerJS of the player that prospected
### getMinecraftPlayer()
Returns the Player of the player that prospected
### getLevel()
Returns the LevelJS of the player that prospected
### getServer()
Returns the ServerJS of the level, may be null
### getProspectResult()
Returns the ProspectResult of the event

## Example
```js
onEvent('tfc.prospect', event => {
    event.getPlayer().addItemCooldown(event.getPlayer().getInventory().get(event.getPlayer().getSelectedSlot()).getitem(), 2000)
})
```

# Logging

This event can be used in the `startup_scripts` or `server_scripts` folders. It can be reloaded at any time. It can be cancelled.

This event is fired when a tree is about to be felled by an axe. Cancelling it will cause the block to be broken normally.

## Methods
### getLevel()
Returns the LevelJS of the event
### getAxe()
Returns the ItemStackJS of the axe used
### getBlock()
Returns the BlockContainerJS of the block broken

## Example
```js
onEvent('tfc.logging', event => {
    if (event.getAxe().hasTag('kubejs:logging_deny_list')) {
         event.cancel()
    }
})
```

# Animal Product

This event can be used in the `startup_scripts` or `server_scripts` folders. It can be reloaded at any time. It can be cancelled.

This event is fired whenever a sheep is sheared, a cow is milked, or similar action happens, cancelling it will prevent the default behavior, which is controlled by each entity's implementation. This event does not control if an entity can give products, it is for the sole purpose of modifying/blocking what happens when products are made.

This event has a product, it may either be an ItemStackJS or a FluidStackJS, not both. Only the non-empty type will retain modifications, attempting to change the type will void the the original product.

## Methods
### getEntity()
Returns the EntityJS that the product comes from
### getPlayer()
Returns the PlayerJS that used the tool
### getLevel()
Returns the LevelJS of the event
### getBlock()
Returns the BlockContainerJS at the position of the animal
### getAnimalproperties()
Returns the TFCAnimalProperties of the animal
### getTool()
Returns the ItemStackJS of the held item, usually a bucket or shears
### getItemProduct()
Returns the ItemStackJS of the product, may be empty
### getFluidProduct()
Returns the FluidStackJS of the product, may be empty
### isItemProduct()
Returns true if the item product isn't empty
### setItemProduct(ItemStackJS)
Sets the item product
### setFluidProduct(FluidStackJS)
Sets the fluid product
### getUses()
Returns the amount of wear the animal will take from this happening
### setuses(Integer)
Sets the amount of wear the animal will take from this happening
### getMinecraftPlayer()
Returns the Player of the player that used the tool, may be null
### getServer()
Returns the ServerJS of the level

## Example
```js
onEvent('tfc.animal_product', event => {
    if (event.getAnimalProperties().getGender() === AnimalGender.FEMALE) {
         event.cancel()
    }
})
```

# Collapse

This event can be used in the `startup_scripts` or `server_scripts` folders. It can be reloaded at any time.

This event is fired whenever a collapse happens, including fake/visual-only collapses.

## Methods
### getCenterBlock()
Returns the BlockContainerJS of the center block
### getLevel()
Returns the LevelJS of the event
### getRadiusSquared()
Returns the squared radius of the collapse, will be 0 if the collapse is fake
### getSecondaryPositions()
Returns a `List<BlockPos>` containing the positions of blocks also effected by the collapse
### isFake()
Returns true if the collapse is fake

## Example
```js
onEvent('tfc.collapse', event -> {
    event.secondaryPositions.forEach(pos -> {
         event.level.minecraftLevel.playSound(null, pos, 'minecraft:block.wood.break', 'blocks', 1.0, 1.0)
    })
})
```