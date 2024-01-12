---
layout: page
title: Events
permalink: /kubejs_tfc/1.20.1/events/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Events

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
- [Custom Item Stack Modifiers](#custom-item-stack-modifiers)
- [Representative Blocks](#register-representative-blocks)
- [Birthdays](#modify-birthdays)

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

Upon a player closing a container limited through this event, any items that are 1) in the limited slots and are not within the size limits will be removed from the container and spawned in world around the player

This event is fired in the `server_scripts` folder

### Method Signatures

```ts
declare class ContainerLimiterEventJS {
    limit(size: Size, allowsEqual?: boolean): void
    limit(size: Size, min: number, max: number, allowsEqual?: boolean): void
    lowerLimit(size: Size, allowsEqual?: boolean): void
    lowerLimit(size: SIze, min: number, max: number, allowsEqual?: boolean): void
}
```

- `.limit(size: Size, allowsEqual?: boolean)`: Limits the entire container to the specified size, requiring any items in it to be smaller than the provided size. `allowsEqual` determines if a size of `small` will accept items with a size of `small`, defaults to `true`
- `.limit(size: Size, min: number, max: number, allowsEqual?: boolean)`: Limits the specified slot index range to the specified size, requiring any items in it to be smaller than the provided size. `allowsEqual` determines if a size of `small` will accept items with a size of `small`, defaults to `true`
- `.lowerLimit(size: Size, allowsEqual?: boolean)`: Limits the entire container to the specified size, requiring any items in it to be larger than the provided size. `allowsEqual` determines if a size of `small` will accept items with a size of `small`, defaults to `true`
- `.lowerLimit(size: Size, min: number, max: number, allowsEqual?: boolean)`: Limits the specified slot index range to the specified size, requiring any items in it to be larger than the provided size. `allowsEqual` determines if a size of `small` will accept items with a size of `small`, defaults to `true`

Allows size values: `tiny`, `very_small`, `small`, `normal`, `large`, `very_large`, `huge`

Additionally, every event listener requires the name of a menu type[^1] in its declaration

### Examples

```js
TFCEvents.limitContainerSize('minecraft:generic_3x3', event => {
    event.limit('large', 0, 4)
    event.limit('small')
    event.lowerLimit('normal', 0, 2)
})
```

[^1]: A full list of `MenuType`s can be accessed by running `/kubejs dump_registry minecraft:menu` in-game

## Register Climate Model

TFC implements a system for local temperature, rainfall, fog, wind, and more. This is done through a `ClimateModel`

This event is fired in the `startup_scripts` folder

### Method Signatures

```ts
declare class RegisterClimateModelEventJS {
    registerClimateModel(name: string, model: Consumer<KubeJSClimateModel>): void
    registerAdvancedClimateModel(name: string, model: Consumer<AdvancedKubeJSClimateModel>): void
    newVec2(x: number, y: number): Vec2
    getDefaultCurrentTemperatureCallback(): (BevelReader, BlockPos, long, int) => number
    getDefaultAverageTemperatureCallback(): (LevelReader, BlockPos) => number
    getDefaultAverageRainfallCallback(): (LevelReader, BlockPos) => number
    getDefaultAirFogCallback(): (LevelReader, BlockPos, long) => number
    getDefaultWaterFogCallback(): (LevelReader, BlockPos, long) => number
    getDefaultWindVectorCallback(): (BlockContainerJS, long) => Vec2
}
```

The two register methods have the following arguments:

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
    - `.setWindVector(callback)`: Sets the model's calculation for the wind vector at a position and time. The callback provides a `BlockContainerJS` and a `long` and expects a `Vec2` to be returned
        - `BlockContainerJS`: The level and position
        - `long`: The calendar tick
    - `.setOnWorldLoad(Consumer<ServerLevel>)`: Sets the model's actions when the world loads. Only available for advanced models
    - `.setOnChunkLoad(callback)`: Sets the model's actions when a chunk loads. The callback provides a `WorldGenLevel`, `ChunkAccess`, and `ChunkData`. TFC uses this to update blocks on load with climate specific modifications

The `newVec2` method creates a `Vec2` for use in the wind vector callback and has the following arguments:

- 1st argument: A number, the x component of the `Vec2`
- 2nd argument: A number, the z component of the `Vec2`

{: .notice }
Internally, the components of a `Vec2` are labeled `x` and `y`, but TFC uses the `y` component for the `z` direction

The `getDefault` methods return a callback equivalent to that used by TFC's overworld model

### Examples

```js
TFCEvents.registerClimateModel(event => {
    event.registerClimateModel('kubejs:hell', model => {
        model.setCurrentTemperatureCalculation((level, pos, calendarTicks, daysInMonth) => {
            return 100
        })
        model.setAverageTemperatureCalculation((level, pos) => {
            return 100
        })
        model.setAverageRainfallCalculation((level, pos) => {
            return 0
        })
        model.setAirFog((level, pos, calendarTicks) => {
            return 0.25
        })
        model.setWaterFog((level, pos, calendarTicks) => {
            return 0.25
        })
        model.setWindVector((block, calendarTicks) => {
            return event.newVec2(1, 1)
        })
    })
})
```

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

### Method Signature

```ts
declare class ProspectEventJS {
    getEntity(): Player
    getBlock(): Block
    getProspectResult(): ProspectResult
}
```

- `.getEntity()`: Returns the player that prospected
- `.getBlock()`: Returns the found block, or if the prospect result is `nothing`, the clicked block
- `.getProspectResult()`: Results the prospect result, can be `nothing`, `traces`, `small`, `medium`, `large`, `very_large`, and `found`

### Example

```js
TFCEvents.prospect(event => {
    if (event.prospectResult == 'found') {
        event.entity.give('kubejs:gift_box')
    }
})
```

## Logging

This event is fired when a tree is about to be felled by an axe. Cancelling it will cause the block to be broken normally

This event is fired in the `server_scripts` folder

### Method Signature

```ts
declare class LoggingEventJS {
    getLevel(): Level
    getAxe(): ItemStack
    getBlock(): BlockContainerJS
}
```

- `.getLevel()`: Returns the level
- `.getAxe()`: Returns the item stack of the axe used
- `.getBlock()`: Returns the `BlockContainerJS` of the event

### Example

```js
TFCEvents.log(event => {
    if (event.axe.hasTag('kubejs:logging_deny_list')) {
        event.cancel()
    }
})
```

## Animal Product

This event is fired whenever a sheep is sheared, a cow is milked, or similar action happens. Cancelling it will prevent the default behavior, which is controlled by each entity's implementation. This event does not control if an entity can give products, it is for the sole purpose of modifying/blocking what happens when products are made

This event has a product, it may wither be an `ItemStack` or a `FluidStackJS`, not both. Only the non-empty type will retain modifications, attempting to change the type will void the original product

This event is fired in the `server_scripts` folder

### Method Signature

```ts
declare class AnimalProductEventJS {
    getPlayer(): @Nullable Player
    getAnimal(): Entity
    getLevel(): Level
    getBlock(): BlockContainerJS
    getAnimalProperties(): TFCAnimalProperties
    getTool(): ItemStack
    getItemProduct(): ItemStack
    getFluidProduct(): FluidStackJS
    isItemProduct(): boolean
    setItemProduct(item: ItemStack): void
    setFluidProduct(fluid: FluidStackJS): void
    getUses(): number
    setUses(uses: number): number
}
```

- `.getPlayer()`: Returns the player that used the tool, may be null
- `.getAnimal()`: Returns the animal the product comes from
- `.getLevel()`: Returns the level of the event
- `.getBlock()`: Returns the `BlockContainerJS` of the event
- `.getAnimalProperties()`: Returns the [TFCAnimalProperties](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/common/entities/livestock/TFCAnimalProperties.java) of the animal
- `.getTool()`: Returns the tool used
- `.getItemProduct()`: Returns an `ItemStack`, the *item* product, may be empty
- `.getFluidProduct()`: Returns a `FluidStackJS`, the *fluid* product, may be empty
- `.isItemProduct()`: Returns true if the item product is not empty
- `.setItemProduct(item: ItemStack)`: Sets the item product to the given item stack
- `.setFluidProduct(fluid: FluidStackJS)`: Sets the fluid product to the given fluid
- `.getUses()`: Returns how much wear the animal will take from this event
- `.setUses(uses: number)`: Sets the number of uses the animal will take from this event

### Example

```js
TFCEvents.animalProduct(event => {
    if (event.animalProperties.geneticSize < 10) {
        event.cancel()
    }
})
```

## Collapse

This event is fired whenever a collapse happens, including fake collapses

This event is fired in the `server_scripts` folder

### Method Signature

```ts
declare class CollapseEventJS {
    getCenterBlock(): BlockContainerJS
    getLevel(): Level
    getRadiusSquared(): number
    getSecondaryPositions(): List<BlockPos>
    isFake(): boolean
}
```

- `.getCenterBlock()`: Returns the `BlockContainerJS` of the center block of the collapse
- `.getLevel()`: Returns the level of the collapse
- `.getRadiusSquared()`: Returns the squared radius of the collapse, will be `0` if the collapse is fake
- `.getSecondaryPositions()`: Returns a list of `BlockPos`es which are the positions that will collapse
- `.isFake()`: Returns true if the collapse is fake

### Example

```js
TFCEvents.collapse(event => {
    event.secondaryPositions.forEach(pos => {
        event.level.playSound(null, pos, 'minecraft:block.wood.break', 'blocks', 1.0, 1.0)
    })
})
```

## Douse Fire

This event fires when a fire-dousing item is used on a block or a water potion lands

This event fires in the `server_scripts` folder

### Method Signature

```ts
declare class DouseFireEventJS {
    getLevel(): Level
    getBlock(): BlockContainerJS
    getBounds(): AABB
    getPlayer(): @Nullable Player
}
```

- `.getLevel()`: Returns the event's level
- `.getBlock()`: Returns the event's `BlockContainerJS`
- `.getBounds()`: Returns an `AABB` representing the effected area
- `.getPlayer()`: Returns the player that doused the fire, may be null

### Example

```js
// replicates TFC's behavior with regular fire blocks
TFCEvents.douseFire(event => {
    if (event.block.id == 'kubejs:my_burning_block') {
        level.removeBlock(event.block.pos, false)
        event.cancel();
    }
})
```

## Custom Food Traits

Food traits are applied to food items while in a container or after completion of a recipe and are used to effect how fast an item rots

This event fires in the `startup_events` folder

### Method Signature

```ts
declare class RegisterFoodTraitEventJS {
    registerTrait(decayModifier: number, id: string): void
    registerTraitWithTooltip(decayModifier: number, id: string): void
}
```

- `.registerTrait(decayModifier: number, id: string)`: Registers a food trait under the given id with the provided decay modifier
- `registerTraitWithTooltip(decayModifier: number, id: string)`: Registers a food trait under the given id with the provided decay modifier, this trait will have a tooltip on the item with a translation key of `<id namespace>.tooltip.foodtrait.<id path>`

**Note**: A higher `decayModifier` means the food rots faster

### Examples

```js
TFCEvents.registerFoodTrait(event => {
    event.registerTrait(2.0, 'kubejs:trash')
    event.registerTraitWithTooltip(1.2, 'kubejs:stinky')
})
```

## Custom Item Stack Modifiers

TFC uses [item stack modifiers](https://terrafirmacraft.github.io/Documentation/1.20.x/data/item-stack-modifiers/) to well, modify item stacks created by recipes that support [item stack providers](https://terrafirmacraft.github.io/Documentation/1.20.x/data/common-types/#item-stack-providers). This event allows you to register custom modifiers with new functionality

This event fires in the `startup_scripts` folder

### Method Signature

```ts
event.register(id: string, applicator: ModifierApplicator, dependsOnInput: boolean): void
```

- 1st argument: A string, the registry name of the modifier being registered
- 2nd argument: A [ModifierApplicator](#modifier-applicator), performs the modifications to the item stack
- 3rd argument: A boolean, should be true if the `input` of the applicator is used

Additionally, there is another method in the event `.getCraftingContainer()`, which returns a `Supplier<@Nullable CraftingContainer>`, the crafting container is only non-null during advanced shaped and shapeless crafting recipes

### Example

```js
TFCEvents.registerItemStackModifier(event => {
    event.register('kubejs:merge_nbt', (stack, input) => {
        stack.getOrCreateTag().merge(input.getOrCreateTag())
        return stack
    }, true)
})
```

### Modifier Applicator

A modifier applicator is what actually performs the modifications on a stack when constructed for a recipe, it has the following method signature:

```ts
apply(stack: ItemStack, input: ItemStack): ItemStack
```

- `stack`: This is the stack being built, you are free to modify it in any way
- `input`: This is the input stack, it should not be modified in any way, if it is used, the modifier you register should have `true` for the `dependsOnInput` argument

## Register Representative Blocks

In 1.20, TFC added a representative blocks system for prospecting, essentially allowing ores of the same type but different grades to be viewed as the same when the prospector's pick counts the blocks nearby, this event allows you to register new representatives

This event fires in the `startup_scripts` folder

### Method Signature

```ts
event.register(representative: string, blocks: List<string>): void
```

- 1st argument: The registry name of the block to be representative of the others
- 2nd argument: A list of strings, the registry names of blocks to be represented by the representative

### Example

```js
TFCEvents.prospectRepresentative(event => {
    event.register('minecraft:clay', ['tfc:clay/loam', 'tfc:clay/silt', 'tfc:clay/sandy_loam', 'tfc:clay/silty_loam'])
})
```

## Modify Birthdays

TFC has an easter egg in its calendar screen where on certain dates it will show someone's birthday, this event allows you to add and remove names from the list of birthdays

This event fires in the `startup_scripts` folder

### Method Signatures

```ts
declare class BirthdayEventsJS {
    add(month: Month, day: number, name: string): void
    remove(month: Month, day: number): void
    removeAll(): void
}
```

- `.add(month: Month, day: number, name: string)`: Adds a birthday to the given month and day
- `.remove(month: Month, day: number)`: Removes the birthday on the given month and day if there is one
- `.removeAll()`: Removes all birthdays

### Example

```js
TFCEvents.birthdays(event => {
    event.add('august', 4, 'Barack Obama')
})
```
