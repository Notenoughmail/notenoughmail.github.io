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
- [Create Glass Operations](#create-glass-operations)
- [Create Chunk Data Provider](#create-chunk-data-provider)

## Rock Settings

- **Type**: `startup_scripts`

Defines a new layer or overrides an existing layer which can be referenced from a [world preset json](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/data/tfc/worldgen/world_preset/overworld.json)

### Method Signature

```js
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
- 8th argument: A block, to be used as the spike block of the rock, may be null. Needs to have TFC's `ROCK_SPIKE_PART` state property/be a [rock spike]({% link kubejs_tfc/1.20.1/custom.md %}#rock-spike)
- 9th argument: A block, to be used as the loose rock block of the rock, may be null. Needs to have TFC's `COUNT_1_3` state property/be a [loose rock]({% link kubejs_tfc/1.20.1/custom.md %}#loose-rock)
- 10th argument: A block, to be used as the mossy loose rock block of the rock, may be null. Needs to have TFC's `COUNT_1_3` state property/be a [loose rock]({% link kubejs_tfc/1.20.1/custom.md %}#loose-rock)

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

```js
declare class ContainerLimiterEventJS {
    limit(size: Size, allowsEqual?: boolean): void
    limit(size: Size, min: number, max: number, allowsEqual?: boolean): void
    lowerLimit(size: Size, allowsEqual?: boolean): void
    lowerLimit(size: SIze, min: number, max: number, allowsEqual?: boolean): void
}
```

- `.limit(size: Size, allowsEqual?: boolean)`{: .language-javascript }: Limits the entire container to the specified size, requiring any items in it to be smaller than the provided size. `allowsEqual` determines if a size of `small` will accept items with a size of `small`, defaults to `true`
- `.limit(size: Size, min: number, max: number, allowsEqual?: boolean)`{: .language-javascript }: Limits the specified slot index range to the specified size, requiring any items in it to be smaller than the provided size. `allowsEqual` determines if a size of `small` will accept items with a size of `small`, defaults to `true`
- `.lowerLimit(size: Size, allowsEqual?: boolean)`{: .language-javascript }: Limits the entire container to the specified size, requiring any items in it to be larger than the provided size. `allowsEqual` determines if a size of `small` will accept items with a size of `small`, defaults to `true`
- `.lowerLimit(size: Size, min: number, max: number, allowsEqual?: boolean)`{: .language-javascript }: Limits the specified slot index range to the specified size, requiring any items in it to be larger than the provided size. `allowsEqual` determines if a size of `small` will accept items with a size of `small`, defaults to `true`

Allows size values: `tiny`, `very_small`, `small`, `normal`, `large`, `very_large`, `huge`

Additionally, every event listener requires the name of a menu type[^1] in its declaration as a key for which menus the limits are applied to.

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

```js
declare class RegisterClimateModelEventJS {
    register(name: ResourceLocation, modelBuilder: Consumer<ClimateModelbuilder>): void
}

declare class ClimateModelBuilder {
    getTemperatureScale(): number
    getRainfallScale(): number
    getClimateSeed(): number
    vector(x: number, z: number): Vec2
    setCurrentTemperatureCalculation(calc: QuadFunction<LevelReader, BlockPos, number, number, number>): void
    setAverageTemperatureCalculation(calc: BiFunction<LevelReader, BlockPos, number>): void
    setAverageRainfallCalculation(calc: BiFunction<LevelReader, BlockPos, number>): void
    setAriFog(calc: TriFunction<LevelReader, BlockPos, number, number>): void
    setWaterFog(calc: TriFunction<LevelReader, BlockPos, number, number>): void
    setWindVector(calc: TriFunction<Level, BlockPos, number, Vec2>): void
    setOnWorldLoad(calc: Consumer<ServerLevel>): void
    setOnChunkLoad(calc: TriConsumer<WorldgenLevel, ChunkAccess, ChunkData>): void
    newNoise(noiseMaker: Function<OpenSimplex2D, Noise2D>): number
    noise(index: number): Noise2D
    getTfcWind(): TriFunction<Level, BlockPos, number, Vec2>
    getTfcChunkLoad(): TriConsumer<WorldgenLevel, ChunkAccess, ChunkData>
    getTfcCurrentTemperature(): QuadFunction<LevelReader, BlockPos, number, number, number>
    getTfcAverageTemperature(): BiFunction<LevelReader, BlockPos, number>
    getTfcAverageRainfall(): BiFunction<LevelReader, BlockPos, number>
    getTfcAirFog(): TriFunction<LevelReader, BlockPos, number, number>
    getTfcWaterFog(): TriFunction<LevelReader, BlockPos, number, number>
    currentTemperature(level: LevelReader, pos: BlockPos, calendarTicks: number): number
    averageTemperature(level: LevelReader, pos: BlockPos): number
    averageRainfall(level: LevelReader, pos: BlockPos): number
}
```

The register method of the event has the following arguments:

- 1st argument: A resource location, the registry name of the model
- 2nd argument: A `ClimateModelBuilder` consumer, with the following methods:
    - `.getTemperatureScale()`{: .language-javascript }: Returns the temperature scale of the level, defaults to 20000 if the level does not have a TFC-like generator
    - `.getRainfallScale()`{: .language-javascript }: Returns the rainfall scale of the level, defaults to 20000 if the level does not have a TFC-like generator
    - `.getClimateSeed()`{: .language-javascript }: Returns the climate seed being used
    - `.vector(x: number, z: number)`{: .language-javascript }: Creates a new wind vector with the provided x and z components. Each component should be in the range [0, 1]
    - `.setCurrentTemperatureCalculation(calc: QuadFunction<LevelReader, BlockPos, number, number, number>)`{: .language-javascript }: Sets how the model will determine the current temperature at a given temperature and time, accepts a callback with the following values:
        - `level: LevelReader`{: .language-javascript }: The level
        - `pos: BlockPos`{: .language-javascript }: The position
        - `calendarTicks: number`{: .language-javascript }: The calendar tick the calculation is being made at
        - `daysInMonth: number`{: .language-javascript }: The number of days in a month; and
        - `return: number`{: .language-javascript }: A number should be returned in the callback, the temperature in °C
    - `.setAverageTemperatureCalculation(calc: BiFunction<LevelReader, BlockPos, number>)`{: .language-javascript }: Sets how the model will determine the average temperature at a given position, accepts a callback with the following values:
        - `level: LevelReader`{: .language-javascript }: The level
        - `pos: BlockPos`{: .language-javascript }: The position; and
        - `return: number`{: .language-javascript }: A number should be returned in the callback, the temperature in °C
    - `.setAverageRainfallCalculation(calc: BiFunction<LevelReader, BlockPos, number>)`{: .language-javascript }: Sets how the model will determine the average rainfall at a given position, accepts a callback with the following values:
        - `level: LevelReader`{: .language-javascript }: The level
        - `pos: BlockPos`{: .language-javascript }: The position; and
        - `return: number`{: .language-javascript }: A number should be returned in the callback, the rainfall in mm
    - `.setAriFog(calc: TriFunction<LevelReader, BlockPos, number, number>)`{: .language-javascript }: Sets how the model will determine the fogginess at a given position and time, accepts a callback with the following values:
        - `level: LevelReader`{: .language-javascript }: The level
        - `pos: BlockPos`{: .language-javascript }: The position
        - `calendarTicks: number`{: .language-javascript }: The calendar tick the calculation is being made at; and
        - `return: number`{: .language-javascript }: A number, in the range [0, 1], should be returned in the callback, a multiplier on the view distance
    - `.setWaterFog(calc: TriFunction<LevelReader, BlockPos, number, number>)`{: .language-javascript }: Sets how the model will determine the fogginess at a given position and time, accepts a callback with the following values:
        - `level: LevelReader`{: .language-javascript }: The level
        - `pos: BlockPos`{: .language-javascript }: The position
        - `calendarTicks: number`{: .language-javascript }: The calendar tick the calculation is being made at; and
        - `return: number`{: .language-javascript }: A number, in the range [0, 1], should be returned in the callback, a multiplier on the view distance
    - `.setWindVector(calc: TriFunction<Level, BlockPos, number, Vec2>)`{: .language-javascript }: Sets how the model will determine the wind strength at a given position and time, accepts a callback with the following values:
        - `level: LevelReader`{: .language-javascript }: The level
        - `pos: BlockPos`{: .language-javascript }: The position
        - `calendarTicks: number`{: .language-javascript }: The calendar tick the calculation is being made at; and
        - `return: Vec2`{: .language-javascript }: A 2D vector, representing the strength and direction of wind, each component should be in the range [0, 1]. Vectors can be made through the `.vector()` method described above
    - `.setOnWorldLoad(calc: Consumer<ServerLevel>)`{: .language-javascript }: Sets the model's behavior when the world is loaded, accepts a consumer of a `ServerLevel`
    - `.setOnChunkLoad(calc: TriConsumer<WorldgenLevel, ChunkAccess, ChunkData>)`{: .language-javascript }: Sets the model's behavior on chunk load, accepts a callback with the following values:
        - `level: WorldGenLevel`{: .language-javascript }: The level
        - `chunk: ChunkAccess`{: .language-javascript }: The chunk being loaded
        - `chunkData: ChunkData`{: .language-javascript }: Additional TFC data about the chunk, will be invalid if the level does not have a TFC-like generator
    - `.newNoise(noiseMaker: Function<OpenSimplex2D, Noise2D>)`{: .language-javascript }: Adds a new `Noise2D` to the model and returns a number which can be used to retrieve it in calculations. Accepts a callback with the following values:
        - `simplex: OpenSimplex2D`{: .language-javascript }: The base [`OpenSimplex2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/OpenSimplex2D.java) that is used to make the noise; and
        - `return: Noise2D`{: .language-javascript }: The final noise
    - `.noise(index: number)`{: .language-javascript }: Gets the model's [`Noise2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Noise2D.java) with the given index
    - `.getTfcWind()`{: .language-javascript }: Returns the callback TFC uses for its Overworld wind calculations
    - `.getTfcChunkLoad()`{: .language-javascript }: Returns the callback TFC uses for its Overworld chunk load actions
    - `.getTfcCurrentTemperature()`{: .language-javascript }: Returns the callback TFC uses for its Overworld current temperature calculation
    - `.getTfcAverageTemperature()`{: .language-javascript }: Returns the callback TFC uses for its Overworld average temperature calculation
    - `.getTfcAverageRainfall()`{: .language-javascript }: Returns the callback TFC uses for its Overworld average rainfall calculation
    - `.getTfcAirFog()`{: .language-javascript }: Returns the callback TFC uses for its Overworld air fogginess calculation
    - `.getTfcWaterFog()`{: .language-javascript }: Returns the callback TFC uses for its Overworld water fogginess calculation
    - `.currentTemperature(level: LevelReader, pos: BlockPos, calendarTicks: number)`{: .language-javascript }: Returns the current temperature in the model at the given position and time
    - `.averageTemperature(level: LevelReader, pos: BlockPos)`{: .language-javascript }: Returns the average temperature in the model at the given position
    - `.averageRainfall(level: LevelReader, pos: BlockPos)`{: .language-javascript }: Returns the average rainfall in the model at the given position

{: .notice #climate-model-registration-vector-notice }
Internally, the components of a `Vec2` are labeled `x` and `y`, but TFC uses the `y` component for the `z` direction

### Examples

```js
TFCEvents.registerClimateModel(event => {
    event.register('kubejs:hell', builder => {
        var fogNoiseIndex = builder.newNoise(s => s.octaves(3).spread(0.1).abs())
        var temperatureVarianceIndex = builder.newNoise(s => s.scaled(-360, 500).spread(0.6))
        builder.setAverageTemperatureCalculation((level, pos) => 1000)
        builder.currentTemperatureCalculation = (level, pos, calendarTicks, daysInMonth) => {
            var variance = builder.noise(temperatureVarianceIndex).noise(pos.x, pos.z)
            return 1000 + variance
        }
        builder.setAirFog((level, pos, calendarTicks) => builder.noise(fogNoiseIndex).noise(pos.x, pos.z))
        builder.windVector = builder.tfcWind
    })
})
```

## Select Climate Model

- **Type**: `server_scripts`

This event is fired when a world is loading and selecting the climate model to use

### Method Signatures

```js
declare class SelectClimateModelEventJS {
    getLevel(): Level
    getModel(): ClimateModel
    getModelName(): ResourceLocation
    setModel(model: ClimateModel): void
}
```

- `.getLevel()`{: .language-javascript }: Returns the event's level
- `.getModel()`{: .language-javascript }: Returns the events current model, defaults to a biome based model, TFC sets the overworld to use its own overworld model
- `.getModelName()`{: .language-javascript }: Returns the registry name of the event's current model
- `.setModel(model: ClimateModel)`{: .language-javascript }: Sets the events climate model

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

```js
declare class StartFireEventJS {
    getLevel(): Level
    getBlock(): BlockContainerJS
    getTargetedFace(): Direction
    getEntity(): @Nullable Player
    getItem(): ItemStack
    isString(): boolean
}
```

- `.getLevel()`{: .language-javascript }: Returns the level of the event
- `.getBlock()`{: .language-javascript }: Returns the `BlockContainerJS` of the event
- `.getTargetedFace()`{: .language-javascript }: Returns the direction of the clicked face
- `.getEntity()`{: .language-javascript }: Returns the player of the event, may be null
- `.getItem()`{: .language-javascript }: Returns the item stack used to start the fire
- `.isStrong()`{: .language-javascript }: Returns true if the event is strong

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

```js
declare class ProspectEventJS {
    getEntity(): Player
    getBlock(): Block
    getProspectResult(): ProspectResult
}
```

- `.getEntity()`{: .language-javascript }: Returns the player that prospected
- `.getBlock()`{: .language-javascript }: Returns the found block, or if the prospect result is `nothing`, the clicked block
- `.getProspectResult()`{: .language-javascript }: Results the prospect result, can be `nothing`, `traces`, `small`, `medium`, `large`, `very_large`, and `found`

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

```js
declare class LoggingEventJS {
    getLevel(): Level
    getAxe(): ItemStack
    getBlock(): BlockContainerJS
    getPos(): BlockPos
}
```

- `.getLevel()`{: .language-javascript }: Returns the level
- `.getAxe()`{: .language-javascript }: Returns the item stack of the axe used
- `.getBlock()`{: .language-javascript }: Returns the `BlockContainerJS` of the event
- `.getPos()`{: .language-javascript }: Returns the position that was initially broken

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

```js
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

- `.getPlayer()`{: .language-javascript }: Returns the player that used the tool, may be null
- `.getAnimal()`{: .language-javascript }: Returns the animal the product comes from
- `.getLevel()`{: .language-javascript }: Returns the level of the event
- `.getBlock()`{: .language-javascript }: Returns the `BlockContainerJS` of the event
- `.getAnimalProperties()`{: .language-javascript }: Returns the [TFCAnimalProperties](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/common/entities/livestock/TFCAnimalProperties.java) of the animal
- `.getTool()`{: .language-javascript }: Returns the tool used
- `.getItemProduct()`{: .language-javascript }: Returns an `ItemStack`, the *item* product, may be empty
- `.getFluidProduct()`{: .language-javascript }: Returns a `FluidStackJS`, the *fluid* product, may be empty
- `.isItemProduct()`{: .language-javascript }: Returns true if the item product is not empty
- `.setItemProduct(item: ItemStack)`{: .language-javascript }: Sets the item product to the given item stack
- `.setFluidProduct(fluid: FluidStackJS)`{: .language-javascript }: Sets the fluid product to the given fluid
- `.getUses()`{: .language-javascript }: Returns how much wear the animal will take from this event
- `.setUses(uses: number)`{: .language-javascript }: Sets the number of uses the animal will take from this event

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

```js
declare class CollapseEventJS {
    getCenterBlock(): BlockContainerJS
    getLevel(): Level
    getRadiusSquared(): number
    getSecondaryPositions(): List<BlockPos>
    isFake(): boolean
}
```

- `.getCenterBlock()`{: .language-javascript }: Returns the `BlockContainerJS` of the center block of the collapse
- `.getLevel()`{: .language-javascript }: Returns the level of the collapse
- `.getRadiusSquared()`{: .language-javascript }: Returns the squared radius of the collapse, will be `0` if the collapse is fake
- `.getSecondaryPositions()`{: .language-javascript }: Returns a list of `BlockPos`es which are the positions that will collapse
- `.isFake()`{: .language-javascript }: Returns true if the collapse is fake

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

```js
declare class DouseFireEventJS {
    getLevel(): Level
    getBlock(): BlockContainerJS
    getBounds(): AABB
    getPlayer(): @Nullable Player
    getPos(): BlockPos
}
```

- `.getLevel()`{: .language-javascript }: Returns the event's level
- `.getBlock()`{: .language-javascript }: Returns the event's `BlockContainerJS`
- `.getBounds()`{: .language-javascript }: Returns an `AABB` representing the total effected area
- `.getPlayer()`{: .language-javascript }: Returns the player that doused the fire, may be null
- `.getPos()`{: .language-javascript }: Returns the position that is being doused

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

```js
declare class RegisterFoodTraitEventJS {
    registerTrait(decayModifier: number, id: string): void
    registerTraitWithTooltip(decayModifier: number, id: string): void
}
```

- `.registerTrait(decayModifier: number, id: string)`{: .language-javascript }: Registers a food trait under the given id with the provided decay modifier
- `.registerTraitWithTooltip(decayModifier: number, id: string)`{: .language-javascript }: Registers a food trait under the given id with the provided decay modifier, this trait will have a tooltip on the item with a translation key of `<id namespace>.tooltip.foodtrait.<id path>`

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

```js
declare class RegisterItemStackModifierEventJS {
    simple(id: string, applicator: Function<ItemStack, ItemStack>): void
    withInput(id: string, applicator: BiFunction<ItemStack, ItemStack, ItemStack>): void
    withInventory(id: string, applicator: TriFunction<ItemStack, ItemStack, Iterable<ItemStack>, ItemStack>): void
}
```

- `.simple(id: string, applicator: Function<ItemStack, ItemStack>)`{: .language-javascript }: Registers a modifier that is not input dependent
    - Id: A string, the registry id to register the modifier as
    - Applicator: A function that receives and returns an `ItemStack`, the output stack. Performs the modifications to the output stack
- `.withInput(id: string, applicator: BiFunction<ItemStack, ItemStack, ItemStack>)`{: .language-javascript }: Registers a modifier that is input dependent
    - Id: A string, the registry id to register the modifier as
    - Applicator: A bi-function that receives two `ItemStack`s, the output stack and the input stack[^2], and returns an `ItemStack`, the modified output stack. Performs the modifications to the output stack
- `.withInventory(id: string, applicator: TriFunction<ItemStack, ItemStack, Iterable<ItemStack>, ItemStack>)`{: .language-javascript }: Registers a modifier that is input dependent and has access to an iterable view of the input inventory
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

```js
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

```js
declare class BirthdayEventsJS {
    add(month: Month, day: number, name: string): void
    remove(month: Month, day: number): void
    removeAll(): void
}
```

- `.add(month: Month, day: number, name: string)`{: .language-javascript }: Adds a birthday to the given month and day
- `.remove(month: Month, day: number)`{: .language-javascript }: Removes the birthday on the given month and day if there is one
- `.removeAll()`{: .language-javascript }: Removes all birthdays

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

```js
declare class RegisterInteractionsEventJS {
    interaction(ingredient: Ingredient, targetBlocks: boolean, targetAir: boolean, action: OnItemUseAction): void
    interaction(ingredient: Ingredient, targetAir: boolean, action: OnItemUseAction): void
    interaction(ingredient: Ingredient, action: OnItemUseAction): void
    blockItemPlacement(item: Item, block: Block): void
}
```

- `.interaction(ingredient: Ingredient, targetBlocks: boolean, targetAir: boolean, action: OnItemUseAction)`{: .language-javascript }: Registers the given ingredient for the provided [action](#onitemuseaction), the boolean params determine if blocks and air should be valid targets
- `.interaction(ingredient: Ingredient, targetAir: boolean, action: OnItemUseAction)`{: .language-javascript }: Registers the given ingredient for the provided [action](#onitemuseaction), the boolean param determines if air is a valid target, blocks default to being a valid target
- `.interaction(ingredient: Ingredient, action: OnItemUseAction)`{: .language-javascript }: Registers the given ingredient for the provided [action](#onitemuseaction), defaulting to blocks being valid targets and air not
- `.blockItemPlacement(item: Item, block: Block)`{: .language-javascript }: Registers a block placement for the given item, placing the given block

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

```js
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

- `.flatBedrock(flat?: boolean)`{: .language-javascript }: Sets if the world should have flat bedrock, defaults to `false`, calling without any arguments sets it to `true`
- `.setSpawnDistance(i: number)`{: .language-javascript }: Sets the distance from the spawn center that players may spawn, defaults to 4000
- `.setSpawnCenterX(i: number)`{: .language-javascript }: Sets the spawn center on the x-coordinate, defaults to 0
- `.setSpawnCenterZ(i: number)`{: .language-javascript }: Sets the spawn center on the z-coordinate, defaults to 0
- `.setTemperatureScale(i: number)`{: .language-javascript }: Sets the temperature scale of the world, the distance from pole-to-pole, defaults to 20000
- `.setTemperatureConstant(f: number)`{: .language-javascript }: Sets the relative constant temperature of the world, defaults to 0
- `.setRainfallScale(i: number)`{: .language-javascript }: Sets the rainfall scale of the world, the distance from peak to peak, defaults to 20000
- `.setRainfallConstant(f: number)`{: .language-javascript }: Sets the relative constant temperature of the world, defaults to 0
- `.setContinentalness(f: number)`{: .language-javascript }: Sets the proportion of the world that is land instead of water, defaults to 0.5. A value of 0 translates to -100% on the world creation screen and 1 translates to +100%
- `.setGrassDensity(f: number)`{: .language-javascript }: Sets the grass density of the world, defaults to 0.5. A value of 0 translates to -100% on the world creation screen and 1 translates to +100%

#### Rock Layer Settings Modifiers

TFC's worldgen is primarily based around *rocks*, *layers*, and *layer types*[^3]. There are 5 layer types, `bottom`, `ocean_floor`, `land`, `volcanic`, and `uplift`, the `bottom` layer type is unique in that it only possesses *rocks*, the rest only possess *layers*. Layer types determine which geologic environment a rock/layer will generate. Every layer type must have at least one entry. *Layers* and *rocks* are user defined and are referenced by name. Rocks define which blocks are placed where, see [registering them](#rock-settings) for more about that. Layers are a list of *rock*-*layer* pairs, associating a *rock* with the *layer* that should generate underneath it

[^3]: These terms are unofficial and exist to better help explain TFC's worldgen

- `.addRock(rock: RockSettings, name: string, bottom: boolean)`{: .language-javascript }: Adds the given rock to the generator's pool of available rocks
    - Rock: the `RockSettings` to add
    - Name: The name which the rock can be referenced by
    - Bottom: If the rock should be added to the 'bottom' layer of the world
- `.addRockFromId(id: string, name: string, bottom: boolean)`{: .language-javascript }: Adds the given rock to the generator's pool of available rocks
    - Id: the [registered](#rock-settings) id of the `RockSettings` to add
    - Name: The name which the rock can be referenced by
    - Bottom: If the rock should be added the the 'bottom' layer of the world
- `.getRock(name: string)`{: .language-javascript }: Returns the `RockSettings` with the given name
- `.getRockNames()`{: .language-javascript }: Returns a set of the names of all the rocks currently in the generator's pool of rocks
- `.removeRock(name: string)`{: .language-javascript }: Removes the provided rock from the generator's pool of available rocks and any references to it
- `.addToBottom(name: string)`{: .language-javascript }: Adds the given rock to the 'bottom' layer
- `.removeFromBottom(name: string)`{: .language-javascript }: Removes the given rock from the 'bottom' layer
- `.defineLayer(id: string, rockMap: Map<string, string>)`{: .language-javascript }: Defines a new layer
    - Id: the name of the layer to add
    - RockMap: A map of rock names to layer names, associates a rock with the layer that will generate underneath it
- `.removeLayer(layerId: string)`{: .language-javascript }: removes the given layer from the generator
- `.getLayerIds()`{: .language-javascript }: returns a list of the names of all layers currently in the generator's pool of layers
- `.cleanSlate()`{: .language-javascript }: Removes all rocks and layers from the generator
- `.addOceanFloorLayer(name: string)`{: .language-javascript }: Adds the given layer to the 'ocean_floor' layer type
- `.removeOceanFloorLayer(name: string)`{: .language-javascript }: removes the given layer from the 'ocean_floor' layer type
- `.getOceanFloorLayers()`{: .language-javascript }: Gets the layers currently in the 'ocean_floor' layer type
- `.addLandLayer(name: string)`{: .language-javascript }: Adds the given layer to the 'land' layer type
- `.removeLandLayer(name: string)`{: .language-javascript }: removes the given layer from the 'land' layer type
- `.getLandLayers()`{: .language-javascript }: Gets the layers currently in the 'land' layer type
- `.addVolcanicLayer(name: string)`{: .language-javascript }: Adds the given layer to the 'volcanic' layer type
- `.removeVolcanicLayer(name: string)`{: .language-javascript }: Removes the given layer from the 'volcanic' layer type
- `.getVolcanicLayers()`{: .language-javascript }: Gets the layers currently in the 'volcanic' layer type
- `.addUpliftLayer(name: string)`{: .language-javascript }: Adds the given layer to the 'uplift' layer type
- `.removeUpliftLayer(name: string)`{: .language-javascript }: Removes the given layer from the 'uplift' layer type
- `.getUpliftLayers()`{: .language-javascript }: Gets the layers that are currently in the 'uplift' layer type

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

Allows for registering a [fauna definition]({% link kubejs_tfc/1.20.1/data.md %}#fauna) for any entity type

### Method Signatures

```js
event.replace(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types): void
event.and(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacement$Type, heightmap: Heightmap$Types): void
event.or(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacement$Type, heightmap: Heightmap$Types): void
```

- `.replace(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types)`{: .language-javascript }: Registers a new fauna definition for the entity type and overwrites any spawn conditions it may have had before
    - EntityType: The entity type to register the fauna for
    - Suffix: See below
    - PlacementType: See below
    - Heightmap: See below
- `.and(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacement$Type, heightmap: Heightmap$Types)`{: .language-javascript }: Registers a new fauna definition for the entity type and ANDs any pre-existing spawn conditions it may have had before with the fauna's rules
    - EntityType: The entity type to register the fauna for
    - Suffix: See below
    - PlacementType: See below
    - Heightmap: See below
- `.or(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacement$Type, heightmap: Heightmap$Types)`{: .language-javascript }: Registers a new fauna definition for the entity type and ORs any pre-existing spawn conditions it may have had before with the fauna's conditions, including other fauna definitions
    - EntityType: The entity type to register the fauna for
    - Suffix: See below
    - PlacementType: See below
    - Heightmap: See below

{: .notice #fauna-definition-notice }
>
> - `suffix`: An optional suffix to the autogenerated fauna id, by default just the entity type's id. Suffixed to the end of the id with a `/`. May be null or simply not present
> - `placementType` may be any of `'on_ground'`, `'in_water'`, `'no_restrictions'`, or `'in_lava`' and determines where the entity may be placed
> - `heightmap` may be any of `'world_surface_wg'`, `'world_surface'`, `'ocean_floor_wg'`, `'ocean_floor'`, `'motion_blocking'`, or `'motion_blocking_no_leaves'`. See the [Minecraft Wiki](https://minecraft.wiki/w/Heightmap) for an explanation for what each of these mean

### Example

```js
TFCEvents.registerFaunas(event => {
    event.register('minecraft:pig', 'on_ground', 'world_surface_wg')
})
```

## Create Glass Operations

**Type**: `startup_scripts`

Allows for the creation of new glass operations for use in [glassworking]({% link kubejs_tfc/1.20.1/recipes.md %}#glassowrking) recipes

{: .notice #glass-operations-notice }
> For multiplayer connections the order and names of the new operations *must* be the same, otherwise the connection will be refused
>
> All operations created via this event will have `kubejs_` prefixed to their name

### Method Signatures

```js
event.create(name: string, displayStack?: Supplier<ItemStack>, customSound?: ResourceLocation, minHeat?: number)
event.createPowder(powderItemId: ResourceLocation, name: string, customSound?: ResourceLocation, minHeat?: number)
```

- `.create(name: string, displayStack?: Supplier<ItemStack>, customSound?: ResourceLocation, minHeat?: number)`{: .language-javascript }: Creates a new glass operation with the given name
    - Name: The name of the operation, will be prepended with `kubejs_`
    - DisplayStack: An item stack that will be used to display the operation in JEI, if the item is `tfc:blowpipe_with_glass`, `tfc:ceramic_blowpipe_with_glass` will also be displayed. Optional
    - CustomSound: The registry id of a custom sound to play when the operation is performed. Optional, defaults to `minecraft:block.anvil.use`
    - MinHeat: The minimum heat required to perform the operation. Optional, defaults to 480°C
- `.createPowder(powderItemId: ResourceLocation, name: string, customSound?: ResourceLocation, minHeat?: number)`{: .language-javascript }: Creates a new glass operation with the given name and enables it to be added via the powder bowl
    - PowderItemId: The registry id of an item to use as this operation's powder, requires the `tfc:powders` tag in order to be put in a bowl. Will be used as the display item in JEI
    - Name: The name of the operations, will be prepended with `kubejs_`
    - CustomSound: The registry id of a custom sound to play when the operation is performed. Optional, defaults to `minecraft:block.anvil.use`
    - MinHeat: The minimum heat required to perform the operation. Optional, defaults to 480°C

### Example

```js
TFCEvents.createGlassOperations(event => {
    event.createPowder('kubejs:quartz_powder', 'quartz')
})
```

## Create Chunk Data Provider

**Type**: `server_scripts`

When used with a specific chunk generator type, this event allows for custom generation of TFC's [ChunkData]({% link kubejs_tfc/1.20.1/misc.md %}#print-chunk-data) permitting [fauna definitions](#register-fauna-definitions), [climate placement modifiers]({% link kubejs_tfc/1.20.1/worldgen.md %}#climate), TFC's climate-based structure modifier, and any other configured features which are dependent on the world generator to be TFC-like (erosion, boulders, etc.) to function properly with level generators other than TFC's.

### Chunk Generator

Due to how TFC's chunk data works, this functionality is inherently tied to a `ChunkGenerator`. KubeJS TFC adds a new generator type, `kubejs_tfc:wrapped` which will wrap any arbitrary chunk generator and imitate its function while providing TFC's additional values.

In its json definition, the generator definition has the following fields:

- `type` must be `kubejs_tfc:wrapped`
- `event_key`: The key which the event is fired for. A string.
- `settings`: Same as `tfc_settings` in [TFC's chunk generator](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/). These values are unlikely to be used except for the rock layer settings which can be used in custom rock generation.
- `generator`: A chunk generator.

### Method Signatures

```js
event.getWorldSeed(): number
event.partial(gen: BiConsumer<ChunkData, ChunkAccess>): void
event.full(gen: BiConsumer<ChunkData, ChunkAccess>): void
event.erosionalAquifer(aquifer: Function<ChunkAccess, Aquifer>): void
event.rocks(getter: RocksGetter): void
```

- `.getWorldSeed()`{: .language-javascript }: Returns the seed of the world the chunk data provider is being applied to
- `.partial(gen: BiConsumer<ChunkData, ChunkAccess>)`{: .language-javascript }: Sets the calculation for the information required to promote a chunk's `ChunkData` to `PARTIAL`. Accepts a callback with two parameters and no return value. If not set, or `#generatePartial` is never called, the chunk data will be [filled with zero values](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/util/implementation/worldgen/KubeChunkDataGenerator.java#L30-L36). The parameters are:
    - `data: ChunkData`{: .language-javascript }: TFC's [ChunkData](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkData.java). `#generatePartial` should be called here. `#generateFull` *can* be called here, but there is no guarantee that the chunk will have access to heightmaps during this callback. The parameters for `#generatePartial` are:
        - `rainfallLayer: LerpFloatLayer`{: .language-javascript }: A [LerpFloatLayer]({% link kubejs_tfc/1.20.1/bindings/misc.md %}#lerp-float-layer) of the yearly average rainfall at the corners of the chunk. Used in TFC's climate model to determine the rainfall at a position
        - `temperatureLayer: LerpFloatLayer`{: .language-javascript }: A [LerpFloatLayer]({% link kubejs_tfc/1.20.1/bindings/misc.md %}#lerp-float-layer) of the yearly average temperature at the corners of the chunk. Used by TFC's climate model to determine the average temperature at a position
        - `forestType: ForestType`{: .language-javascript }: The forest type of the chunk, may be `none`, `sparse`, `edge`, `normal`, or `old_growth`
        - `.forestWeirdness: number: A number, in the range [0, 1], for the 'weirdness' of forests in the chunk. USed by TFC's forest configured feature
        - `.forestDensity: number`{: .language-javascript }: A number, in the range [0, 1], for the density of the forests in the chunk. USed by TFC's forest configured feature
    - `chunk: ChunkAccess`{: .language-javascript }: The chunk data is being generated for. **Note**: Heightmap access is not guaranteed during this callback
- `.full(gen: BiConsumer<ChunkData, ChunkAccess>)`{: .language-javascript }: Sets the calculation for the information required to promote the chunks `ChunkData` from `PARTIAL` to `FULL`. Accepts a callback with two parameters and no return value. If not set, or `#generateFull` is never called, the data will be promoted with [values matching the `ocean_floor_wg` heightmap for surface heights and 20 less than the quart average of the surface heights](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/util/implementation/worldgen/KubeChunkDataGenerator.java#L37-L57). The parameters are:
    - `data: ChunkData`{: .language-javascript }: TFC's [ChunkData](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkData.java). `#generateFull` should be called here and the chunk is guaranteed to have access to heightmaps during this callback. The parameters for `#generateFull` are:
        - `surfaceHeight: int[256]`{: .language-javascript }: An array of integer values of size 256 (16 * 16; `BlockPos` resolution) representing the surface height of the world. Value indexes are `x + 16 * z` where `x` and `z` are the local x and z coordinates within the chunk and are in the range [0, 15]. This is where the `surfaceY` parameter of a `RocksGetter` callback is sources from.
        - `.aquiferSurfaceHeight: int[16]`{: .language-javascript }: An array of integer values of size 16 (4 * 4; `QuartPos` resolution) representing the height of aquifer surfaces. Only used by [TFCAquifer](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/TFCAquifer.java)s
    - `chunk: ChunkAccess`{: .language-javascript }: The chunk data is being generated for
- `.erosionalAquifer(aquifer: Function<ChunkAccess, Aquifer>)`{: .language-javascript}: Sets the calculation for the `Aquifer` of a given chunk. This aquifer is used by TFC's erosion feature to place subterranean liquids. Accepts a callback with one parameter and a return value. If not set, an aquifer that only fills air will be returned. The parameters are:
    - `chunk: ChunkAccess`{: .language-javascript }: The chunk the aquifer is being generated for
    - `return: Aquifer`{: .language-javascript }: An `Aquifer`. See [TFCAquifer](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/TFCAquifer.java) for TFC's implementation.
- `.rocks(getter: RocksGetter)`{: .language-javascript }: Sets the Calculation for the `RockSettings` at a position. Used by several configured feature types to determine what blocks to place. Accepts a callback with 6 parameters and a return value. If not set, or when null is returned, a `RockSettings` made entirely of air is returned. The parameters are:
    - `x: number`{: .language-javascript }: A number, the x coordinate
    - `y: number`{: .language-javascript }: A number, the y coordinate
    - `z: number`{: .language-javascript }: A number, the z coordinate
    - `surfaceY`{: .language-javascript }: A number, the surface elevation of the block column, as determined from the calculation provided in `.full()`{: .language-javascript }
    - `cache: @Nullable ChunkRockDataCache`{: .language-javascript }: A [ChunkRockDataCache](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkRockDataCache.java) which may be null
    - `rockLayers: RockLayerSettings`{: .language-javascript }: The [RockLayerSettings](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/settings/RockLayerSettings.java) defined in the chunk generator's `settings` object
    - `return: RockSettings`{: .language-javascript }: A [RockSettings](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/settings/RockSettings.java) describing the rock at the position. Ideally retrieved from the `RockLayerSettings`

### Example

The json chunk generator definition

```json
"generator": {
  "type": "kubejs_tfc:wrapped",
  "event_key": "nether",
  "settings": {
    "flat_bedrock": false,
    "spawn_distance": 0,
    "spawn_center_x": 0,
    "spawn_center_z": 0,
    "temperature_scale": 0,
    "rainfall_scale": 0,
    "continentalness": 0,
    "rock_layer_settings": {
      "rocks": {
        "nether": {
          "raw": "minecraft:netherrack",
          "hardened": "minecraft:black_stone",
          "gravel": "minecraft:gravel",
          "cobble": "minecraft:basalt",
          "sand": "minecraft:soul_sand",
          "sandstone": "minecraft:soul_soil"
        }
      },
      "layers": [
        {
          "id": "nether",
          "layers": {
            "nether": "bottom"
          }
        }
      ],
      "bottom": [ "nether" ],
      "ocean_floor": [ "nether" ],
      "volcanic": [ "nether" ],
      "land": [ "nether" ],
      "uplift": [ "nether" ]
    }
  },
 "generator": {
   "type": "minecraft:noise",
   "biome_source": {
     "type": "minecraft:multi_noise",
     "preset": "minecraft:nether"
   },
   "settings": "minecraft:nether"
 }
}
```

The event with matching key

```js
TFCEvents.createChunkDataProvider('nether', event => {

    const rain = TFC.misc.lerpFloatLayer(0, 0, 0, 0);
    const tempLayer = TFC.misc.newOpenSimplex2D(event.worldSeed + 4621678939469)
        .spread(0.2)
        .octaves(3)
        .scaled(70, 90)
    const forestLayer = TFC>misc.newOpenSimplex2D(event.worldSeed + 98713856895664)
        .spread(0.8)
        .terraces(9)
        .affine(6, 12)
        .scaled(6, 18, 0, 1)

    // Precompute the surface & aquifer heights as constants as this is nether and does not realistically change
    var heights = [];
    var i = 0;
    while (i < 256) {
        hights.push(127);
        i++;
    }
    var aquifer = [];
    i = 0;
    while (i < 16) {
        aquifer.push(0);
        i++;
    }

    event.partial((data, chunk) => {
        var x = chunk.pos.minBlockX;
        var z = chunk.pos.minBlockZ;

        var temp = TFC.misc.lerpFloatLayer(
            tempLayer.noise(x, z),
            tempLayer.noise(x, z + 15),
            tempLayer.noise(x + 15, z),
            tempLayer.noise(x + 15, z + 15)
        );

        data.generatePartial(
            rain,
            temp,
            forestLayer.noise(x, z) * 4, // Kube accepts ordinal numbers for enum constants
            forestlayer.noise(x * 78423 + 869, z),
            forestLayer.noise(x, z * 651349 - 698763)
        );
    });

    event.full((data, chunk) => {
        data.generateFull(heights, aquifer);
    });

    event.rocks((x, y, z, surfaceY, cache, rockLayers) => {
        return rockLayers.sampleAtLayer(0, 0);
    });
})
```
