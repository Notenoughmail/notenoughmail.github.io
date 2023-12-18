---
layout: page
title: Custom Blocks, Items, and Fluids
permalink: /kubejs_tfc/1.20.1/custom/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Custom Blocks, Items, and Fluids

{: .notice }
Work in progress!

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

### Aqueduct

Creates a new aqueduct block

Inherits the methods of the default block builder

**Type**: `tfc:aqueduct`

#### Example

```js
StartupEvents.registry('block', event => {
    event.register('my_aqueduct', 'tfc:aqueduct')
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
    event.register('my_placed_ore', 'tfc:ground_cover').ore()
})
```

### Loose Rock

This creates a new loose rock block

Inherits the methods of the default block builder

**Type**: `tfc:loose_rock`

#### Extra Methods

- `.rotateModel(i: number)`: Rotates the placed models by the given amount of degrees
- `.collision()`: Enables collision for the block
- `.itemTexture(texture: string)`: Sets the item's `layer0` texture
- `.itemTexture(key: string, texture: string)`: Sets the item's texture for the given key
- `.itemTextureJson(json: JsonObject)`: Sets the json for the item model

#### Example

```js
StartupEvents.registry('block', event => {
    event.register('my_loose_rock', 'tfc:loose_rock')
})
```

### Raw Rock

This creates a new raw rock block

Inherits the methods of the default block builder

**Type**: `tfc:raw_rock`

#### Extra Methods

- `.naturallySupported(supported: boolean)`: Determines if the block is considered to be naturally supported for the purposes of spawning particles indicating unsupported regions
- `.rockTypeTooltip(component: Component)`: Sets the tooltip component indicating the block's rock type

#### Example

```js
StartupEvents.registry('block', event => {
    event.register('my_raw_block', 'tfc:raw_rock').rockTypeTooltip(Text.translatable('tooltip.kubejs.space_rock'))
})
```

### Rock Spike

Creates a rock spike block

Inherits the methods of the default block builder

**Type**: `tfc:rock_spike`

#### Example

```js
StartupEvents.registry('block', event => {
    event.register('my_rock_spike', 'tfc:rock_spike')
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
    event.register('my_lava_spike', 'tfc:thin_spike').meltFluid('minecraft:lava').meltTemp(50)
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
    event.register('my_moss_spreading_block', 'tfc:moss_spreading_block')
    event.register('my_moss_spreading_stair', 'tfc:moss_spreading_stair')
    event.register('my_moss_spreading_slab', 'tfc:moss_spreading_slab')
    event.register('my_moss_spreading_wall', 'tfc:moss_spreading_wall')
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
    event.register('my_moss_growing_block', 'tfc:moss_growing_block').mossyBlock('kubejs:my_moss_spreading_block')
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
    event.register('my_moss_growing_block', 'tfc:moss_growing_block').mossyStair('kubejs:my_moss_spreading_stair')
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
    event.register('my_moss_growing_slab', 'tfc:moss_growing_slab').mossySlab('kubejs:my_moss_spreading_slab')
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
    event.register('my_moss_growing_wall', 'tfc:moss_growing_wall').mossyWall('kubejs:my_moss_spreading_wall')
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

Additionally, TFC's [tool](#tool-tiers) and [armor](#armor-tiers) tiers are added to KubeJS' tool and armor tier values

### Chisel

Creates a new chisel item

Inherits the methods of other tool builders

**Type**: `tfc:chisel`

#### Example

```js
StartupEvents.registry('item', event => {
    event.register('my_chisel', 'tfc:chisel')
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

#### Example

```js
StartupEvents.registry('item', event => {
    event.register('my_fluid_container', 'tfc:fluid_container').fluidTagAccept('kubejs:special_water').capacity(1000)
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
    event.register('my_electrum_hammer', 'tfc:hammer').metalTexture('kubejs:block/trip_hammers/electrum')
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
    event.register('my_javelin', 'tfc:javelin').thrownDamage(5).skeletonWeapon()
])
```

### Mace

Creates a new mace item

Inherits the methods of other tool item builders

**Type**: `tfc:mace`

#### Example

```js
StartupEvents.registry('item', event => {
    event.register('my_mace', 'tfc:mace')
})
```

### Mold

Creates a new mold item

Inherits the methods of the basic item builder

**Type**: `tfc:mold`

#### Extra Methods

- `.capacity(i: number)`: Sets the capacity of the mold, defaults to `100`
- `.fluidTagAccept(fluidTag: string)`: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_ingot_mold`

#### Example

```js
StartupEvents.registry('item', event => {
    event.register('my_mold', 'tfc:mold').capacity(750)
})
```

### Propick

Creates a new propick item

Inherits the methods of other tool item builders

**Type**: `tfc:propick`

#### Example

```js
StartupEvents.registry('item', event => {
    event.register('my_propick', 'tfc:propick')
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
    event.register('my_scythe', 'tfc:scythe')
})
```

### Hoe

Creates a new TFC hoe item

Inherits the methods of other tool item builders

**Type**: `tfc:hoe`

#### Example

```js
startupEvents.registry('item', event => {
    event.register('my_hoe', 'tfc:hoe')
})
```

### Tool

Creates a new 'tool' item

Inherits the methods of other tool item builders

**Type**: `tfc:tool`

#### Extra method

- `.mineableBlocksTag(blockTag: string)`: Sets the block tag that the 'tool' can properly dig at full speed, defaults to `tfc:mineable_with_knife`

#### Example

```js
StartupEvents.registry('item', event => {
    event.register('my_tool', 'tfc:tool')
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
    event.register('my_cool_fluid', 'tfc:spring').steamParticle('minecraft:lava_drip_particle')
})
```

