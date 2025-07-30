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
- [Register Item Stack Modifier Converters](#item-stack-modifier-converters)

## Rock Settings

- **Type**: `startup_scripts`

Defines a new layer or overrides an existing layer which can be referenced from a [world preset json](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/data/tfc/worldgen/world_preset/overworld.json)

{: #rock-settings-methods }

### Method Signature

```js
event.defineRock(
    id: String,
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
- 8th argument: A block, to be used as the spike block of the rock, may be `null`{:.p}. Needs to have TFC's `ROCK_SPIKE_PART` state property/be a [rock spike]({% link kubejs_tfc/1.20.1/custom.md %}#rock-spike)
- 9th argument: A block, to be used as the loose rock block of the rock, may be `null`{:.p}. Needs to have TFC's `COUNT_1_3` state property/be a [loose rock]({% link kubejs_tfc/1.20.1/custom.md %}#loose-rock)
- 10th argument: A block, to be used as the mossy loose rock block of the rock, may be `null`{:.p}. Needs to have TFC's `COUNT_1_3` state property/be a [loose rock]({% link kubejs_tfc/1.20.1/custom.md %}#loose-rock)

{: #rock-settings-example }

### Example

```js
TFCEvents.rockSettings(event => {
    event.defineRock(
        'kubejs:vanilla_layer',
        'minecraft:stone',
        'minecraft:deepslate',
        'minecraft:gravel',
        'minecraft:cobblestone',
        'minecraft:sand',
        'minecraft:sandstone',
        null,
        null,
        null
    )
})
```

## Limiting Containers

- **Type**: `server_scripts`

TFC has an item size feature which it uses to limit which items can go into its containers. KubeJS TFC allows you to somewhat replicate this behavior with other mods' containers, with some limitations

- It will only be able to apply to a container which registers a `MenuType`
- It only applies to player interactions
- It only applies upon *closing* a menu

The basic functionality and idea is based off of a 1.12 [addon](https://github.com/DoubleDoorDevelopment/OversizedItemInStorageArea) that did much the same. It is licensed under the [BSD License](https://www.curseforge.com/minecraft/mc-mods/oversized-item-in-storage-area/comments#license)

Upon a player closing a container limited through this event, any items that are

1. in the limited slots and
2. are not within the size limits

will be removed from the container and spawned in world around the player

{: #limit-container-methods }

### Method Signatures

```js
event.limit(size: Size, allowsEqual?: boolean): void
event.limit(size: Size, min: number, max: number, allowsEqual?: boolean): void
event.lowerLimit(size: Size, allowsEqual?: boolean): void
event.lowerLimit(size: Size, min: number, max: number, allowsEqual?: boolean): void
```

- `.limit(size: Size, allowsEqual?: boolean)`{: .language-kube #inv-limit-0 }: Limits the entire container to the specified size, requiring any items in it to be smaller than the provided size. `allowsEqual` determines if a size of `small`{:.e} will accept items with a size of `small`{:.e}, defaults to `true`{:.p}
- `.limit(size: Size, min: number, max: number, allowsEqual?: boolean)`{: .language-kube #inv-limit-1 }: Limits the specified slot index range to the specified size, requiring any items in it to be smaller than the provided size. `allowsEqual`{:.v} determines if a size of `small`{:.e} will accept items with a size of `small`{:.e}, defaults to `true`{:.p}
- `.lowerLimit(size: Size, allowsEqual?: boolean)`{: .language-kube #inv-limit-2 }: Limits the entire container to the specified size, requiring any items in it to be larger than the provided size. `allowsEqual` determines if a size of `small`{:.e} will accept items with a size of `small`{:.e}, defaults to `true`{:.p}
- `.lowerLimit(size: Size, min: number, max: number, allowsEqual?: boolean)`{: .language-kube #inv-limit-3 }: Limits the specified slot index range to the specified size, requiring any items in it to be larger than the provided size. `allowsEqual`{:.v} determines if a size of `small`{:.e} will accept items with a size of `small`{:.e}, defaults to `true`{:.p}

Allowed size values: `tiny`{:.e}, `very_small`{:.e}, `small`{:.e}, `normal`{:.e}, `large`{:.e}, `very_large`{:.e}, and `huge`{:.e}

Additionally, every event listener requires the name of a menu type[^1] in its declaration as a key for which menus the limits are applied to.

{: #limit-container-example }

### Example

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

{: #register-climate-model-methods }

### Method Signatures

```js
// The event itself
event.register(name: ResourceLocation, modelBuilder: Consumer<ClimateModelbuilder>): void

// The ClimateModelBuidler
event.getTemperatureScale(): number
event.getRainfallScale(): number
event.getClimateSeed(): number
event.vector(x: number, z: number): Vec2
event.setCurrentTemperatureCalculation(calc: QuadFunction<LevelReader, BlockPos, number, number, number>): void
event.setAverageTemperatureCalculation(calc: BiFunction<LevelReader, BlockPos, number>): void
event.setAverageRainfallCalculation(calc: BiFunction<LevelReader, BlockPos, number>): void
event.setAriFog(calc: TriFunction<LevelReader, BlockPos, number, number>): void
event.setWaterFog(calc: TriFunction<LevelReader, BlockPos, number, number>): void
event.setWindVector(calc: TriFunction<Level, BlockPos, number, Vec2>): void
event.setOnWorldLoad(calc: Consumer<ServerLevel>): void
event.setOnChunkLoad(calc: TriConsumer<WorldgenLevel, ChunkAccess, ChunkData>): void
event.newNoise(noiseMaker: Function<OpenSimplex2D, Noise2D>): number
event.noise(index: number): Noise2D
event.getTfcWind(): TriFunction<Level, BlockPos, number, Vec2>
event.getTfcChunkLoad(): TriConsumer<WorldgenLevel, ChunkAccess, ChunkData>
event.getTfcCurrentTemperature(): QuadFunction<LevelReader, BlockPos, number, number, number>
event.getTfcAverageTemperature(): BiFunction<LevelReader, BlockPos, number>
event.getTfcAverageRainfall(): BiFunction<LevelReader, BlockPos, number>
event.getTfcAirFog(): TriFunction<LevelReader, BlockPos, number, number>
event.getTfcWaterFog(): TriFunction<LevelReader, BlockPos, number, number>
event.currentTemperature(level: LevelReader, pos: BlockPos, calendarTicks: number): number
event.averageTemperature(level: LevelReader, pos: BlockPos): number
event.averageRainfall(level: LevelReader, pos: BlockPos): number
```

The register method of the event has the following arguments:

- 1st argument: A resource location, the registry name of the model
- 2nd argument: A `ClimateModelBuilder` consumer, with the following methods:
    - `.getTemperatureScale()`{: .language-kube #climate-reg-temp-scale }: Returns the temperature scale of the level, defaults to `20000`{:.n} if the level does not have a TFC-like generator
    - `.getRainfallScale()`{: .language-kube #climate-reg-rain-scale }: Returns the rainfall scale of the level, defaults to `20000`{:.n} if the level does not have a TFC-like generator
    - `.getClimateSeed()`{: .language-kube #climate-reg-seed }: Returns the climate seed being used
    - `.vector(x: number, z: number)`{: .language-kube #climate-reg-vector }: Creates a new wind vector with the provided x and z components. Each component should be in the range [0, 1]
    - `.setCurrentTemperatureCalculation(calc: QuadFunction<LevelReader, BlockPos, number, number, number>)`{: .language-kube #climate-reg-current-temp-calc }: Sets how the model will determine the current temperature at a given temperature and time, accepts a callback with the following values:
        - `level: LevelReader`{: .language-kube }: The level
        - `pos: BlockPos`{: .language-kube }: The position
        - `calendarTicks: number`{: .language-kube }: The calendar tick the calculation is being made at
        - `daysInMonth: number`{: .language-kube }: The number of days in a month; and
        - `return: number`{: .language-kube }: A number should be returned in the callback, the temperature in °C
    - `.setAverageTemperatureCalculation(calc: BiFunction<LevelReader, BlockPos, number>)`{: .language-kube #climate-reg-avg-temp-calc }: Sets how the model will determine the average temperature at a given position, accepts a callback with the following values:
        - `level: LevelReader`{: .language-kube }: The level
        - `pos: BlockPos`{: .language-kube }: The position; and
        - `return: number`{: .language-kube }: A number should be returned in the callback, the temperature in °C
    - `.setAverageRainfallCalculation(calc: BiFunction<LevelReader, BlockPos, number>)`{: .language-kube #climate-reg-rain-calc }: Sets how the model will determine the average rainfall at a given position, accepts a callback with the following values:
        - `level: LevelReader`{: .language-kube }: The level
        - `pos: BlockPos`{: .language-kube }: The position; and
        - `return: number`{: .language-kube }: A number should be returned in the callback, the rainfall in mm
    - `.setAirFog(calc: TriFunction<LevelReader, BlockPos, number, number>)`{: .language-kube #climate-reg-air-fog }: Sets how the model will determine the fogginess at a given position and time, accepts a callback with the following values:
        - `level: LevelReader`{: .language-kube }: The level
        - `pos: BlockPos`{: .language-kube }: The position
        - `calendarTicks: number`{: .language-kube }: The calendar tick the calculation is being made at; and
        - `return: number`{: .language-kube }: A number, in the range [0, 1], should be returned in the callback, a multiplier on the view distance
    - `.setWaterFog(calc: TriFunction<LevelReader, BlockPos, number, number>)`{: .language-kube #climate-reg-water-fog }: Sets how the model will determine the fogginess at a given position and time, accepts a callback with the following values:
        - `level: LevelReader`{: .language-kube }: The level
        - `pos: BlockPos`{: .language-kube }: The position
        - `calendarTicks: number`{: .language-kube }: The calendar tick the calculation is being made at; and
        - `return: number`{: .language-kube }: A number, in the range [0, 1], should be returned in the callback, a multiplier on the view distance
    - `.setWindVector(calc: TriFunction<Level, BlockPos, number, Vec2>)`{: .language-kube #climate-reg-wind }: Sets how the model will determine the wind strength at a given position and time, accepts a callback with the following values:
        - `level: LevelReader`{: .language-kube }: The level
        - `pos: BlockPos`{: .language-kube }: The position
        - `calendarTicks: number`{: .language-kube }: The calendar tick the calculation is being made at; and
        - `return: Vec2`{: .language-kube }: A 2D vector, representing the strength and direction of wind, each component should be in the range [0, 1]. Vectors can be made through the `.vector(x: number, z: number)`{: .language-kube } method described above
    - `.setOnWorldLoad(calc: Consumer<ServerLevel>)`{: .language-kube #climate-reg-world-load }: Sets the model's behavior when the world is loaded, accepts a consumer of a `ServerLevel`
    - `.setOnChunkLoad(calc: TriConsumer<WorldgenLevel, ChunkAccess, ChunkData>)`{: .language-kube #climate-reg-chunk-load }: Sets the model's behavior on chunk load, accepts a callback with the following values:
        - `level: WorldGenLevel`{: .language-kube }: The level
        - `chunk: ChunkAccess`{: .language-kube }: The chunk being loaded
        - `chunkData: ChunkData`{: .language-kube }: Additional TFC data about the chunk, will be invalid if the level does not have a TFC-like generator
    - `.newNoise(noiseMaker: Function<OpenSimplex2D, Noise2D>)`{: .language-kube #climate-reg-new-noise }: Adds a new `Noise2D`{:.f} to the model and returns a number which can be used to retrieve it in calculations. Accepts a callback with the following values:
        - `simplex: OpenSimplex2D`{: .language-kube }: The base [`OpenSimplex2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/OpenSimplex2D.java) that is used to make the noise; and
        - `return: Noise2D`{: .language-kube }: The final noise
    - `.noise(index: number)`{: .language-kube #climate-reg-get-noise }: Gets the model's [`Noise2D`{:.f}](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Noise2D.java) with the given index
    - `.getTfcWind()`{: .language-kube #climate-reg-tfc-wind }: Returns the callback TFC uses for its Overworld wind calculations
    - `.getTfcChunkLoad()`{: .language-kube #climate-reg-tfc-chunk-load }: Returns the callback TFC uses for its Overworld chunk load actions
    - `.getTfcCurrentTemperature()`{: .language-kube #climate-reg-tfc-current-temp }: Returns the callback TFC uses for its Overworld current temperature calculation
    - `.getTfcAverageTemperature()`{: .language-kube #climate-reg-tfc-avg-temp }: Returns the callback TFC uses for its Overworld average temperature calculation
    - `.getTfcAverageRainfall()`{: .language-kube #climate-reg-tfc-rain }: Returns the callback TFC uses for its Overworld average rainfall calculation
    - `.getTfcAirFog()`{: .language-kube #climate-reg-tfc-air-fog }: Returns the callback TFC uses for its Overworld air fogginess calculation
    - `.getTfcWaterFog()`{: .language-kube #climate-reg-water-fog }: Returns the callback TFC uses for its Overworld water fogginess calculation
    - `.currentTemperature(level: LevelReader, pos: BlockPos, calendarTicks: number)`{: .language-kube #climate-reg-get-current-temp }: Returns the current temperature in the model at the given position and time
    - `.averageTemperature(level: LevelReader, pos: BlockPos)`{: .language-kube #climate-reg-get-avg-temp }: Returns the average temperature in the model at the given position
    - `.averageRainfall(level: LevelReader, pos: BlockPos)`{: .language-kube #climate-reg-get-rain }: Returns the average rainfall in the model at the given position

{: .notice #climate-model-registration-vector-notice }
Internally, the components of a `Vec2` are labeled `x` and `y`, but TFC uses the `y` component for the `z` direction

{: #register-climate-models-example }

### Example

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

{: #select-climate-model-methods }

### Method Signatures

```js
event.getLevel(): Level
event.getModel(): ClimateModel
event.getModelName(): ResourceLocation
event.setModel(model: ClimateModel): void
```

- `.getLevel()`{: .language-kube #climate-select-level }: Returns the event's level
- `.getModel()`{: .language-kube #climate-select-model }: Returns the events current model, defaults to a biome based model, TFC sets the overworld to use its own overworld model
- `.getModelName()`{: .language-kube #climate-select-name }: Returns the registry name of the event's current model
- `.setModel(model: ClimateModel)`{: .language-kube #climate-select-set-model }: Sets the events climate model

{: #select-climate-model-example }

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

{: #start-fire-methods }

### Method Signatures

```js
event.getLevel(): Level
event.getBlock(): BlockContainerJS
event.getTargetedFace(): Direction
event.getEntity(): @Nullable Player
event.getItem(): ItemStack
event.isString(): boolean
```

- `.getLevel()`{: .language-kube #fire-level }: Returns the level of the event
- `.getBlock()`{: .language-kube #fire-block }: Returns the `BlockContainerJS` of the event
- `.getTargetedFace()`{: .language-kube #fire-face }: Returns the direction of the clicked face
- `.getEntity()`{: .language-kube #fire-entity }: Returns the player of the event, may be null
- `.getItem()`{: .language-kube #fire-item }: Returns the item stack used to start the fire
- `.isStrong()`{: .language-kube #fire-strong }: Returns true if the event is strong

{: #start-fire-example }

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

{: #prospect-methods }

### Method Signatures

```js
event.getEntity(): Player
event.getBlock(): Block
event.getProspectResult(): ProspectResult
```

- `.getEntity()`{: .language-kube #prospect-entity }: Returns the player that prospected
- `.getBlock()`{: .language-kube #prospect-block }: Returns the found block, or if the prospect result is `nothing`{:.e}, the clicked block
- `.getProspectResult()`{: .language-kube #prospect-result }: Results the prospect result, can be `nothing`{:.e}, `traces`{:.e}, `small`{:.e}, `medium`{:.e}, `large`{:.e}, `very_large`{:.e}, and `found`{:.e}

{: #prospect-example }

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

{: #logging-methods }

### Method Signatures

```js
event.getLevel(): Level
event.getAxe(): ItemStack
event.getBlock(): BlockContainerJS
event.getPos(): BlockPos
```

- `.getLevel()`{: .language-kube #log-level }: Returns the level
- `.getAxe()`{: .language-kube #log-axe }: Returns the item stack of the axe used
- `.getBlock()`{: .language-kube #log-block }: Returns the `BlockContainerJS` of the event
- `.getPos()`{: .language-kube #log-pos }: Returns the position that was initially broken

{: #logging-example }

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

{: #animal-product-methods }

### Method Signatures

```js
event.getPlayer(): @Nullable Player
event.getAnimal(): Entity
event.getLevel(): Level
event.getBlock(): BlockContainerJS
event.getAnimalProperties(): TFCAnimalProperties
event.getTool(): ItemStack
event.getItemProduct(): ItemStack
event.getFluidProduct(): FluidStackJS
event.isItemProduct(): boolean
event.setItemProduct(item: ItemStack): void
event.setFluidProduct(fluid: FluidStackJS): void
event.getUses(): number
event.setUses(uses: number): void
```

- `.getPlayer()`{: .language-kube #product-player }: Returns the player that used the tool, may be null
- `.getAnimal()`{: .language-kube #product-animal }: Returns the animal the product comes from
- `.getLevel()`{: .language-kube #product-level }: Returns the level of the event
- `.getBlock()`{: .language-kube #product-block }: Returns the `BlockContainerJS` of the event
- `.getAnimalProperties()`{: .language-kube #product-properties }: Returns the [TFCAnimalProperties](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/common/entities/livestock/TFCAnimalProperties.java) of the animal
- `.getTool()`{: .language-kube #product-tool }: Returns the tool used
- `.getItemProduct()`{: .language-kube #product-item-product }: Returns an `ItemStack`, the *item* product, may be empty
- `.getFluidProduct()`{: .language-kube #product-fluid-product }: Returns a `FluidStackJS`, the *fluid* product, may be empty
- `.isItemProduct()`{: .language-kube #product-is-item }: Returns true if the item product is not empty
- `.setItemProduct(item: ItemStack)`{: .language-kube #product-set-item }: Sets the item product to the given item stack
- `.setFluidProduct(fluid: FluidStackJS)`{: .language-kube #product-set-fluid}: Sets the fluid product to the given fluid
- `.getUses()`{: .language-kube #product-get-uses }: Returns how much wear the animal will take from this event
- `.setUses(uses: number)`{: .language-kube #product-set-uses }: Sets the number of uses the animal will take from this event

{: #animal-product-example }

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

{: #collapse-methods }

### Method Signature

```js
event.getCenterBlock(): BlockContainerJS
event.getLevel(): Level
event.getRadiusSquared(): number
event.getSecondaryPositions(): List<BlockPos>
event.isFake(): boolean
```

- `.getCenterBlock()`{: .language-kube #collapse-center}: Returns the `BlockContainerJS` of the center block of the collapse
- `.getLevel()`{: .language-kube #collapse-level }: Returns the level of the collapse
- `.getRadiusSquared()`{: .language-kube #collapse-radius }: Returns the squared radius of the collapse, will be `0`{:.n} if the collapse is fake
- `.getSecondaryPositions()`{: .language-kube #collapse-secondaries }: Returns a list of `BlockPos`es which are the positions that will collapse
- `.isFake()`{: .language-kube #collapse-fake }: Returns true if the collapse is fake

{: #collapse-example }

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

{: #douse-fire-methods }

### Method Signature

```js
event.getLevel(): Level
event.getBlock(): BlockContainerJS
event.getBounds(): AABB
event.getPlayer(): @Nullable Player
event.getPos(): BlockPos
```

- `.getLevel()`{: .language-kube #douse-level }: Returns the event's level
- `.getBlock()`{: .language-kube #douse-block }: Returns the event's `BlockContainerJS`
- `.getBounds()`{: .language-kube #douse-bounds }: Returns an `AABB` representing the total effected area
- `.getPlayer()`{: .language-kube #douse-player }: Returns the player that doused the fire, may be null
- `.getPos()`{: .language-kube #douse-pos }: Returns the position that is being doused

{: #douse-fire-example }

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

{: #food-trait-methods }

### Method Signature

```js
event.registerTrait(decayModifier: number, id: String): void
event.registerTraitWithTooltip(decayModifier: number, id: String): void
```

- `.registerTrait(decayModifier: number, id: String)`{: .language-kube #trait-reg}: Registers a food trait under the given id with the provided decay modifier
- `.registerTraitWithTooltip(decayModifier: number, id: String)`{: .language-kube #trait-reg-tooltip }: Registers a food trait under the given id with the provided decay modifier, this trait will have a tooltip on the item with a translation key of `<id namespace>.tooltip.foodtrait.<id path>`

**Note**: A higher `decayModifier`{:.v} means the food rots faster

{: #food-trait-examples }

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

{: #ism-methods }

### Method Signatures

```js
simple(id: String, applicator: Function<ItemStack, ItemStack>): void
withInput(id: String, applicator: BiFunction<ItemStack, ItemStack, ItemStack>): void
withInventory(id: String, applicator: TriFunction<ItemStack, ItemStack, Iterable<ItemStack>, ItemStack>): void
```

- `.simple(id: String, applicator: Function<ItemStack, ItemStack>)`{: .language-kube #ism-simple }: Registers a modifier that is not input dependent
    - `id: String`{: .language-kube }: A string, the registry id to register the modifier as
    - `applicator: Function<ItemStack, ItemStack>`{: .language-kube }: A function that receives and returns an `ItemStack`, the output stack. Performs the modifications to the output stack
- `.withInput(id: String, applicator: BiFunction<ItemStack, ItemStack, ItemStack>)`{: .language-kube #ism-with-input }: Registers a modifier that is input dependent
    - `id: String`{: .language-kube }: A string, the registry id to register the modifier as
    - `applicator: BiFunction<ItemStack, ItemStack, ItemStack>`{: .language-kube }: A bi-function that receives two `ItemStack`s, the output stack and the input stack[^2], and returns an `ItemStack`, the modified output stack. Performs the modifications to the output stack
- `.withInventory(id: String, applicator: TriFunction<ItemStack, ItemStack, Iterable<ItemStack>, ItemStack>)`{: .language-kube #ism-with-inv }: Registers a modifier that is input dependent and has access to an iterable view of the input inventory
    - `id: String`{: .language-kube }: A string, the registry id to register the modifier as
    - `applicator: TriFunction<ItemStack, ItemStack, Iterable<ItemStack>, ItemStack>`{: .language-kube }: A tri-function that receives two `ItemStack`s, the output stack and the input stack[^2], and an `Iterable<ItemStack>`{: .language-kube }, an iterable view of the input inventory, and returns an `ItemStack`, the modified output stack. Performs the modifications to the output stack

[^2]: This stack should *not* be modified at all

{: #ism-examples }

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
        return output
    })
})
```

## Register Representative Blocks

- **Type**: `startup_scripts`

In 1.20, TFC added a representative blocks system for prospecting, essentially allowing ores of the same type but different grades to be viewed as the same when the prospector's pick counts the blocks nearby, this event allows you to register new representatives

{: #representative-methods }

### Method Signature

```js
event.register(representative: Block, blocks: Block[]): void
```

- 1st argument: The block to represent the other blocks
- 2nd argument: An array of blocks, to be represented by the first argument when prospecting

{: #representative-examples }

### Example

```js
TFCEvents.prospectRepresentative(event => {
    event.register('minecraft:clay', ['tfc:clay/loam', 'tfc:clay/silt', 'tfc:clay/sandy_loam', 'tfc:clay/silty_loam'])
})
```

## Modify Birthdays

- **Type**: `startup_scripts`

TFC has an easter egg in its calendar screen where on certain dates it will show someone's birthday, this event allows you to add and remove names from the list of birthdays

{: #birthdays-methods }

### Method Signatures

```js
event.add(month: Month, day: number, name: String): void
event.remove(month: Month, day: number): void
event.removeAll(): void
```

- `.add(month: Month, day: number, name: String)`{: .language-kube #birthdays-add }: Adds a birthday to the given month and day
- `.remove(month: Month, day: number)`{: .language-kube #birthday-remove }: Removes the birthday on the given month and day if there is one
- `.removeAll()`{: .language-kube #birthday-remove-all }: Removes all birthdays

{: #birthdays-example }

### Example

```js
TFCEvents.birthdays(event => {
    event.add('august', 4, 'Barack Obama')
})
```

## Register interactions

- **Type**: `startup_scripts`

TFC has a custom system for performing certain interactions with items, most notably knapping, this event exposes the ability to create your own interactions

{: #interactions-methods }

### Method Signatures

```js
event.interaction(ingredient: Ingredient, targetBlocks: boolean, targetAir: boolean, action: OnItemUseAction): void
event.interaction(ingredient: Ingredient, targetAir: boolean, action: OnItemUseAction): void
event.interaction(ingredient: Ingredient, action: OnItemUseAction): void
event.blockItemPlacement(item: Item, block: Block): void
```

- `.interaction(ingredient: Ingredient, targetBlocks: boolean, targetAir: boolean, action: OnItemUseAction)`{: .language-kube #interactions-interact-full }: Registers the given ingredient for the provided [action](#onitemuseaction), the boolean params determine if blocks and air should be valid targets
- `.interaction(ingredient: Ingredient, targetAir: boolean, action: OnItemUseAction)`{: .language-kube #interactions-interact-pared-down }: Registers the given ingredient for the provided [action](#onitemuseaction), the boolean param determines if air is a valid target, blocks default to being a valid target
- `.interaction(ingredient: Ingredient, action: OnItemUseAction)`{: .language-kube #interactions-interact-min }: Registers the given ingredient for the provided [action](#onitemuseaction), defaulting to blocks being valid targets and air not
- `.blockItemPlacement(item: Item, block: Block)`{: .language-kube #interactions-placement }: Registers a block placement for the given item, placing the given block

{: #interactions-example }

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

The basis of an interaction, a callback with two parameters and a return value:

- `stack: ItemStack`{: .language-kube }: The item in the hand
- `context: UseOnContext`{: .language-kube }: The context of the event
- `return: InteractionResult`{: .language-kube }: The result of the interaction, may be `success`{:.e}, `consume`{:.e}, `consume_partial`{:.e}, `pass`{:.e}, or `fail`{:.e}

## Modifying Worldgen defaults

**Type**: `startup_scripts`

Allows for editing the default settings of TFC chunk generator at world creation, including editing the rock layers

{: #worldgen-defaults-methods }

### Method Signatures

```js
event.flatBedrock(flat?: boolean): void
event.setSpawnDistance(i: number): void
event.setSpawnCenterX(i: number): void
event.setSpawnCenterZ(i: number): void
event.setTemperatureScale(i: number): void
event.setTemperatureConstant(f: number): void
event.setRainfallScale(i: number): void
event.setRainfallConstant(f: number): void
event.setContinentalness(f: number): void
event.setGrassDensity(f: number): void
event.addRock(rock: RockSettings, name: String, bottom: boolean): void
event.addRockFromId(id: String, name: String, bottom: boolean): void
event.getRock(name: String): RockSettings
event.getRockNames(): Set<String>
event.removeRock(name: String): void
event.addToBottom(name: String): void
event.removeFromBottom(name: String): void
event.defineLayer(id: String, rockMap: Map<String, String>): void
event.removeLayer(layerId: String): void
event.getLayerIds(): List<String>
event.cleanSlate(): void
event.addOceanFloorLayer(name: String): void
event.removeOceanFloorLayer(name: String): void
event.getOceanFloorLayers(): List<String>
event.addLandLayer(name: String): void
event.removeLandLayer(name: String): void
event.getLandLayers(): List<String>
event.addVolcanicLayer(name: String): void
event.removeVolcanicLayer(name: String): void
event.getVolcanicLayers(): List<String>
event.addUpliftLayer(name: String): void
event.removeUpliftLayer(name: String): void
event.getUpliftLayers(): List<String>
```

#### Climate Modifiers

- `.flatBedrock(flat?: boolean)`{: .language-kube #worldgen-bedrock }: Sets if the world should have flat bedrock, defaults to `false`{:.p}, calling without any arguments sets it to `true`{:.p}
- `.setSpawnDistance(i: number)`{: .language-kube #worldgen-spawn-distance }: Sets the distance from the spawn center that players may spawn, defaults to `4000`{:.n}
- `.setSpawnCenterX(i: number)`{: .language-kube #worldgen-spawn-x }: Sets the spawn center on the x-coordinate, defaults to `0`{:.n}
- `.setSpawnCenterZ(i: number)`{: .language-kube #worldgen-spawn-z }: Sets the spawn center on the z-coordinate, defaults to `0`{:.n}
- `.setTemperatureScale(i: number)`{: .language-kube #worldgen-temp-scale }: Sets the temperature scale of the world, the distance from pole-to-pole, defaults to `20000`{:.n}
- `.setTemperatureConstant(f: number)`{: .language-kube #worldgen-temp-const }: Sets the relative constant temperature of the world, defaults to `0`{:.n}
- `.setRainfallScale(i: number)`{: .language-kube #worldgen-rain-scale }: Sets the rainfall scale of the world, the distance from peak to peak, defaults to `20000`{:.n}
- `.setRainfallConstant(f: number)`{: .language-kube #worldgen-rain-const }: Sets the relative constant temperature of the world, defaults to `0`{:.n}
- `.setContinentalness(f: number)`{: .language-kube #worldgen-continentalness }: Sets the proportion of the world that is land instead of water, defaults to `0.5`{:.n}. A value of `0`{:.n} translates to -100% on the world creation screen and `1`{:.n} translates to +100%
- `.setGrassDensity(f: number)`{: .language-kube #worldgen-grass-density }: Sets the grass density of the world, defaults to `0.5`{:.n}. A value of `0`{:.n} translates to -100% on the world creation screen and `1`{:.n} translates to +100%

#### Rock Layer Settings Modifiers

TFC's worldgen is primarily based around *rocks*, *layers*, and *layer types*[^3]. There are 5 layer types, `bottom`, `ocean_floor`, `land`, `volcanic`, and `uplift`, the `bottom` layer type is unique in that it only possesses *rocks*, the rest only possess *layers*. Layer types determine which geologic environment a rock/layer will generate. Every layer type must have at least one entry. *Layers* and *rocks* are user defined and are referenced by name. Rocks define which blocks are placed where, see [registering them](#rock-settings) for more about that. Layers are a list of *rock*-*layer* pairs, associating a *rock* with the *layer* that should generate underneath it

[^3]: These terms are unofficial and exist to better help explain TFC's worldgen

- `.addRock(rock: RockSettings, name: String, bottom: boolean)`{: .language-kube #worldgen-add-rock }: Adds the given rock to the generator's pool of available rocks
    - `rock: RockSettings`{: .language-kube }: the `RockSettings` to add
    - `name: String`{: .language-kube }: The name which the rock can be referenced by
    - `bottom: boolean`{: .language-kube }: If the rock should be added to the 'bottom' layer of the world
- `.addRockFromId(id: String, name: String, bottom: boolean)`{: .language-kube #worldgen-add-rock-id }: Adds the given rock to the generator's pool of available rocks
    - `id: String`{: .language-kube }: the [registered](#rock-settings) id of the `RockSettings` to add
    - `name: String`{: .language-kube }: The name which the rock can be referenced by
    - `bottom: boolean`{: .language-kube }: If the rock should be added the the 'bottom' layer of the world
- `.getRock(name: String)`{: .language-kube #worldgen-get-rock }: Returns the `RockSettings` with the given name
- `.getRockNames()`{: .language-kube #worldgen-rock-names }: Returns a set of the names of all the rocks currently in the generator's pool of rocks
- `.removeRock(name: String)`{: .language-kube #worldgen-remove-rock }: Removes the provided rock from the generator's pool of available rocks and any references to it
- `.addToBottom(name: String)`{: .language-kube #worldgen-add-bottom }: Adds the given rock to the 'bottom' layer
- `.removeFromBottom(name: String)`{: .language-kube #worldgen-remove-bottom }: Removes the given rock from the 'bottom' layer
- `.defineLayer(id: String, rockMap: Map<String, String>)`{: .language-kube #worldgen-define-layer }: Defines a new layer
    - `id:String`{: .language-kube }: the name of the layer to add
    - `rockMap: Map<STring, String>`{: .language-kube }: A map of rock names to layer names, associates a rock with the layer that will generate underneath it
- `.removeLayer(layerId: String)`{: .language-kube #worldgen-remove-layer }: removes the given layer from the generator
- `.getLayerIds()`{: .language-kube #worldgen-get-layer-ids }: returns a list of the names of all layers currently in the generator's pool of layers
- `.cleanSlate()`{: .language-kube #worldgen-clean-slate }: Removes all rocks and layers from the generator
- `.addOceanFloorLayer(name: String)`{: .language-kube #worldgen-add-ocean }: Adds the given layer to the 'ocean_floor' layer type
- `.removeOceanFloorLayer(name: String)`{: .language-kube #worldgen-remove-ocean }: removes the given layer from the 'ocean_floor' layer type
- `.getOceanFloorLayers()`{: .language-kube #worldgen-get-ocean }: Gets the layers currently in the 'ocean_floor' layer type
- `.addLandLayer(name: String)`{: .language-kube #worldgen-add-land }: Adds the given layer to the 'land' layer type
- `.removeLandLayer(name: String)`{: .language-kube #worldgen-remove-land }: removes the given layer from the 'land' layer type
- `.getLandLayers()`{: .language-kube #worldgen-get-land }: Gets the layers currently in the 'land' layer type
- `.addVolcanicLayer(name: String)`{: .language-kube #worldgen-add-volcanic }: Adds the given layer to the 'volcanic' layer type
- `.removeVolcanicLayer(name: String)`{: .language-kube #worldgen-remove-volcanic }: Removes the given layer from the 'volcanic' layer type
- `.getVolcanicLayers()`{: .language-kube #worldgen-get-volcanic }: Gets the layers currently in the 'volcanic' layer type
- `.addUpliftLayer(name: String)`{: .language-kube #worldgen-add-uplift }: Adds the given layer to the 'uplift' layer type
- `.removeUpliftLayer(name: String)`{: .language-kube #worldgen-remove-uplift }: Removes the given layer from the 'uplift' layer type
- `.getUpliftLayers()`{: .language-kube #worldgen-get-uplift }: Gets the layers that are currently in the 'uplift' layer type

{: #worldgen-defaults-example }

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

{: #fauna-def-methods }

### Method Signatures

```js
event.replace(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types): void
event.and(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types): void
event.or(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types): void
```

- `.replace(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types)`{: .language-kube #fauna-replace }: Registers a new fauna definition for the entity type and overwrites any spawn conditions it may have had before
- `.and(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types)`{: .language-kube #fauna-and }: Registers a new fauna definition for the entity type and ANDs any pre-existing spawn conditions it may have had before with the fauna's rules
- `.or(entityType: EntityType<?>, suffix?: String, placementType: SpawnPlacements$Type, heightmap: Heightmap$Types)`{: .language-kube #fauna-or }: Registers a new fauna definition for the entity type and ORs any pre-existing spawn conditions it may have had before with the fauna's conditions, including other fauna definitions

All of these methods have the same arguments, which are described below

- `entityType: EntityType<?>`{: .language-kube }: The entity type to register the fauna for
- `suffix?: String`{: .language-kube }: An optional suffix to the autogenerated fauna id, which by default is just the entity type's id. Suffixed to the end of the id with a `/`. May be `null`{:.p} or simply not present
- `placementType: SpawnPlacements$Type`{: .language-kube }: Any of `on_ground`{:.e}, `in_water`{:.e}, `no_restrictions`{:.e}, or `in_lava`{:.e} and determines where the entity may be placed
- `heightmap: Heightmap$Types`{: .language-kube }: Any of `world_surface_wg`{:.e}, `world_surface`{:.e}, `ocean_floor_wg`{:.e}, `ocean_floor`{:.e}, `motion_blocking`{:.e}, or `motion_blocking_no_leaves`{:.e}. See the [Minecraft Wiki](https://minecraft.wiki/w/Heightmap) for an explanation for what each of these mean

{: #fauna-def-example }

### Example

```js
TFCEvents.registerFaunas(event => {
    event.replace('minecraft:pig', 'on_ground', 'world_surface_wg')
})
```

## Create Glass Operations

**Type**: `startup_scripts`

Allows for the creation of new glass operations for use in [glassworking]({% link kubejs_tfc/1.20.1/recipes.md %}#glassowrking) recipes

{: .notice #glass-operations-notice }
> For multiplayer connections the order and names of the new operations *must* be the same, otherwise the connection will be refused
>
> All operations created via this event will have `kubejs_` prefixed to their name

{: #glass-operations-methods }

### Method Signatures

```js
event.create(name: String, displayStack?: Supplier<ItemStack>, customSound?: ResourceLocation, minHeat?: number)
event.createPowder(powderItemId: ResourceLocation, name: String, customSound?: ResourceLocation, minHeat?: number)
```

- `.create(name: String, displayStack?: Supplier<ItemStack>, customSound?: ResourceLocation, minHeat?: number)`{: .language-kube #glass-op-create }: Creates a new glass operation with the given name
    - `name: String`{: .language-kube }: The name of the operation, will be prepended with `kubejs_`
    - `displayStack?: Supplier<ItemStack>`{: .language-kube }: An item stack that will be used to display the operation in JEI, if the item is `tfc:blowpipe_with_glass`, `tfc:ceramic_blowpipe_with_glass` will also be displayed. Optional
    - `customSound?: ResourceLocation`{: .language-kube }: The registry id of a custom sound to play when the operation is performed. Optional, defaults to `minecraft:block.anvil.use`
    - `minHeat?: number`{: .language-kube }: The minimum heat required to perform the operation. Optional, defaults to 480°C
- `.createPowder(powderItemId: ResourceLocation, name: String, customSound?: ResourceLocation, minHeat?: number)`{: .language-kube #glass-op-powder }: Creates a new glass operation with the given name and enables it to be added via the powder bowl
    - `powderItemId: ResourceLocation`{: .language-kube }: The registry id of an item to use as this operation's powder, requires the `tfc:powders` tag in order to be put in a bowl. Will be used as the display item in JEI
    - `name: String`{: .language-kube }: The name of the operations, will be prepended with `kubejs_`
    - `customSound?: ResourceLocation`{: .language-kube }: The registry id of a custom sound to play when the operation is performed. Optional, defaults to `minecraft:block.anvil.use`
    - `minHeat: number`{: .language-kube }: The minimum heat required to perform the operation. Optional, defaults to 480°C

{: #glass-operations-example }

### Example

```js
TFCEvents.createGlassOperations(event => {
    event.createPowder('kubejs:quartz_powder', 'quartz')
})
```

## Create Chunk Data Provider

**Type**: `server_scripts`

When used with a specific chunk generator type, this event allows for custom generation of TFC's [ChunkData]({% link kubejs_tfc/1.20.1/misc.md %}#print-chunk-data) permitting [fauna definitions](#register-fauna-definitions), [climate placement modifiers]({% link kubejs_tfc/1.20.1/worldgen.md %}#climate), TFC's climate-based structure modifier, and any other configured features which are dependent on the world generator to be TFC-like (erosion, boulders, etc.) to function properly with level generators other than TFC's.

{: #chunk-data-provider-generator }

### Chunk Generator

Due to how TFC's chunk data works, this functionality is inherently tied to a `ChunkGenerator`. KubeJS TFC adds a new generator type, `kubejs_tfc:wrapped` which will wrap any arbitrary chunk generator and imitate its function while providing TFC's additional values.

In its json definition, the generator definition has the following fields:

- `type` must be `kubejs_tfc:wrapped`
- `event_key`: The key which the event is fired for. A string.
- `settings`: Same as `tfc_settings` in [TFC's chunk generator](https://terrafirmacraft.github.io/Documentation/1.20.x/worldgen/world-preset/). These values are unlikely to be used except for the rock layer settings which can be used in custom rock generation.
- `generator`: A chunk generator.

{: #chunk-data-provider-rule-source }

### Rock Surface Rule Source

In addition, a custom surface rule source that uses the blocks of the `RockSettings`, as provided via the [rocks callback](#chunk-data-provider-rocks) in the event. This rule source only works with the `kubejs_tfc:wrapped` generator wrapping a `minecraft:noise`[^4] chunk generator

[^4]: Or any generator type which extends `NoiseBasedChunkGenerator` and overrides `.buildSurface(ChunkAccess,WorldGenerationContext,RandomState,StructureManager,BiomeManager,Registry<Biome>,Blender)`{: .language-kube }

In its json definition, the rule source has the following fields:

- `type` must be `kubejs_tfc:rock`
- `fallback_state`: A block state. Used when the `RockSettings` at a point could not be found, or the world's chunk generator is not compatible with this rule source
- `rock_block`: A string, one of `raw`, `hardened`, `gravel`, `cobble`, `sand`, or `sandstone`. Specifies which block from the `RockSettings` to use. Optional, defaults to `raw`

{: #chunk-data-provider-rule-source-example }

#### Example

```json
{
    "type": "kubejs_tfc:rock",
    "rock_block": "sandstone",
    "fallback_state": {
        "Name": "minecraft:sandstone"
    }
}
```

{: #chunk-data-provider-methods }

### Method Signatures

```js
event.getWorldSeed(): number
event.getNormalNoise(id: ResourceLocation): NormalNoise
event.partial(gen: BiConsumer<ChunkData, ChunkAccess>): void
event.full(gen: BiConsumer<ChunkData, ChunkAccess>): void
event.erosionalAquifer(aquifer: Function<ChunkAccess, Aquifer>): void
event.rocks(getter: RocksGetter): void
```

- `.getWorldSeed()`{: .language-kube #chunk-data-provider-seed }: Returns the seed of the world the chunk data provider is being applied to
- `.getNormalNoise(id: ResourceLocation)`{: .language-kube #chunk-data-provider-normal-noise }: Returns the `NormalNoise` defined by the noise parameters at the given id
- `.partial(gen: BiConsumer<ChunkData, ChunkAccess>)`{: .language-kube #chunk-data-provider-partial }: Sets the calculation for the information required to promote a chunk's `ChunkData` to `PARTIAL`{:.e}. Accepts a callback with two parameters and no return value. If not set, or `.generatePartial(...)`{: .language-kube } is never called, the chunk data will be [filled with zero values](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/util/implementation/worldgen/KubeChunkDataGenerator.java#L30-L36). The parameters are:
    - `data: ChunkData`{: .language-kube }: TFC's [ChunkData](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkData.java). `.generatePartial(...)`{: .language-kube } should be called here. `.generateFull(...)`{: .language-kube } *can* be called here, but there is no guarantee that the chunk will have access to heightmaps during this callback. The parameters for `.generatePartial(...)`{: .language-kube } are:
        - `rainfallLayer: LerpFloatLayer`{: .language-kube }: A [LerpFloatLayer]({% link kubejs_tfc/1.20.1/bindings/misc.md %}#lerp-float-layer) of the yearly average rainfall at the corners of the chunk. Used in TFC's climate model to determine the rainfall at a position
        - `temperatureLayer: LerpFloatLayer`{: .language-kube }: A [LerpFloatLayer]({% link kubejs_tfc/1.20.1/bindings/misc.md %}#lerp-float-layer) of the yearly average temperature at the corners of the chunk. Used by TFC's climate model to determine the average temperature at a position
        - `forestType: ForestType`{: .language-kube }: The forest type of the chunk, may be `none`{:.e}, `sparse`{:.e}, `edge`{:.e}, `normal`{:.e}, or `old_growth`{:.e}
        - `forestWeirdness: number`{: .language-kube }: A number, in the range [0, 1], for the 'weirdness' of forests in the chunk. Used by TFC's forest configured feature
        - `forestDensity: number`{: .language-kube }: A number, in the range [0, 1], for the density of the forests in the chunk. Used by TFC's forest configured feature
    - `chunk: ChunkAccess`{: .language-kube }: The chunk data is being generated for. **Note**: Heightmap access is not guaranteed during this callback
- `.full(gen: BiConsumer<ChunkData, ChunkAccess>)`{: .language-kube #chunk-data-provider-full }: Sets the calculation for the information required to promote the chunks `ChunkData` from `PARTIAL`{:.e} to `FULL`{:.e}. Accepts a callback with two parameters and no return value. If not set, or `.generateFull(...)`{: .language-kube } is never called, the data will be promoted with [values matching the `ocean_floor_wg` heightmap for surface heights and 20 less than the quart average of the surface heights](https://github.com/Notenoughmail/KubeJS-TFC/blob/1.20.1/src/main/java/com/notenoughmail/kubejs_tfc/util/implementation/worldgen/KubeChunkDataGenerator.java#L37-L57). The parameters are:
    - `data: ChunkData`{: .language-kube }: TFC's [ChunkData](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkData.java). `.generateFull(...)`{: .language-kube } should be called here and the chunk is guaranteed to have access to the `WORLD_SURFACE_WG`{:.e} and `OCEAN_FLOOR_WG`{:.e} heightmaps during this callback. The parameters for `.generateFull(...)`{: .language-kube } are:
        - `surfaceHeight: int[256]`{: .language-kube }: An array of integer values of size `256`{:.n} (`16`{:.n} * `16`{:.n}; `BlockPos` resolution) representing the surface height of the world. Value indexes are `x + 16 * z`{: .language-kube } where `x` and `z` are the local x and z coordinates within the chunk and are in the range [0, 15]. This is where the `surfaceY`{:.v} parameter of a `RocksGetter`{:.f} callback is gotten from.
        - `aquiferSurfaceHeight: int[16]`{: .language-kube }: An array of integer values of size `16`{:.n} (`4`{:.n} * `4`{:.n}; `QuartPos` resolution) representing the height of aquifer surfaces. Only used by [TFCAquifer](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/TFCAquifer.java)s
    - `chunk: ChunkAccess`{: .language-kube }: The chunk data is being generated for
- `.erosionalAquifer(aquifer: Function<ChunkAccess, Aquifer>)`{: .language-kube #chunk-data-provider-aquifer }: Sets the calculation for the `Aquifer` of a given chunk. This aquifer is used by TFC's erosion feature to place subterranean liquids. Accepts a callback with one parameter and a return value. If not set, an aquifer that only fills air will be returned. The parameters are:
    - `chunk: ChunkAccess`{: .language-kube }: The chunk the aquifer is being generated for
    - `return: Aquifer`{: .language-kube }: An `Aquifer`. See [TFCAquifer](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/TFCAquifer.java) for TFC's implementation.
- `.rocks(getter: RocksGetter)`{: .language-kube #chunk-data-provider-rocks }: Sets the Calculation for the `RockSettings` at a position. Used by several configured feature types to determine what blocks to place. Accepts a callback with 6 parameters and a return value. If not set, or when null is returned, a `RockSettings` made entirely of air is returned. The parameters are:
    - `x: number`{: .language-kube }: A number, the x coordinate
    - `y: number`{: .language-kube }: A number, the y coordinate
    - `z: number`{: .language-kube }: A number, the z coordinate
    - `surfaceY: number`{: .language-kube }: A number, the surface elevation of the block column, as determined from the calculation provided in `.full(...)`{: .language-kube }
    - `cache: @Nullable ChunkRockDataCache`{: .language-kube }: A [ChunkRockDataCache](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/ChunkRockDataCache.java) which may be `null`{:.p}. Holds the layer height and skew amounts per layer
    - `rockLayers: RockLayerSettings`{: .language-kube }: The [RockLayerSettings](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/settings/RockLayerSettings.java) defined in the chunk generator's `settings` object
    - `return: RockSettings`{: .language-kube }: A [RockSettings](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/settings/RockSettings.java) describing the rock at the position. Ideally retrieved from the `RockLayerSettings`

  The `RockLayerSettings` provided in the parameters of the callback has a method, `.sampleAtLayer(pointRock: int, layerN: int)`{: .language-kube } which returns a `RockSettings`. The parameters are:
    - `pointRock: int`{: .language-kube }: A 32-bit signed integer. The bottom two bits are used to select which primary rock type is used at the 0th layer
        - `0b00`{:.n}: Ocean layer
        - `0b01`{:.n}: Volcanic layer
        - `0b10`{:.n}: Land layer
        - `0b11`{:.n}: Uplift layer

      And the top 30 bits are used as a seed for a random number generator used to pick from the layer's mappings for the next layer when `layerN`{:.v} is greater than `0`{:.n}
    - `layerN: int`{: .language-kube }: How many times to iterate to a layer's next layer as described in the layer's mapping. Accepts any non-negative number; the `bottom` pseudo-layer points towards itself

{: #chunk-data-provider-example }

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
          "hardened": "minecraft:blackstone",
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
        .scaled(70, 90);
    const forestLayer = TFC.misc.newOpenSimplex2D(event.worldSeed + 98713856895664)
        .spread(0.8)
        .terraces(9)
        .affine(6, 12)
        .scaled(6, 18, 0, 1);

    const rockTypeNoise = TFC.misc.newOpenSimplex2D(event.worldSeed + 3216548497)
        .spread(0.061)
        .scaled(0, 3) // 0: Oceanic; 1: Volcanic; 2: Land; 3: Uplift
        .map(val -> Math.round(val));
    const rockLayerNoise = TFC.misc.newOpenSimplex2D(event.worldSeed + 9774532562233)
        .spread(0.000697)
        .scaled(0x80000000, 0x7fffffff) // Effectively acts as a random number generator within the range of Java's int type
        .map(val -> val << 2) // Shift up two bits so the type noise is what is used for rock types instead of the random number
        .add(rockTypeNoise);
    const rockLayerHeightNoise = TFC.misc.newOpenSimplex2D(event.worldSeed + 30121796313692)
        .octaves(6)
        .scaled(12, 34)
        .spread(0.009);

    // Noises defined through json can be gotten through this method
    const surfaceNoise = event.getNormalNoise('minecraft:surface');

    // Precompute the aquifer heights as constants as this is nether and will not realistically change
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
            forestLayer.noise(x * 78423 + 869, z),
            forestLayer.noise(x, z * 651349 - 698763)
        );
    });

    event.full((data, chunk) => {
        var heights = [];
        // In the nether this will always return 127, but this is included as a demonstration of
        // using height maps and properly indexing the height values within the array
        for (let x = 0 ; x < 16 ; x++) {
            for (let z = 0 ; z < 16 ; z++) {
                let height = chunk.getHeight('ocean_floor_wg', x, z);
                heights[x + 16 * z] = height;
            }
        }
        data.generateFull(heights, aquifer);
    });

    event.rocks((x, y, z, surfaceY, cache, rockLayers) => {
        let layer = 0;
        let layerHeight = 0;
        let deltaY = surfaceY - y;

        do {
            // A simplified version of what TFC does for its layer depth
            // Of note is the lack of skewing for either the rock layer or the heights
            layerHeight = rockLayerHeightNoise.noise(x >> 5, z >> 5) + surfaceNoise.getValue(x, 56, z);
            if (deltaY <= layerHeight) {
                break;
            }
            deltaY -= layerHeight;
            layer++;
        } while (deltaY > 0);

        return rockLayers.sampleAtLayer(rockLayerNoise.noise(x, z), layer);
    });
})
```

## Item Stack Modifier Converters

**Type**: `startup_scripts`

KubeJS TFC's wrapper around TFC's `ItemStackProvider`s holds its [item stack modifiers](#custom-item-stack-modifiers) in json form. Typically, this is fine; but when converting the canon ISP class to the wrapper type, the ISMs need to be converted to json. This is not supported by default

This event allows scripters to register custom ISM -> json converters for types not already handled

By default, all TFC, Firmalife, and TFC Casting with Channels ISM types have converters. Additionally, all simple (extends `ItemStackModifier$SingleInstance`) ISM types, including custom kube modifiers, are converted automatically

{: #ism-converter-methods }

### Method Signature

```js
<T extends ItemStackModifier> event.register(type: Class<T>, converter: BiConsumer<T, JsonObject>): void
```

- 1st argument: The class to register a converter for
- 2nd argument: A callback with two parameters
    - The modifier to be converted
    - A `JsonObject`; this already has the `type` property

{: #ism-converter-example }

### Example

```js
TFCEvents.registerItemStackModifierConverters(event => {
    event.register(Java.loadClass('com.sunshine_mods.sunny_tfc.common.SunnyModifier'), (modifier, json) => {
        json.addProperty('sun_value', modifier.sunValue());
        json.addProperty('brightness', modifier.brightness());
    })
})
```

{% comment %}

#### Chunk Data Provider Rocks

This comment is here to make VSC shut up because it can't link to synthetic anchors

{% endcomment %}
