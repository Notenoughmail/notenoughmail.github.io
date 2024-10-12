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
- [Register Interactions](#register-interactions)
- [Modifying Worldgen Defaults](#modifying-worldgen-defaults)
- [Register Fauna Definitions](#register-fauna-definitions)

## Rock Settings

- **Type**: `startup_scripts`

Defines a new layer or overrides an existing layer which can be referenced from a [world preset json](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/data/tfc/worldgen/world_preset/overworld.json)

### Method Signature

```ts
event.defineRock(
    id: string,
    raw: Block,
    hardened: Block,
    gravel: Block,
    cobble: Block,
    sand: Block,
    sandstone: Block,
    spike: @Nullable Block,
    loose: @Nullable Block,
    mossyLoose: @Nullable Block
)
```

- 1st argument: A block, the registry name of the rock
- 2nd argument: A block, to be used as the raw stone block of the rock
- 3rd argument: A block, to be used as the hardened stone block of the rock
- 4th argument: A block, to be used as the gravel block of the rock
- 5th argument: A block, to be used as the cobble block of the rock
- 6th argument: A block, to be used as the sand block of the rock
- 7th argument: A block, to be used as the sandstone block of the rock
- 8th argument: A block, to be used as the spike block of the rock, may be null
- 9th argument: A block, to be used as the loose rock block of the rock, may be null
- 10th argument: A block, to be used as the mossy loose rock block of the rock, may be null

### Example

```js
TFCEvents.rockSettings(event => {
    event.defineRock('kubejs:vanilla_layer', 'minecraft:stone', 'minecraft:deepslate', 'minecraft:gravel', 'minecraft:cobblestone', 'minecraft:sand', 'minecraft:sandstone', null, null, null)
})
```

## Limiting Containers

- **Type**: `server_scripts`

TFC has an item size feature which it uses to limit which items can go into its containers. KubeJS TFC allows you to somewhat replicate this behavior with other mods' containers, with some limitations

- It will only be able to apply to a container which registers a `MenuType`
- It only applies to player interactions
- It only applies upon *closing* a menu

The basic functionality and idea is based off of a 1.12 [addon](https://github.com/DoubleDoorDevelopment/OversizedItemInStorageArea) that did much the same. It is licensed under the [BSD License](https://www.curseforge.com/minecraft/mc-mods/oversized-item-in-storage-area/comments#license)

Upon a player closing a container limited through this event, any items that are 1) in the limited slots and are not within the size limits will be removed from the container and spawned in world around the player

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
TFCEvents.limitContainer('minecraft:generic_3x3', event => {
    event.limit('large', 0, 4)
    event.limit('small')
    event.lowerLimit('normal', 0, 2)
})
```

[^1]: A full list of `MenuType`s can be accessed by running `/kubejs dump_registry minecraft:menu` in-game

## Register Climate Model

- **Type**: `startup_scripts`

TFC implements a system for local temperature, rainfall, fog, wind, and more. This is done through a `ClimateModel`

### Method Signatures

```ts
declare class RegisterClimateModelEventJS {
    registerClimateModel(name: string, model: Consumer<KubeJSClimateModel>): void
    registerAdvancedClimateModel(name: string, model: Consumer<AdvancedKubeJSClimateModel>): void
    newVec2(x: number, y: number): Vec2
    getDefaultCurrentTemperatureCallback(): (LevelReader, BlockPos, long, int) => number
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
    - `.setOnChunkLoad(callback)`: Sets the model's actions when a chunk loads. The callback provides a `WorldGenLevel`, `ChunkAccess`, and `ChunkData`. TFC uses this to update blocks on load with climate specific modifications. Only available for advanced models

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

- **Type**: `server_scripts`

This event is fired when a world is loading and selecting the climate model to use

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

- **Type**: `server_scripts`

TFC uses this event for lighting fires or optionally light-able blocks. This event *should* be cancelled if it was handled here. If you want your items to act like Flint and Steel or Torches, add them to either the `tfc:starts_fires_with_items` tag or the `tfc:starts_fires_with_durability` tags.

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
- `.isStrong()`: Returns true if the event is strong

### Example

```js
// Enables the player to light a charcoal forge underneath a Create fluid tank
const CharcoalForgeBlock = Java.loadClass("net.dries007.tfc.common.blocks.devices.CharcoalForgeBlock")
const CharcoalForge = Java.loadClass("net.dries007.tfc.common.blockentities.CharcoalForgeBlockEntity")

TFCEvents.startFire(event =>{
    if (event.block.id == 'create:fluid_tank' && CharcoalForgeBlock.isValid(event.level, event.block.down.pos) && event.isStrong()) {
        let be = event.block.down.entity
        if (be instanceof CharcoalForge && be.light(event.block.down.blockState)) {
            event.cancel()
        }
    }
})
```

## Prospect

- **Type**: `server_scripts`

Whenever a prospector's pick is used, this event is fired. It is purely informational and cannot change anything

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

- **Type**: `server_scripts`

This event is fired when a tree is about to be felled by an axe. Cancelling it will cause the block to be broken normally

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

- **Type**: `server_scripts`

This event is fired whenever a sheep is sheared, a cow is milked, or similar action happens. Cancelling it will prevent the default behavior, which is controlled by each entity's implementation. This event does not control if an entity can give products, it is for the sole purpose of modifying/blocking what happens when products are made

This event has a product, it may wither be an `ItemStack` or a `FluidStackJS`, not both. Only the non-empty type will retain modifications, attempting to change the type will void the original product

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
    setUses(uses: number): void
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

- **Type**: `server_scripts`

This event is fired whenever a collapse happens, including fake collapses

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

- **Type**: `server_scripts`

This event fires when a fire-dousing item is used on a block or a water potion lands

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
- `.getBounds()`: Returns an `AABB` representing the total effected area
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

- **Type**: `startup_scripts`

Food traits are applied to food items while in a container or after completion of a recipe and are used to effect how fast an item rots

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

- **Type**: `startup_scripts`

TFC uses [item stack modifiers](https://terrafirmacraft.github.io/Documentation/1.20.x/data/item-stack-modifiers/) to, as one might imagine, modify item stacks created by recipes that support [item stack providers](https://terrafirmacraft.github.io/Documentation/1.20.x/data/common-types/#item-stack-providers). This event allows you to register custom modifiers with new functionality

### Method Signatures

```ts
declare class RegisterItemStackModifierEventJS {
    simple(id: string, applicator: Function<ItemStack, ItemStack>): void
    withInput(id: string, applicator: BiFunction<ItemStack, ItemStack, ItemStack>): void
    withInventory(id: string, applicator: TriFunction<ItemStack, ItemStack, Iterable<ItemStack>, ItemStack>): void
}
```

- `simple(id: string, applicator: Function<ItemStack, ItemStack>)`: Registers a modifier that is not input dependent
    - Id: A string, the registry id to register the modifier as
    - Applicator: A function that receives and returns an `ItemStack`, the output stack. Performs the modifications to the output stack
- `withInput(id: string, applicator: BiFunction<ItemStack, ItemStack, ItemStack>)`: Registers a modifier that is input dependent
    - Id: A string, the registry id to register the modifier as
    - Applicator: A bi-function that receives two `ItemStack`s, the output stack and the input stack[^2], and returns an `ItemStack`, the modified output stack. Performs the modifications to the output stack
- `withInventory(id: string, applicator: TriFunction<ItemStack, ItemStack, Iterable<ItemStack>, ItemStack>)`: Registers a modifier that is input dependent and has access to an iterable view of the input inventory
    - Id: A string, the registry id to register the modifier as
    - Applicator: A tri-function that receives two `ItemStack`s, the output stack and the input stack[^2], and an `Iterable<ItemStack>`, an iterable view of the input inventory, and returns an `ItemStack`, the modified output stack. Performs the modifications to the output stack

[^2]: This stack should *not* be modified at all

### Examples

```js
TFCEvents.registerItemStackModifier(event => {
    // Doubles the stack size of the output
    event.simple('kubejs:double', stack => {
        stack.grow(stack.count);
        return stack;
    })
    // Copies the input stack's nbt data to the output if present
    event.withInput('kubejs:copy_nbt', (output, input) => {
        let { nbt } = input
        if (nbt) {
            output.orCreateTag.merge(nbt)
        }
        return output
    })
    // Copies all of the input stacks' nbt into the output stack
    event.withInventory('kubejs_copy_all_nbt', (output, input, inventory) => {
        inventory.forEach(stack => {
            let { nbt } = stack;
            if (nbt) {
                output.orCreateTag.merge(nbt)
            }
        })
        return nbt
    })
})
```

## Register Representative Blocks

- **Type**: `startup_scripts`

In 1.20, TFC added a representative blocks system for prospecting, essentially allowing ores of the same type but different grades to be viewed as the same when the prospector's pick counts the blocks nearby, this event allows you to register new representatives

### Method Signature

```ts
event.register(representative: Block, blocks: Block[]): void
```

- 1st argument: The block to represent the other blocks
- 22nd argument: An array of blocks, to be represented by the first argument when prospecting

### Example

```js
TFCEvents.prospectRepresentative(event => {
    event.register('minecraft:clay', ['tfc:clay/loam', 'tfc:clay/silt', 'tfc:clay/sandy_loam', 'tfc:clay/silty_loam'])
})
```

## Modify Birthdays

- **Type**: `startup_scripts`

TFC has an easter egg in its calendar screen where on certain dates it will show someone's birthday, this event allows you to add and remove names from the list of birthdays

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

## Register interactions

- **Type**: `startup_scripts`

TFC has a custom system for performing certain interactions with items, most notably knapping, this event exposes the ability to create your own interactions

### Method Signatures

```ts
declare class RegisterInteractionsEventJS {
    interaction(ingredient: Ingredient, targetBlocks: boolean, targetAir: boolean, action: OnItemUseAction): void
    interaction(ingredient: Ingredient, targetAir: boolean, action: OnItemUseAction): void
    interaction(ingredient: Ingredient, action: OnItemUseAction): void
    blockItemPlacement(item: Item, block: Block): void
}
```

- `.interaction(ingredient: Ingredient, targetBlocks: boolean, targetAir: boolean, action: OnItemUseAction)`: Registers the given ingredient for the provided [action](#onitemuseaction), the boolean params determine if blocks and air should be valid targets
- `.interaction(ingredient: Ingredient, targetAir: boolean, action: OnItemUseAction)`: Registers the given ingredient for the provided [action](#onitemuseaction), the boolean param determines if air is a valid target, blocks default to being a valid target
- `.interaction(ingredient: Ingredient, action: OnItemUseAction)`: Registers the given ingredient for the provided [action](#onitemuseaction), defaulting to blocks being valid targets and air not
- `.blockItemPlacement(item: Item, block: Block)`: Registers a block placement for the given item, placing the given block

### Example

```js
TFCEvents.registerInteractions(event => {
    event.interaction('minecraft:diamond', (stack, ctx) => {
        // Do what ever you want when a diamond is right clicked
        return 'pass'
    })
})
```

### OnItemUseAction

The basis of an interaction, a callback that takes a `ItemStack`, the item in the hand, and a `UseOnContext`, the context of the event, and returns an `InteractionResult`. It has the following method signature:

```js
apply(stack: ItemStack, context: UseOnContext): InteractionResult
```

## Modifying Worldgen defaults

**Type**: `startup_scripts`

Allows for editing the default settings of TFC chunk generator at world creation, including editing the rock layers

### Method Signatures

```ts
declare class ModifyDefaultWorldgenSettingsEventJS {
    flatBedrock(flat?: boolean): void
    setSpawnDistance(i: number): void
    setSpawnCenterX(i: number): void
    setSpawnCenterZ(i: number): void
    setTemperatureScale(i: number): void
    setTemperatureConstant(f: number): void
    setRainfallScale(i: number): void
    setRainfallConstant(f: number): void
    setContinentalness(f: number): void
    setGrassDensity(f: number): void
    addRock(rock: RockSettings, name: string, bottom: boolean): void
    addRockFromId(id: string, name: string, bottom: boolean): void
    getRock(name: string): RockSettings
    getRockNames(): Set<string>
    removeRock(name: string): void
    addToBottom(name: string): void
    removeFromBottom(name: string): void
    defineLayer(id: string, rockMap: Map<string, string>): void
    removeLayer(layerId: string): void
    getLayerIds(): List<string>
    cleanSlate(): void
    addOceanFloorLayer(name: string): void
    removeOceanFloorLayer(name: string): void
    getOceanFloorLayers(): List<string>
    addLandLayer(name: string): void
    removeLandLayer(name: string): void
    getLandLayers(): List<string>
    addVolcanicLayer(name: string): void
    removeVolcanicLayer(name: string): void
    getVolcanicLayers(): List<string>
    addUpliftLayer(name: string): void
    removeUpliftLayer(name: string): void
    getUpliftLayers(): List<string>
}
```

#### Climate Modifiers

- `flatBedrock(flat?: boolean)`: Sets if the world should have flat bedrock, defaults to `false`, calling without any arguments sets it to `true`
- `setSpawnDistance(i: number)`: Sets the distance from the spawn center that players may spawn, defaults to 4000
- `setSpawnCenterX(i: number)`: Sets the spawn center on the x-coordinate, defaults to 0
- `setSpawnCenterZ(i: number)`: Sets the spawn center on the z-coordinate, defaults to 0
- `setTemperatureScale(i: number)`: Sets the temperature scale of the world, the distance from pole-to-pole, defaults to 20000
- `setTemperatureConstant(f: number)`: Sets the relative constant temperature of the world, defaults to 0
- `setRainfallScale(i: number)`: Sets the rainfall scale of the world, the distance from peak to peak, defaults to 20000
- `setRainfallConstant(f: number)`: Sets the relative constant temperature of the world, defaults to 0
- `setContinentalness(f: number)`: Sets the proportion of the world that is land instead of water, defaults to 0.5. A value of 0 translates to -100% on the world creation screen and 1 translates to +100%
- `setGrassDensity(f: number)`: Sets the grass density of the world, defaults to 0.5. A value of 0 translates to -100% on the world creation screen and 1 translates to +100%

#### Rock Layer Settings Modifiers

TFC's worldgen is primarily based around *rocks*, *layers*, and *layer types*[^3]. There are 5 layer types, `bottom`, `ocean_floor`, `land`, `volcanic`, and `uplift`, the `bottom` layer type is unique in that it only possesses *rocks*, the rest only possess *layers*. Layer types determine which geologic environment a rock/layer will generate. Every layer type must have at least one entry. *Layers* and *rocks* are user defined and are referenced by name. Rocks define which blocks are placed where, see [registering them](#rock-settings) for more about that. Layers are a list of *rock*-*layer* pairs, associating a *rock* with the *layer* that should generate underneath it

[^3]: These terms are unofficial and exist to better help explain TFC's worldgen

- `addRock(rock: RockSettings, name: string, bottom: boolean)`: Adds the given rock to the generator's pool of available rocks
    - Rock: the `RockSettings` to add
    - Name: The name which the rock can be referenced by
    - Bottom: If the rock should be added to the 'bottom' layer of the world
- `addRockFromId(id: string, name: string, bottom: boolean)`: Adds the given rock to the generator's pool of available rocks
    - Id: the [registered](#rock-settings) id of the `RockSettings` to add
    - Name: The name which the rock can be referenced by
    - Bottom: If the rock should be added the the 'bottom' layer of the world
- `getRock(name: string)`: Returns the `RockSettings` with the given name
- `getRockNames()`: Returns a set of the names of all the rocks currently in the generator's pool of rocks
- `removeRock(name: string)`: Removes the provided rock from the generator's pool of available rocks and any references to it
- `addToBottom(name: string)`: Adds the given rock to the 'bottom' layer
- `removeFromBottom(name: string)`: Removes the given rock from the 'bottom' layer
- `defineLayer(id: string, rockMap: Map<string, string>)`: Defines a new layer
    - Id: the name of the layer to add
    - RockMap: A map of rock names to layer names, associates a rock with the layer that will generate underneath it
- `removeLayer(layerId: string)`: removes the given layer from the generator
- `getLayerIds()`: returns a list of the names of all layers currently in the generator's pool of layers
- `cleanSlate()`: Removes all rocks and layers from the generator
- `addOceanFloorLayer(name: string)`: Adds the given layer to the 'ocean_floor' layer type
- `removeOceanFloorLayer(name: string)`: removes the given layer from the 'ocean_floor' layer type
- `getOceanFloorLayers()`: Gets the layers currently in the 'ocean_floor' layer type
- `addLandLayer(name: string)`: Adds the given layer to the 'land' layer type
- `removeLandLayer(name: string)`: removes the given layer from the 'land' layer type
- `getLandLayers()`: Gets the layers currently in the 'land' layer type
- `addVolcanicLayer(name: string)`: Adds the given layer to the 'volcanic' layer type
- `removeVolcanicLayer(name: string)`: Removes the given layer from the 'volcanic' layer type
- `getVolcanicLayers()`: Gets the layers currently in the 'volcanic' layer type
- `addUpliftLayer(name: string)`: Adds the given layer to the 'uplift' layer type
- `removeUpliftLayer(name: string)`: Removes the given layer from the 'uplift' layer type
- `getUpliftLayers()`: Gets the layers that are currently in the 'uplift' layer type

### Example

```js
TFCEvents.defaultWorldSettings(event => {
    event.rainfallScale = 4000
    event.continentalness = -3.5

    event.defineLayer('my_cool_layer', {
        granite: 'my_cool_layer',
        dolomite: 'my_cool_layer',
        diorite: 'felsic'
    })
    event.addLandLayer('my_cool_layer')
})
```

## Register Fauna Definitions

**Type**: `startup_scripts`

Allows for registering a [fauna definition](../data#fauna) for any entity type

### Method Signatures

```js
event.replace(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types): void
event.and(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacement$Type, heightmap: Heightmap$Types): void
event.or(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacement$Type, heightmap: Heightmap$Types): void
```

- `.replace(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types)`: Registers a new fauna definition for the entity type and overwrites any spawn conditions it may have had before
    - EntityType: The entity type to register the fauna for
    - Suffix: See below
    - PlacementType: See below
    - Heightmap: See below
- `.and(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacement$Type, heightmap: Heightmap$Types)`: Registers a new fauna definition for the entity type and ANDs any pre-existing spawn conditions it may have had before with the fauna's rules
    - EntityType: The entity type to register the fauna for
    - Suffix: See below
    - PlacementType: See below
    - Heightmap: See below
- `.or(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacement$Type, heightmap: Heightmap$Types)`: Registers a new fauna definition for the entity type and ORs any pre-existing spawn conditions it may have had before with the fauna's conditions, including other fauna definitions
    - EntityType: The entity type to register the fauna for
    - Suffix: See below
    - PlacementType: See below
    - Heightmap: See below

{: .notice }
>
> - `suffix`: An optional suffix to the autogenerated fauna id, by default just the entity type's id. SUffix to the end of the id with a `/`. May be null or simply not present
> - `placementType` may be any of `'on_ground'`, `'in_water'`, `'no_restrictions'`, or `'in_lava`'
> - `heightmap` may be any of `'world_surface_wg'`, `'world_surface'`, `'ocean_floor_wg'`, `'ocean_floor'`, `'motion_blocking'`, or `'motion_blocking_no_leaves'`. See the [Minecraft Wiki](https://minecraft.wiki/w/Heightmap) for an explanation for what each of these mean

### Example

```js
TFCEvents.registerFaunas(event => {
    event.register('minecraft:pig', 'on_ground', 'world_surface_wg')
})
```
