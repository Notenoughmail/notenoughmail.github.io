---
layout: page
title: Custom Blocks, Items, and Fluids
permalink: /kubejs_tfc/1.20.1/custom/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Custom Blocks, Items, and Fluids

KubeJS TFC allows you to create some of TFC's [block](#blocks), [item](#items), [fluid](#fluids), and [BE attachment](#attachments) types

## Blocks

The following types are available:

- [Aqueduct](#aqueduct)
- [Ground Cover](#ground-cover)
- [Loose Rock](#loose-rock)
- [Raw Rock](#raw-rock)
- [Rock Spike](#rock-spike)
- [Thin Spike](#thin-spike)
- [Moss Spreading](#moss-spreading)
- [Moss Growing](#moss-growing)
- [Lamp](#lamp)
- [Stationary Berry Bush](#stationary-berry-bush)
- [Spreading Berry Bush](#spreading-berry-bush)
- [Dirt](#dirt)
- [Wild Crops](#wild-crops)
- [Default Crops](#default-crops)
- [Double Crops](#double-crops)
- [Spreading Crops](#spreading-crops)
- [Flooded Crops](#flooded-crops)
- [Pickable Crops](#pickable-crops)
- [Supports](#supports)
- [Anvils](#anvils)
- [Axles](#axles)
- [Encased Axles](#encased-axles)

<a id="firmalife-blocks"></a>If [FirmaLife](https://modrinth.com/mod/firmalife) is installed, the following types are also available:

- [Cheese Wheel](#firmalife-cheese-wheel)

### Aqueduct

Creates a new aqueduct block

Inherits the methods of the default block builder

**Type**: `tfc:aqueduct`

#### Extra Method

- `.allowedFluids(fluids: string[])`: Sets the fluids that the aqueduct may hold
    - `fluids`: The registry names of fluids the aqueduct can hold. Two liquids with different namespaces but same paths will not be accepted, `minecraft:empty` will automatically be added

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_aqueduct', 'tfc:aqueduct')
})
```

### Ground Cover

Creates a new ground cover block

Inherits the methods of the default block builder

**Type**: `tfc:ground_cover`

#### Extra Methods

- `.ore()`: Sets the collision shape to that of TFC's ores
- `.twig()`: Sets the collision shape to that of TFC's twigs and makes the block flammable
- `.groundCoverModel(model: string)`: Sets the default parent model, defaults to `loose/igneous_intrusive_2`
    - This accepts anything added to [kubejs_tfc/models/block/ground_cover/](https://github.com/Notenoughmail/KubeJS-TFC/tree/1.20.1/src/main/resources/assets/kubejs_tfc/models/block/ground_cover)
- `.notAxisAligned()`: Rotates placed models by 45 degrees
- `.collision()`: Enables collision for the block
- `.withPreexistingItem(item: ResourceLocation)`: Sets the 'block item' of the block to be an existing item

### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_placed_ore', 'tfc:ground_cover').ore()
})
```

### Loose Rock

Creates a new loose rock block

Inherits the methods of the default block builder

**Type**: `tfc:loose_rock`

#### Extra Methods

- `.rotateModel(i: number)`: Rotates the placed models by the given amount of degrees
- `.collision()`: Enables collision for the block
- `.itemTexture(texture: string)`: Sets the item's `layer0` texture
- `.itemTexture(key: string, texture: string)`: Sets the item's texture for the given key
- `.itemTextureJson(json: JsonObject)`: Sets the json for the item model
- `.rockTypeModel(type: string)`Sets the rock type models that should automatically be used, accepts `igneous_extrusive`, `igneous_intrusive`, `metamorphic`, or `sedimentary`, defaults to `metamorphic`

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_loose_rock', 'tfc:loose_rock')
        .rockTypeModel('sedimentary')
})
```

### Raw Rock

Creates a new raw rock block

Inherits the methods of the default block builder

**Type**: `tfc:raw_rock`

#### Extra Methods

- `.naturallySupported(supported: boolean)`: Determines if the block is considered to be naturally supported for the purposes of spawning particles indicating unsupported regions
- `.rockTypeTooltip(component: Component)`: Sets the tooltip component indicating the block's rock type
- `.felsicIgneousExtrusive()`: Sets the item's rock type tooltip to be that of felsic igneous extrusive rocks
- `.intermediateIgneousExtrusive()`: Sets the item's rock type tooltip to be that of intermediate igneous extrusive rocks
- `.maficIgneousExtrusive()`: Sets the item's rock type tooltip to be that of intermediate mafic extrusive rocks
- `.maficIgneousIntrusive()`: Sets the item's rock type tooltip to be that of mafic igneous intrusive rocks
- `.felsicIgneousIntrusive()`: Sets the item's rock type tooltip to be that of felsic igneous intrusive rocks
- `.intermediateIgneousIntrusive()`: Sets the item's rock type tooltip to be that of intermediate igneous intrusive rocks
- `.metamorphic()`: Sets the item's rock type tooltip to be that of metamorphic rocks
- `.sedimentary()`: Sets the item's rock type tooltip to be that of sedimentary rocks

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_raw_block', 'tfc:raw_rock')
        .rockTypeTooltip(Text.translatable('tooltip.kubejs.space_rock'))
})
```

### Rock Spike

Creates a rock spike block

Inherits the methods of the default block builder

**Type**: `tfc:rock_spike`

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_rock_spike', 'tfc:rock_spike')
})
```

### Thin Spike

Creates a thin spike block

Inherits the methods of the default block builder

**Type**: `tfc:thin_spike`

#### Extra Methods

- `.drips()`: Makes the block drip particles
- `.dripChance(f: number)`: Sets the chance, in the range [0, 1], the block will drip per tick
- `.dripTemp(f: number)`: Sets the temperature at which the block must be above to begin dripping
- `.melts()`: makes the block melt under certain conditions
- `.meltChance(f: number)`: Sets the chance, in the range [0, 1], that the block will melt per random tick
- `.meltTemp(f: number)`: Sets the temperature above which the block can melt
- `.dripParticle(particle: string)`: The registry name of a particle, the particle that will drip from the block
- `.meltFluid(fluid: FluidStackJS)`: The fluid that the block melts into
- `.tipModel(model: string)`: Sets the parent model of the tip state

### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_lava_spike', 'tfc:thin_spike')
        .meltFluid('minecraft:lava')
        .meltTemp(50)
})
```

### Moss Spreading

TFC has blocks which can spread moss to [moss growing blocks](#moss-growing)

There are four types: block, stair, slab, and wall and have the same methods as their type's parent builder

These are effected by TFC's mossy spreading config

**Types**: `tfc:moss_spreading_block`, `tfc:moss_spreading_stair`, `tfc:moss_spreading_slab`, `tfc:moss_spreading_wall`

#### Examples

```js
StartupEvents.registry('block', event => {
    event.create('my_moss_spreading_block', 'tfc:moss_spreading_block')
    event.create('my_moss_spreading_stair', 'tfc:moss_spreading_stair')
    event.create('my_moss_spreading_slab', 'tfc:moss_spreading_slab')
    event.create('my_moss_spreading_wall', 'tfc:moss_spreading_wall')
})
```

### Moss growing

TFC has blocks which can have moss spread to them from [moss spreading blocks](#moss-spreading)

There are four types: [block](#full-block), [stair](#stair), [slab](#slab), and [wall](#wall)

#### Full block

**Type**: `tfc:moss_growing_block`

Extra methods:

- `.mossyBlock(block: string)`: Accepts a string, the registry name of the block this will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

Example:

```js
StartupEvents.registry('block', event => {
    event.create('my_moss_growing_block', 'tfc:moss_growing_block')
        .mossyBlock('kubejs:my_moss_spreading_block')
})
```

#### Stair

**Type**: `tfc:moss_growing_stair`

Extra methods:

- `.mossyStair(block: string)`: Accepts a string, the registry name of a stair block that the block will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

Example:

```js
StartupEvents.registry('block', event => {
    event.create('my_moss_growing_block', 'tfc:moss_growing_block')
        .mossyStair('kubejs:my_moss_spreading_stair')
})
```

#### Slab

**Type**: `tfc:moss_growing_slab`

Extra methods:

- `.mossySlab(block: string)`: Accepts a string, the registry name of a slab block that the block will turn into when moss grows to it
- `.mossyConversionFull(callback: MossGrowingCallback)`: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow when the `type` state is `double`
- `.mossyConversionHalf(callback: MossGrowingCallback)`: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow when the `type` state is `top` or `bottom`
- `.mossyConversion(callback: MossGrowingCallback)`: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow for any `type` state

Example

```js
StartupEvents.registry('block', event => {
    event.create('my_moss_growing_slab', 'tfc:moss_growing_slab')
        .mossySlab('kubejs:my_moss_spreading_slab')
})
```

#### Wall

**Type**: `tfc:moss_growing_wall`

Extra methods:

- `.mossyWall(block: string)`: Accepts a string, the registry name of a wall block that the block will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

Example

```js
StartupEvents.registry('block', event => {
    event.create('my_moss_growing_wall', 'tfc:moss_growing_wall')
        .mossyWall('kubejs:my_moss_spreading_wall')
})
```

### Moss Growing Callback

This is used when determining if a moss growing block should convert to its mossy variant

You are given a `BlockContainerJS` and a boolean, known as `needsWater`, which, in default TFC, is always `true` and expected to return a boolean indicating if the block should convert

#### Examples

```js
// Returns true if the block's y value is greater than 60
(container, needsWater) => {
    return container.pos.y > 60
}
// Returns true if it is night
(container, needsWater) => {
    return container.level.isNight()
}
// Returns true if the block is not receiving a redstone signal
(container, needsWater) => {
    return container.level.getBestNeighborSignal(container.pos) == 0
}
```

### Lamp

Creates a new lamp block

Inherits the methods of the default block builder

**Type**: `tfc:lamp`

#### Extra Methods

- `.lightLevel(i: number)`: Accepts a number, in the range [1, 15], sets the light level the lamp gives off when lit, defaults to `15`
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_lamp', 'tfc:lamp')
        .lightLevel(4)
})
```

### Stationary Berry Bush

Creates a new stationary bush block

Inherits the methods of the default block builder

**Type**: `tfc:stationary_berry_bush`

#### Extra Methods

- `.lifecycle(month: Month, lifecycle: Lifecycle)`: Sets the bush's lifecycle for a particular month, defaults to `dormant` for ever month, accepts a month for the first parameter, and either `healthy`, `dormant`, `fruiting`, or `flowering` for the second
- `.productItem(item: Consumer<ItemBuilder>)`: Sets the properties of the bush's product item, the item gotten by right clicking a bush when it is fruiting
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.productItem(item: ResourceLocation)`: Sets the bush's product item to be an existing item, will prevent the other product item from being created

Additionally, this will register a climate range with the same id as the block, it can be set through the [data event](/data/#climate-ranges)

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_stationary_bush', 'tfc:stationary_berry_bush')
        .lifecycle('march', 'healthy')
        .lifecycle('april', 'healthy')
        .lifecycle('may', 'flowering')
        .lifecycle('june', 'fruiting')
        .lifecycle('july', 'healthy')
})
```

### Spreading Berry Bush

Creates a new spreading bush block

Inherits the methods of the stationary bush builder

**Type**: `tfc:spreading_berry_bush`

#### Extra Methods

- `.maxHeight(i: number)`: Sets the maximum number of blocks the bush may climb, defaults to `3`

Additionally, this will register a climate range with the same id as the block, it can be set through the [data event](../data/#climate-ranges)

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_spreading_bush', 'tfc:spreading_berry_bush')
        .lifecycle('january', 'fruiting')
        .lifecycle('february', 'fruiting')
        .lifecycle('march', 'healthy')
        .lifecycle('april', 'flowering')
        .maxHeight(14)
})
```

### Dirt

Creates a new dirt block

Inherits the methods of the default block builder

**Type**: `tfc:dirt`

#### Extra Methods

- `.grass(grass: Consumer<ConnectedGrassBlockBuilder>)`: Sets the properties of the dirt block's grass block. Has the same id as the dirt block but with `_grass` appended to the end. Has the same methods as the default block builder and:
    - `.uniqueDirtTexture()`: Textures the side of the grass block with a texture path based on the grass block instead of the dirt block
- `.path(path: Consumer<TFCPathBlockBuilder>)`: Creates and sets the properties of the dirt block's path bloc. Has the same id as the dirt block but with `_path` appended to the end. Has the same methods as the default block builder
- `.farmland(farmland: Consumer<TFCFarmlandBlockBuilder>)`: Creates and sets the properties of the dirt block's farmland block. Has the same id as the dirt block but with `_farmland` appended to the end. Has the following methods:
    - Those of the default block builder
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.rooted(rooted: Consumer<TFCRootedDirtBlockBuilder>)`: Creates and sets the properties of the dirt block's rooted dirt block. Has the same id as the dirt block but with `_rooted` appended to the end. Has the same methods as the default block builder
- `.mud(mud: Consumer<BlockBuilder>)`: Creates and sets the properties of the dirt block's mud block. Has the same id as the dirt block but with `_mud` appended to the end

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_dirt', 'tfc:dirt')
        .grass(grass => {
            grass.hardness(1)
        })
        .path(path => {
            path.hardness(1)
        })
        .farmland(farmland => {
            farmland.hardness(1)
            farmland.extendedProperties(props => {
                props.flammable(3, 6)
            })
        })
        .rooted(rooted => {
            rooted.hardness(1)
        })
})
```

### Wild Crops

Creates a new wild crop block

Inherits the methods of the default block builder

**Type**: `tfc:wild_crop`

#### Extra Methods

- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.type(type: Type)`: Sets the type of wild crop block to be used, available options are `default`, `double`, `flooded`, and `spreading`, defaults to `default`
- `.spreadingFruitBlock(fruitBlock: ResourceLocation)`: Sets the block to be used as the fruit block if the wild crop's type is `spreading`, defaults to `minecraft:honey_block`
- `.seeds(seedItem: ResourceLocation)`: Sets the 'seed' item to be used in the auto-generated loot table
- `.food(foodItem: ResourceLocation)`: Sets the 'food' item to be used in the auto-generated loot table
- `.deadModel(model: string)`: Sets the model to use when the crop is dead/immature and its type is `default` or `flooded`
- `.doubleDeadModels(topModel: string, bottomModel: string)`: Sets the models to use when the crop is dead/immature and sets the crop's type to `double`
- `.spreadingDeadModels(coreModel: string, sideModel: string)`: Sets the models to use when the crop is dead/immature and sets the crop's type to `spreading`

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_wild_spreading_crop', 'tfc:wild_crop')
        .spreadingDeadModels('minecraft:block/cobblestone', 'minecraft:block/deepslate')
        .spreadingFruitBlock('minecraft:stone')
})
```

### Default Crops

Creates a new crop block

Inherits the methods of the default block builder

**Type**: `tfc:crop`

#### Extra Methods

- `.stages(i: number)`: Sets the number of growth stages the block has, should be a number between 1 and 12, defaults to `8`
- `.deadBlock(deadCrop: Consumer<DeadCropBlockBuilder>)`: A consumer for editing the properties of the crop's dead block
    - The consumer has the same methods as the default block builder and one additional one:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.seedItem(seedItem: Consumer<SeedItemBuilder>)`: A consumer for setting the properties of the block's seed item
- `.productItem(productItem: Consumer<ItemBuilder>)`: A consumer for setting the properties of the block's product item
- `.productItem(productItem: ResourceLocation)`: Sets the crop's 'product' item to be an existing item, will be prevent the other product item from existing
- `.nutrient(nutrient: NutrientType)`: Sets the nutrient the crop consumes, available options are `nitrogen`, `phosphorous` , and `potassium`, defaults to `nitrogen`
- `.texture(texture: string)`: Sets the crop's `crop` texture for all growth stages
- `.textureAll(id: string, texture: string)`: Sets the crop's texture for the id for all growth stages
- `.model(model: string)`: Sets the crop's model for all growth stages
- `.model(gen: Consumer<ModelGenerator>)`: Sets the crop's model for all growth stages
- `.model(i: number, gen: Consumer<ModelGenerator>)`: Sets the crop's model for a specific growth stage
- `.model(i: number, model: string)`: Sets the crop's model for a specific growth stage
- `.texture(i: number, id: string, texture: string)`: Textures a specific key for the given stage
- `.texture(i: number, texture: string)`: Sets the crop's `crop` texture for the given growth stage
- `.textures(textures: JsonObject)`: Sets the crop's textures for all growth stages
- `.textures(i: number, textures: JsonObject)`: Sets the crop's textures for the given growth stage

Additionally this will register a climate range with the same id as the block, it can be set through the [data event](../data/#climate-ranges)

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_crop', 'tfc:crop')
        .nutrient('phosphorous')
        .productItem(product => {
            product.unstackable()
            product.burnTime(500)
        })
})
```

### Double Crops

Creates a new double tall crop block

Inherits the methods of the [TFC crop builder](#default-crops)

**Type**: `tfc:double_crop`

#### Extra Methods

- `.stages(i: number)`: Sets the number of growth stages the block has, should be a number between 1 and 6, defaults to `4`
- `.doubleStages(i: number)`: Sets the number of stages the crop has in its top state, should be a number between 1 and 6, defaults to `4`
- `.requiresStick(required: boolean)`: Determines if the crop needs a stick to grow

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_double_crop', 'tfc:double_crop')
        .requiresStick(true)
})
```

### Spreading Crops

Creates a new spreading crop block

Inherits the methods of the [TFC crop builder](#default-crops)

**Type**: `tfc:spreading_crop`

#### Extra Method

- `.fruitBlock(fruitBlock: ResourceLocation)`: Sets the block that will be used as the block's fruit block, defaults to `minecraft:honey_block`

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_spreading_crop', 'tfc:spreading_crop')
        .fruitBlock('minecraft:melon')
})
```

### Flooded Crops

Creates a new flooded crop block

Inherits the methods of [TFC's crop builder](#default-crops)

**Type**: `tfc:flooded_crop`

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_flooded_crop', 'tfc:flooded_crop')
})
```

### Pickable Crops

Creates a new spreading crop block

Inherits the methods of [TFC's crop builder](#default-crops)

**Type**: `tfc:pickable_crop`

#### Extra Methods

- `.fruit(fruit: ResourceLocation)`: Sets the item the player will be given when they pick the block
- `.matureFruit(fruit: ResourceLocation)`: Sets the item the player will be given when they pick the block and the crop is mature, defaults to `minecraft:apple`

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_pickable_crop', 'tfc:pickable_crop')
        .matureFruit('minecraft:stone')
        .fruit('minecraft:cobblestone')
})
```

### Supports

Creates a new support block

Inherits the methods of the default block builder

Will not automatically support blocks, use the [support method](../data/#supports) in the data event for that

**Type**: `tfc:support`

#### Extra methods

- `.horizontal(horizontalSUpport: Consumer<HorizontalSupportBlockBuilder>)`: Allows for editing of the properties of the horizontal block
    - The consumer has the same methods as the default block builder and one additional one:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_support', 'tfc:support')
})
```

### Anvils

Creates a new anvil block

Inherits the methods of the default block builder

**Type**: `tfc:anvil`

#### Extra Methods

- `.tier(i: number)`: Sets the tier of the anvil, defaults to 0
- `.defaultName(name: Component)`: Sets the default name of the anvil screen, defaults to `Text.translatable('tfc.block_entity.anvil')`
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_anvil', 'tfc:anvil')
        .tier(8)
        .defaultName(Text.translatable('kubejs.title.super_anvil'))
})
```

### Axles

Creates a new axle block, in addition to blocks derived from it

Inherits the methods of the default block builder

**Type**: `tfc:axle`

#### Extra Methods

- `.axleTexture(texture: string)`: Sets the texture the axle will be rendered with
- `.windmill(windmill: Consumer<WindmillBlockBuilder>)`: Sets the properties of the axle's windmill block
    - The consumer has the same methods as the default block builder and one additional one:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.waterWheel(waterWheel: Consumer<WaterWheelBlockBuilder>)`: Creates and sets the properties of the axle's water wheel block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.texture(texture: string)`: Sets the texture the water wheel will use, the path is relative to `/textures/entity/waterwheel/`
- `.gearBox(gearBox: Consumer<GearBoxBlockBuilder>)`: Creates and sets the properties of the axle's gear box block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.clutch(clutch: Consumer<ClutchBlockBuilder>)`: Creates and sets the properties of the axle's clutch block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.bladedAxle(bladed: Consumer<BladedAxleBlockBuilder>)`: Creates and sets the properties of the axle's bladed axle block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_axle', 'tfc:axle')
        .axleTexture('tfc:block/metal/smooth/wrought_iron')
        .waterWheel(wheel => {
            wheel.texture('tfc:block/metal/smooth/rose_gold')
        })
})
```

### Encased Axles

Creates a new encased axles block

Inherits the methods of the default block builder

**Type**: `tfc:encased_axle`

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_encased_axle', 'tfc:encased_axle')
})
```

### FirmaLife Cheese Wheel

Creates a new cheese wheel block

Inherits the methods of the default block builder

**Type**: `firmalife:cheese_wheel`

#### Extra Method

- `.sliceItem(slice: Consumer<ItemBuilder>)`: Sets the properties of the cheese wheel's slice item

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_cheese_wheel', 'firmalife:cheese_wheel')
})
```

### Extended Properties

Some of TFC's blocks have extended properties which allow the block properties object passed into them to define more of their behavior, builders for these types of blocks have a method with a consumer that allows you to modify some of those properties

- `.flammable(flammability: number, fireSpreadSpeed: number)`: Sets the flammability and fire spread speed of the block
- `.pathType(pathType: BlockPathTypes)`: Sets the block's path type, used by mobs to determine if they may walk over it or not
- `.enchantPower(f: number)`: Sets the block's enchant power
- `.enchantPowerFunction(function: Function<BlockState, Double>)`: Sets the function the block uses to determine its enchant power based on its block state
- `.noCollision()`: Removes the block's collision
- `.noOcclusion()`: Makes the block not occlude blocks behind it
- `.friction(f: number)`: Sets the friction of the block
- `.speedFactor(f: number)`: Sets the speed factor of the block
- `.jumpFactor(f: number)`: Sets the jump factor of the block
- `.sound(sound: SoundType)`: Sets the sound type the block uses
- `.lightLevel(lightLevel: Function<BlockState, number>)`: Sets the light level, in the range [0, 15], of the block, as a function of its state
- `.strength(destroyTime: number, explosionResistance: number)`: Sets the destroy time and explosion resistance of the block
- `.instabreak()`: Makes the block instabreak
- `.strength(f: number)`: Sets the destroy time and explosion resistance of the block
- `.randomTicks()`: Sets the block to random tick
- `.dynamicShape()`: Marks the block as having a dynamic shape
- `.noLootTable()`: Marks the block as having no loot table
- `.dropsLike(block: Supplier<Block>)`: makes the block drop like the supplied block
- `.air()`: Marks the block as being air-like
- `.isValidSpawn(isValidSpawn: BlockBehaviour$StateArgumentPredicate<EntityType<?>>)`: Determines if an entity may spawn on the block
- `.isSuffocating(isSuffocating: BlockBehaviour$StatePredicate)`: Determines if the block is suffocating
- `.isViewBlocking(isBlocking: BlockBehaviour$StatePredicate)`: Determines if the block is view blocking
- `.requiresCorrectToolForDrops()`: Sets the block to require a 'correct' tool (as determined by a tag) for it to drops its loot table
- `.mapColor(color: MapColor)`: Sets the map color of the block
- `.mapColor(color: Function<BlockState, MapColor>)`: Sets the map color of the block per state
- `.destroyTime(f: number)`: Sets the destroy time of the block
- `.explosionResistance(f: number)`: Sets the explosion resistance of the block
- `.ignitedByLava()`: Sets the block to be ignited by lava
- `.forceSolidOn()`: Forces the block to be solid
- `.forceSolidOff()`: Forces the block to be non-solid (?)
- `.pushReaction(reaction: PushReaction)`: Sets the block's reaction to being pushed by pistons
- `.offsetType(type: OffsetType)`: Sets the block's hitbox offset type
- `.noParticlesOnBreak()`: Sets the block to not create any particles when broken
- `.instrument(instrument: NoteBlockInstrument)`: Sets the note block instrument the block has
- `.defaultInstrument()`: Sets the block's not block instrument to be the harp
- `.replaceable()`: Marks the block as being replaceable

## Items

The following types are available:

- [Chisel](#chisel)
- [Fluid Container](#fluid-container)
- [Hammer](#hammer)
- [Javelin](#javelin)
- [Mace](#mace)
- [Mold](#mold)
- [Propick](#propick)
- [Scythe](#scythe)
- [Hoe](#hoe)
- [Tool](#tool)
- [Fishing Rod](#fishing-rod)
- [Jar](#jar)
- [Glassworking](#glassworking)
- [Windmill Blade](#windmill-blade)
- [Glassworking Tool](#glassworking-tool)

<a id="firmalife-items"></a>If [FirmaLife](https://modrinth.com/mod/firmalife) is installed, the following types are also available:

- [Watering Can](#firmalife-watering-can)

<a id="precision-prospecting-items"></a>If [Precision Prospecting](https://modrinth.com/mod/precision-prospecting) is installed, the following types are also available:

- [Prospector's Hammer](#precision-prospecting-prospector-hammer)
- [Prospector's Drill](#precision-prospecting-prospector-drill)
- [Mineral Prospector](#precision-prospecting-mineral-prospector)
- [Custom Prospector](#precision-prospecting-custom-prospector)

Additionally, TFC's [tool](#tool-tiers) and [armor](#armor-tiers) tiers are added to KubeJS's tool and armor tier values

### Chisel

Creates a new chisel item

Inherits the methods of other tool builders

**Type**: `tfc:chisel`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_chisel', 'tfc:chisel')
})
```

### Fluid Container

Creates a new fluid container item

Inherits the methods of the basic item builder

**Type**: `tfc:fluid_container`

<a id="fluid-container-texture-notice"></a>

{: .notice }
> This item requires two textures to function properly
>
> - item/\<name>: The base texture
> - item/\<name> + `_overlay`: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/ceramic/fired_mold/axe_head_overlay.png) for what it should look like
>
> For the example below, the textures would be in `kubejs/textures/item/my_fluid_container.png` and `kubejs/textures/item/my_fluid_container_overlay.png`

#### Extra Methods

- `.canPlaceLiquid(b: boolean)`: Determines if the item can place liquids in world, defaults to `false`
- `.canPlaceLiquidSource(b: boolean)`: Determines if the the item can place source blocks in world, defaults to `false`
- `.capacity(i: number)`: Sets the mB capacity of the item, defaults to `100`
- `.fluidTagAccept(tag: string)`: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_jug`
- `.filledDisplayName(c: Component)`: Accepts a text component, sets the display name when the object has a fluid in it, will be overridden by an entry in a lang file if it exists
- `.capacity(capacity: Supplier<Integer>)`: Sets the mB supplier capacity of the item, defaults to `() => 100`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_fluid_container', 'tfc:fluid_container')
        .fluidTagAccept('kubejs:special_water')
        .capacity(1000)
})
```

### Hammer

Creates a new fluid hammer item

Inherits the methods of other tool item builders

**Type**: `tfc:hammer`

#### Extra Method

- `.metalTexture(texture: string)`: Sets the texture of the hammer when in a trip hammer, this is required if you want the hammer to be usable in a trip hammer

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_electrum_hammer', 'tfc:hammer')
        .metalTexture('kubejs:block/trip_hammers/electrum')
})
```

### Javelin

Creates a new javelin item

Inherits the methods of other tool item builders

**Type**: `tfc:javelin`

#### Extra Methods

- `.thrownDamage(f: number)`: Sets the thrown damage of the javelin, defaults to `0.3`
- `.skeletonWeapon()`: Adds the item to the `tfc:skeleton_weapons` item tag

#### Example

```js
StartupEvents.registry('item', event => [
    event.create('my_javelin', 'tfc:javelin')
        .thrownDamage(5)
        .skeletonWeapon()
])
```

### Mace

Creates a new mace item

Inherits the methods of other tool item builders

**Type**: `tfc:mace`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_mace', 'tfc:mace')
})
```

### Mold

Creates a new mold item

Inherits the methods of the basic item builder

**Type**: `tfc:mold`

<a id="mold-texture-notice"></a>

{: .notice }
> This item requires two textures to function properly
>
> - item/\<name>: The base texture
> - item/\<name> + `_overlay`: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/ceramic/fired_mold/axe_head_overlay.png) for what it should look like
>
> For the example below, the textures would be in `kubejs/textures/item/my_mold.png` and `kubejs/textures/item/my_mold_overlay.png`

#### Extra Methods

- `.capacity(i: number)`: Sets the mB capacity of the mold, defaults to `100`
- `.fluidTagAccept(fluidTag: string)`: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_ingot_mold`
- `.capacity(capacity: Supplier<Integer>)`: Sets the mB capacity supplier of the mold, defaults to `() => 100`

<a id="tfccc"></a>If [TFC Casting with Channels](https://www.curseforge.com/minecraft/mc-mods/tfc-casting-with-channels) is installed, the following method is available

- `.tfcccAllowedInMoldTable(model?: List<string>)`: Allows the mold to be placed in a mold table
    - *Optional 1st parameter*: A list of strings, may be omitted to not automatically generate a model. If present, there should be 14 strings each with 14 characters in them. See one of the [defaults](https://github.com/lJuanGB/TFCCasting/blob/main/src/main/resources/assets/tfcchannelcasting/models/mold/tfc/ceramic/axe_head_mold.json) for an example of how it should look

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_mold', 'tfc:mold')
        .capacity(750)
})
```

### Propick

Creates a new propick item

Inherits the methods of other tool item builders

**Type**: `tfc:propick`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_propick', 'tfc:propick')
})
```

### Scythe

Creates a new scythe item

Inherits the methods of other tool item builders

**Type**: `tfc:scythe`

#### Extra Method

- `.mineableBlocksTag(blockTag: string)`: Sets the block tag that the scythe can properly dig at full speed, defaults to `tfc:mineable_with_scythe`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_scythe', 'tfc:scythe')
})
```

### Hoe

Creates a new TFC hoe item

Inherits the methods of other tool item builders

**Type**: `tfc:hoe`

#### Example

```js
startupEvents.registry('item', event => {
    event.create('my_hoe', 'tfc:hoe')
})
```

### Tool

Creates a new 'tool' item

Inherits the methods of other tool item builders

**Type**: `tfc:tool`

#### Extra methods

- `.mineableBlocksTag(blockTag: string)`: Sets the block tag that the 'tool' can properly dig at full speed, defaults to `tfc:mineable_with_knife`
- `.knife()`: Adds the item to the `tfc:knives` tag and sets its mineable blocks tag to `tfc:mineable_with_knife`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_tool', 'tfc:tool')
})
```

### Fishing Rod

Creates a new fishing rod item

Inherits the methods of other tool item builders

**Type**: `tfc:fishing_rod`

#### Extra Methods

- `.fishingStrength(f: number)`: Sets the fishing strength of the rod, defaults to a value based on the tool's tier
- `.castModel(model: string)`: Sets the model used when the rod is cast, if not set a default one will be created which will use a texture with the same path as the normal texture with `_cast` appended to the end
- `.smallBait()`: Adds the rod to the correct tag to allow it to hold small bait
- `.largeBait()`: Adds the rod to the correct tag to allow it to hold large bait

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_fishing_rod', 'tfc:fishing_rod')
        .fishingStrength(4)
        .largeBait()
})
```

### Jar

Creates a new jar item

Inherits the methods of the default item builder

**Type**: `tfc:jar`

#### Extra Method

- `.placedModel(model: string)`: Sets the model of the jar when placed, defaults to the item's id

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_jar', 'tfc:jar')
        .placedModel('kubejs:block/placed_jar')
})
```

### Glassworking

Creates a new glassworking item

Inherits the methods of the default item builder

**Type**: `tfc:glassworking`

#### Extra Method

- `.operation(operation: GlassOperation)`: Sets the `GlassOperation` the item is capable of performing, defaults to `saw`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_glass_cutter', 'tfc:glassworking')
        .operation('pinch')
})
```

### Windmill Blade

Creates a new windmill blade item

Inherits the methods of the default item builder

**Type**: `tfc:windmill_blade`

#### Extra Methods

- `.bladeColor(color: Color)`: Sets the color of the blade, defaults to `0x000000`
- `.bladeTexture(texture: string)`: Sets the texture of the windmill blade, defaults to `tfc:textures/entity/misc/windmill_blade.png`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_windmill_blade', 'tfc:windmill_blade')
        .bladeColor(0x545f97)
})
```

### Glassworking Tool

Creates a new glassworking tool

Inherits the methods of the [tool item builder](#tool)

**Type**: `tfc:glassworking_tool`

#### Extra method

- `.operation(operation: GlassOperation)`: Sets the `GlassOperation` the item is capable of performing, defaults to `saw`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_glass_working_tool', 'tfc:glassworking_tool')
        .operation('pinch')
        .mineableBlocksTag('kubejs:mineable/default')
})
```

### FirmaLife Watering Can

Creates a new watering can item

Inherits the methods of the default item builder

**Type**: `firmalife:watering_can`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_watering_can', 'firmalife:watering_can')
})
```

### Precision Prospecting Prospector Hammer

Creates a new prospector's hammer item

Inherits the methods of other tool item builders

**Type**: `precpros:hammer`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_prospector_hammer', 'precpros:hammer')
})
```

### Precision Prospecting Prospector Drill

Creates a new prospector's drill item

Inherits the methods of other tool item builders

**Type**: `precpros:drill`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_prospector_drill', 'precpros:drill')
})
```

### Precision Prospecting Mineral Prospector

Creates a new mineral prospector item

Inherits the methods of other tool item builders

**Type**: `precpros:mineral`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_mineral_prospector', 'precpros:mineral')
})
```

### Precision Prospecting Custom Prospector

Creates a new custom prospector item

Inherits the methods of other tool items

**Type**: `precpros:custom`

#### Extra Methods

- `.cooldown(i: number)`: Sets the cooldown, in ticks, the item gets when it prospects, defaults to `20`
- `.primaryRadius(i: number)`: Sets the primary radius of the prospector, defaults to `10`
- `.primaryRadius(supplier: Supplier<Integer>)`: Sets the integer supplier that defines the item's primary radius, defaults to `() => 10`
- `.secondaryRadius(i: number)`: Sets the secondary radius of the prospector, defaults to `10`
- `.secondaryRadius(supplier: Supplier<Integer>)`: Sets the integer supplier that defines the item's secondary radius, defaults to `() => 10`
- `.displacement(i: number)`: Sets the displacement of the prospector, defaults to `0`
- `.displacement(supplier: Supplier<Integer>)`: Sets the integer supplier that defines the item's displacement, defaults to `() => 0`
- `.prospectTag(blockTag: string)`: Sets the block tag that the item can prospect, defaults to `tfc:prospectable`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_clay_prospector', 'precpros:custom')
        .prospectTag('kubejs:clay')
})
```

### Tool Tiers

KubeJS TFC adds TFC's tool tiers to KubeJS's predefined tier list

- `igneous_intrusive`
- `igneous_extrusive`
- `sedimentary`
- `metamorphic`
- `copper`
- `bronze`
- `bismuth_bronze`
- `black_bronze`
- `wrought_iron`
- `steel`
- `black_steel`
- `blue_steel`
- `red_steel`

### Armor Tiers

KubeJS TFC adds TFC's armor tiers to KubeJS's predefined tier list

- `copper`
- `bismuth_bronze`
- `black_bronze`
- `bronze`
- `wrought_iron`
- `steel`
- `black_steel`
- `blue_steel`
- `red_steel`

## Fluids

The following types are available:

- [Spring](#spring)

### Spring

Creates a new spring-like fluid

Inherits the methods of the basic fluid builder

**Type**: `tfc:spring`

#### Extra Methods

- `.bubbleParticle(particle: string)`: Accepts a string, the registry name of a particle, sets the bubble particle of the liquid block, defaults to `minecraft:bubble`[^1]
- `.steamParticle(particle: string)`: Accepts a string, the registry name of a particle, sets the steam particle of the liquid block, defaults to `tfc:steam`[^1]
- `.healingAmount(f: number)`: Sets the amount of health an entity gets while standing in the fluid, defaults to `0.08`
- `.hasBubbles(b: boolean)`: Determines if the liquid emits bubble particles, defaults to `true`
- `.hasSteam(b: boolean)`: Determines if the liquid emits steam particles, defaults to `true`

[^1]: A full list of all particle types can be attained by running the command `/kubejs dump_registry minecraft:particle_type` in-game

#### Example

```js
StartupEvents.registry('fluid', event => {
    event.create('my_cool_fluid', 'tfc:spring')
        .steamParticle('minecraft:lava_drip_particle')
})
```

## Attachments

In 1.20.1, KubeJS added the ability to add block entity attachments to its basic blocks, KubeJS TFC adds an attachment that can be used in scripts

- [Inventory](#inventory)

### Inventory

Adds a new inventory attachment that can have its contents restricted based on TFC's size and weight values

**Type**: `tfc:inventory`

#### Definition

- `width`: A number, determines how wide the container is, identical to KubeJS's default inventory width. Required
- `height`: A number, determines how tall the container is, identical to KubeJS's default inventory height. Required
- `inputFilter`: An ingredient, a filter for what items are allowed into the container, identical to KubeJS's default inventory inputFilter. Optional
- `size`: A `Predicate<Size>`, a filter for what size of items are allowed into the container. Optional
- `weight`: A `Predicate<Weight>`, a filter for what weight of items are allowed into the container. Optional

#### Example

```js
StartupEvents.registry('block', event => {
    event.register('inventory_example')
        .blockEntity(be => {
            be.attach('tfc:inventory', {
                width: 9,
                height: 1,
                size: size => size.isSmallerThan('large') // Limits the inventory to sizes smaller than large
            })
            be.rightClickOpensInventory() // Required if you wish to have the inventory open on right click
        })
})
```
