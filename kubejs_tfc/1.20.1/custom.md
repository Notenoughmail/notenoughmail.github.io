---
layout: page
title: Custom Blocks, Items, and Fluids
permalink: /kubejs_tfc/1.20.1/custom/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Custom Blocks, Items, and Fluids

KubeJS TFC allows you to create some of TFC's [block](#blocks), [item](#items), and [fluid](#fluids) types

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

If [FirmaLife](https://modrinth.com/mod/firmalife) is installed, the following types are also available:

- [Cheese Wheel](#firmalife-cheese-wheel)

### Aqueduct

Creates a new aqueduct block

Inherits the methods of the default block builder

**Type**: `tfc:aqueduct`

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

Inherits the methods of tje default block builder

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

- `.grass(grass: Consumer<ConnectedGrassBlockBuilder>)`: Sets the properties of the dirt block's grass block. Has the same id as the dirt block but with `_grass` appended to the end. Has the same methods as the default block builder
- `.path(path: Consumer<TFCPathBlockBuilder>)`: Creates and sets the properties of the dirt block's path bloc. Has the same id as the dirt block but with `_path` appended to the end. Has the same methods as the default block builder
- `.farmland(farmland: Consumer<TFCFarmlandBlockBuilder>)`: Creates and sets the properties of the dirt block's farmland block. Has the same id as the dirt block but with `_farmland` appended to the end. Has the following methods:
    - Those of the default block builder
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.rooted(rooted: Consumer<TFCRootedDirtBlockBuilder>)`: Creates and sets the properties of the dirt block's rooted dirt block. Has the same id as the dirt block but with `_rooted` appended to the end. Has the same methods as the default block builder

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

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_wild_spreading_crop', 'tfc:wild_crop')
        .type('spreading')
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
- `.nutrient(nutrient: NutrientType)`: Sets the nutrient hte crop consumes, available options are `nitrogen`, `phosphorous` , and `potassium`, defaults to `nitrogen`

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
- `.pathType(pathType: BlockPathTypes)`: Sets the block's pathing type, used by mobs to determine if they may walk over it or not
- `.enchantPower(f: number)`: Sets the block's enchant power
- `.enchantPowerFunction(function: Function<BlockState, Double>)`: Sets the function the block uses to determine its enchant power based on its block state

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

If [FirmaLife](https://modrinth.com/mod/firmalife) is installed, the following types are also available:

- [Watering Can](#firmalife-watering-can)

If [Precision Prospecting](https://modrinth.com/mod/precision-prospecting) is installed, the following types are also available:

- [Prospector's Hammer](#precision-prospecting-prospector-hammer)
- [Prospector's Drill](#precision-prospecting-prospector-drill)
- [Mineral Prospector](#precision-prospecting-mineral-prospector)
- [Custom Prospector](#precision-prospecting-custom-prospector)

Additionally, TFC's [tool](#tool-tiers) and [armor](#armor-tiers) tiers are added to KubeJS' tool and armor tier values

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

#### Extra Methods

- `.canPlaceLiquid(b: boolean)`: Determines if the item can place liquids in world, defaults to `false`
- `.canPlaceLiquidSource(b: boolean)`: Determines if the the item can place source blocks in world, defaults to `false`
- `.capacity(i: number)`: Sets the mB capacity of the item, defaults to `100`
- `.fluidTagAccept(tag: string)`: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_jug`
- `.filledDisplayName(c: COmponent)`: Accepts a text component, sets the display name when the object has a fluid in it, will be overridden by an entry in a lang file if it exists
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

#### Extra Methods

- `.capacity(i: number)`: Sets the mB capacity of the mold, defaults to `100`
- `.fluidTagAccept(fluidTag: string)`: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_ingot_mold`
- `.capacity(capacity: Supplier<Integer>)`: Sets the mB capacity supplier of the mold, defaults to `() => 100`

If [TFC Casting with Channels](https://www.curseforge.com/minecraft/mc-mods/tfc-casting-with-channels) is installed, the following method is available

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

KubeJS TFC adds TFC's tool tiers to KubeJS' predefined tier list

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

KubeJS TFC adds TFC's armor tiers to KubeJS' predefined tier list

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
