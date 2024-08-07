---
layout: page
title: Custom Items and Blocks
permalink: /kubejs_tfc/1.18.2/items-and-blocks/
parent: 1.18.2
grand_parent: KubeJS TFC
---

# Custom Items and Blocks

KubeJS TFC provides the ability to make your own version of some of TFC's items and blocks

[Jump to items](#custom-items)

[Jump to blocks](#custom-blocks)

[Jump to tool/armor tiers](#added-tiers)

[Jump to fluids](#fluids)

## Custom Items

- [Mold](#mold)
- [Chisel](#chisel)
- [Mace](#mace)
- [Propick](#propick)
- [Scythe](#scythe)
- [Hoe](#hoe)
- [Javelin](#javelin)
- [Fluid Container](#fluid-container)
- [Tool](#tool)

##### New Method

KubeJS TFC also adds the `.useTFCDamageCalculation()` method to all tools, this makes it so the tier's attack damage bonus is [multiplicative](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.18.x/src/main/java/net/dries007/tfc/common/items/ToolItem.java#L26-L30) instead of additive. Use this after all other methods

### Mold

Creates a new mold item.

This item requires two textures to function properly

- item/`name`: This is the base texture
- item/`name` + _overlay: This is the overlay texture, it defines where the contained fluid will be shown on the item's sprite

For the example below, the textures would be:

- kubejs/textures/item/my_mold.png
- kubejs/textures/item/my_mold_overlay.png

#### Example

```js
event.create('my_mold', 'tfc:mold')
```

#### Extra Methods

- `.capacity(integer)`: Accepts an integer, sets the capacity, in mB, of the mold. Defaults to 100
- `.fluidTagAccept(string)`: Accepts a string, determines which fluids are allowed in the mold. Defaults to `tfc:usable_in_ingot_mold`
- `.allowedInMoldTable()`: Allows the mold to be put into [Casting with Channels](https://www.curseforge.com/minecraft/mc-mods/tfc-casting-with-channels)' mold tables if the mod is installed. The model for the mold is not made automatically, but its path is `kubejs_tfc/models/item/` + the path of the regular mold

### Chisel

Creates a new chisel item

**Note:** These will still need to be added to the `tfc:chisels` item tag

The chisel is a tiered item, so all the properties which apply to swords, axes, etc. apply

#### Example

```js
event.create('my_chisel', 'tfc:chisel')
```

### Mace

Creates a new mace item

The mace is a tiered item, so all the properties which apply to swords, axes, etc. apply

#### Example

```js
event.create('my_mace', 'tfc:mace')
```

### Propick

Creates a new propick item

The propick is a tiered item, so all the properties which apply to swords, axes, etc. apply

*Want a little more customization in your propick? Allow me to shill my other mod, [Precision Prospecting](https://www.curseforge.com/minecraft/mc-mods/precision-prospecting), and its [KubeJS integration](https://notenoughmail.github.io/precpros/1.18.2/kube/)*

#### Example

```js
event.create('my_propick', 'tfc:propick')
```

### Scythe

Creates a new scythe item

The scythe is a tiered item, so all the properties which apply to swords, axes, etc. apply

#### Example

```js
event.create('my_scythe', 'tfc:scythe')
```

#### Extra Method

- `.mineableBlocksTag(string)`: Determines which blocks the scythe breaks best. Defaults to `tfc:mineable_with_scythe`

### Hoe

Creates a new TFC hoe item

The hoe is a tiered item, so all the properties which apply to swords, axes, etc. apply

**Note:** while vanilla KubeJS does have a hoe builder, TFC has a unique hoe, which uses TFC's own durability check on, thus it's provided and recommended to use this for any custom hoes

#### Example

```js
event.create('my_hoe', 'tfc:hoe')
```

### Javelin

This creates a new javelin item

The javelin is a tiered item, so all the properties which apply to swords, axes, etc. apply

This item requires two textures to function properly

- item/`name`: This is the textured used in hand
- entity/projectiles/`name` + _javelin: The texture of the javelin entity created when this javelin is throw

For the example below the textures would be

- kubejs/textures/item/my_javelin.png
- kubejs/textures/entity/projectiles/my_javelin_javelin.png

#### Example

```js
event.create('my_javelin', 'tfc:javelin')
```

### Fluid Container

This creates a new fluid container item.

This item requires two textures to function properly

- item/`name`: This is the base texture
- item/`name` + _overlay: This is the overlay texture, it defines where the contained fluid will be shown on the item's sprite

For the example below the textures would be

- kubejs/textures/item/my_container.png
- kubejs/textures/item/my_container_overlay.png

#### Example

```js
event.create('my_container', 'tfc:fluid_container')
```

#### Extra Methods

- `.capacity(integer)`: Accepts an integer, sets the capacity, in mB, of the item. Defaults to 100
- `.canPlaceLiquid(boolean)`: Accepts a boolean, determines if the item can place liquids in the world. Defaults to false
- `.canPlaceLiquidSource(boolean)`: Accepts a boolean, determines if the item can place liquid source blocks in the world. Defaults to false
- `.fluidTagAccept(string)`: Accepts a string, determines which fluids are allowed in the item. Defaults to `tfc:usable_in_jug`
- `.filledDisplayName(string)`: Accepts a string, sets the display name of the item's filled state. Defaults to `%s ` + the default filled name
    - **Note**: the `%s` represents where in the name the contained fluid should appear. In the above example the default would give 'Whiskey My Container', but putting `My %s Container` in this method would give 'My Whiskey Container'

### Tool

This create a new tool item

It is functionally the same as a shovel/pick/axe but takes damage when breaking TFC plants

This is a tiered item, so all the methods that apply to shovels/picks/axes apply as well

#### Example

```js
event.create('my_tool', 'tfc:tool').knife()
```

#### Extra Methods

- `.mineableBlocksTag(string)`: Determines which blocks the tool breaks best. Defaults to `tfc:mineable_with_knife`
- `.knife()`: Equivalent to `.mineableBlocksTag('tfc:mineable_with_knife').tag('tfc:knives')`
- `.hammer()`: Equivalent to `.mineableBlocksTag('tfc:mineable_with_hammer').tag('tfc:hammers')`

## Custom Blocks

- [Aqueduct](#aqueduct)
- [Loose Rock](#loose-rock)
- [Ground Cover](#ground-cover)
- [Rock Spike](#rock-spike)
- [Thin Spike](#thin-spike)
- [Moss Spreading Blocks](#moss-spreading-blocks)
- [Moss Growing Blocks](#moss-growing-blocks)
- [Raw Rocks](#raw-rocks)

### Aqueduct

This creates a new aqueduct block

This inherits the methods of the default block

#### Example

```js
event.create('my_aqueduct', 'tfc:aqueduct')
```

### Loose Rock

This creates a new loose rock block with three states which can be changed by clicking the block with its item

#### Extra Methods

- `.notAxisAligned()`: Rotates all the placed models by 45 degrees
- `.collision()`: Enables collision for the block

This also inherits the methods of the default block builder

#### Example

```js
event.create('my_loose_rock', 'tfc:loose_rock')
```

### Ground Cover

This creates a new ground cover block

#### Extra Methods

- `.ore()`: Sets the collision shape to that of TFC's ores
- `.twig()`: Sets the collision shape to that of TFC's twigs and makes the block flammable
- `.groundCoverModel(string)`: Sets the default model shape, defaults to 'boulder'. A list of available options:
    - 'bismuthinite',
    - 'bone',
    - 'boulder',
    - 'cassiterite',
    - 'clam',
    - 'dead_grass',
    - 'driftwood',
    - 'feather',
    - 'flat',
    - 'flint',
    - 'ganerite',
    - 'hematite',
    - 'limonite',
    - 'magnetite',
    - 'malachite',
    - 'mollusk',
    - 'mussel',
    - 'native_copper',
    - 'native_gold',
    - 'native_silver',
    - 'pebble',
    - 'pinecone',
    - 'rotten_flesh',
    - 'rubble',
    - 'seaweed',
    - 'sphalerite',
    - 'stick',
    - 'tetrahedrite',
    - 'twig', and
    - anything added to [kubejs_tfc/models/block/groundcover](https://github.com/Notenoughmail/KubeJS-TFC/tree/1.18.2/src/main/resources/assets/kubejs_tfc/models/block/groundcover)
- `.notAxisAligned()`: Rotates all the placed models by 45 degrees
- `.collision()`: Enables collision for the block

This also inherits the methods of the default block builder

#### Example

```js
event.create('my_ore_ground_cover', 'tfc:groundcover').ore().groundCoverModel('pebble').notAxisAligned()
```

### Rock Spike

This creates a new rock spike block builder

#### Extra Methods

- `.allowCycling()`: Allows the player to change the state of the block with an empty hand
- `.cycleItem(string)`: Allows the player to toggle the state of the block with the specified item in hand
- `.cycleTag(string)`: Allows the player to toggle the state of the block with the specified item tag in hand
- `.dontUpdateWhenCycling()`: Makes it so block updates aren't emitted when the player changes the state.
    - **Note: There may be unexpected issues regarding blocks randomly updating if this is used. This is available as cycling a rock spike to a smaller size would case the one above it to pop off. Observers still detect the player changing the state.**
- `.middleBox(number, number, number, number, number, number, boolean)`: The same as the default `.box(number, number, number, number, number. number, boolean)` but applies to the middle state
- `.middleBox(number, number, number, number, number, number)`: The same as the default `.box(number, number, number, number, number, number)` but applies to the middle state
- `.tipBox(number, number, number, number, number, number, boolean)`: The same as the default `.box(number, number, number, number, number. number, boolean)` but applies to the tip state
- `.tipBox(number, number, number, number, number, number)`: The same as the default `.box(number, number, number, number, number, number)` but applies to the tip state

This also inherits the methods of the default block builder

#### Example

```js
event.create('my_rock_spike', 'tfc:rock_spike').cycleItem('minecraft:stick')
```

### Thin Spike

This creates a new thin spike block

#### Extra Methods

- `.drips()`: Makes it so the block will drip
- `.dripChance(number)`: Sets the chance the block will drip each tick, defaults to 0.15
- `.dripTemp(number)`: Sets the temperature which the environment must be above for the block to drip, defaults to 0
- `.melts()`: Makes it so the block will melt, also makes it so the block random ticks
- `.meltChance(number)`: Sets the chance the block will melt each random tick
- `.meltTemp(number)`: Sets the temperature which the environment must be for the block to be able to melt, defaults to 4
- `.dripParticle(string)`: Sets the particle which will drip from the block, defaults to 'minecraft:dripping_dripstone_water'
- `.meltFluid(FluidStackJS)`: Sets the fluid stack which will be inserted into a fluid capable block below the block when it melts, defaults to 100mB of water
- `.tipModel(string)`: Sets the model which the tip state will use
- `.tipBox(number, number, number, number, number, number, boolean)`: The same as the default `.box(number, number, number, number, number. number, boolean)` but applies to the tip state
- `.tipBox(number, number, number, number, number, number)`: The same as the default `.box(number, number, number, number, number, number)` but applies to the tip state

This also inherits the methods of the default block builder

#### Example

```js
event.create('my_lava_spike', 'tfc:thin_spike').drips().dripTemp(-30).dripChance(0.5).dripParticle("falling_dripstone_lava").melts().meltFluid(Fluid.lava()).meltChance(0.24)
```

### Moss Spreading Blocks

TFC has blocks which can spread moss to moss [growing](#moss-growing-blocks) blocks

There are four types of moss spreading blocks: full block, stair, slab, and wall

These are effected by TFC's mossy spreading configs

#### Examples

```js
event.create('my_moss_spreading_block', 'tfc:moss_spreading_block')
event.create('my_moss_spreading_stair', 'tfc:moss_spreading_stair')
event.create('my_moss_spreading_slab', 'tfc:moss_spreading_slab')
event.create('my_moss_spreading_wall', 'tfc:moss_spreading_wall')
```

### Moss Growing Blocks

TFC has blocks which can have moss spread onto them from moss [spreading](#moss-spreading-blocks) blocks

There are four type of moss spreading blocks: full block, stair, slab, and wall

**Note**: The ☕ Emoji indicate a reference to a Java class, see [KubeJS's Java Reflection](https://wiki.latvian.dev/books/kubejs-legacy/page/reflection-java-access) page

#### Full block

This has two methods

- `.mossyBlock(string)`: Accepts a string, sets the block this block will convert to when 'mossed'
- `.mossyConversion(callback)`: Accepts a [Moss Growing Callback](#moss-growing-callback), sets the callback used when trying to convert to the mossy block
    - Defaults to `(container, needsWater) => (!needsWater || ☕FluidHelpers.isSame(container.minecraftLevel.getFluidState(container.pos.above()), ☕Fluids.WATER))`

##### Example

```js
event.create('my_moss_growing_block', 'tfc:moss_growing_block').mossBlock('kubejs:my_moss_spreading_block')
```

#### Stair

This has two methods

- `.mossyStair(string)`: Accetps a string, sets the block this block will convert to when 'mossed'. Defaults to oak stairs
    - **Note**: The provided block *must* be a stair block
- `.mossyConversion(callback)`: Accepts a [Moss Growing Callback](#moss-growing-callback), sets the callback used when trying to convert to the mossy block
    - Defaults to `(container, needsWater) => (!needsWater || ☕FluidHelpers.isSame(container.minecraftLevel.getFluidState(container.pos), ☕Fluids.WATER))`

##### Example

```js
event.create('my_moss_growing_stair', 'tfc:moss_growing_stair').mossyStair('kubejs:my_moss_spreading_stair')
```

#### Slab

This has four methods

- `.mossySlab(string)`: Accepts a string, sets the block this block will convert to when 'mossed', Defaults to oak slabs
    - **Note**: The provided block *must* be a slab block
- `.mossyConversionFull(callback)`: Accepts a [Moss Growing Callback](#moss-growing-callback), sets the callback used when trying to convert to the mossy block when in the 'double' state
    - Defaults to `(container, needsWater) => (!needsWater || ☕FluidHelpers.isSame(container.minecraftLevel.getFluidState(container.pos.above()), ☕Fluids.WATER))`
- `.mossyConversionHalf(callback)`: Accepts a [Moss Growing Callback](#moss-growing-callback), sets the callback used when trying to convert to the mossy block when in the 'top' or 'bottom' state
    - Defaults to `(container, needsWater) => (!needsWater || ☕FluidHelpers.isSame(container.minecraftLevel.getFluidState(container.pos), ☕Fluids.WATER))`
- `.mossyConversion(callback)`: Accepts a [Moss Growing Callback](#moss-growing-callback), sets the callback used when trying to convert to the mossy block when in the 'top', 'bottom', or 'double' state

##### Example

```js
event.create('my_moss_growing_slab', 'tfc:moss_growing_slab').mossySlab('kubejs:my_moss_spreading_slab')
```

#### Wall

This has two methods

- `.mossyWall(string)`: Accepts a string, sets the block this block will convert to when 'mossed', Defaults to cobblestone walls
    - **Note**: The provided block *must* be a wall block
- `.mossyConversion(callback)`: Accepts a [Moss Growing Callback](#moss-growing-callback), sets the callback used when trying to convert to the mossy block
    - Defaults to `(container, needsWater) -> (!needsWater || ☕FluidHelpers.isSame(container.minecraftLevel.getFluidState(container.pos), ☕Fluids.WATER))`

##### Example

```js
event.create('my_moss_growing_wall', 'tfc:moss_growing_wall').mossyWall('kubejs:my_moss_spreading_wall')
```

#### Moss Growing Callback

This is used when determining if a block should convert to its mossy variant and returns a boolean which determines if the block should convert

You are given two variables: a block container, and a boolean which is always true (in default TFC) called 'needsWater'

[ProbeJS](https://www.curseforge.com/minecraft/mc-mods/probejs) is strongly encouraged when using this

##### Examples

```js
// Returns true if the block's y value is greater than 60
(container, needsWater) => {
    return container.pos.y > 60;
}
// Returns true if it is night
(container, needsWater) => {
    return container.minecraftLevel.isNight();
}
// Returns true if the block is not receiving a redstone signal
(container, needsWater) => {
    return container.minecraftLevel.getBestNeighborSignal(container.pos) == 0;
}
```

### Raw Rocks

This is a simple block which emits gravel-like particles when not supported and the `naturallySupported` property is false. TFC uses this for its raw and hardened stones

#### Extra Method

- `.naturallySupported(boolean)`: Sets the `naturallySupported` property, defaults to false

#### Examples

```js
event.create('my_raw_rock', 'tfc:raw_rock')
event.create('my_hardened_rock', 'tfc:raw_rock').naturallySupported(true)
```

## Added Tiers

KubeJS TFC also adds predefined tool and armor tiers for your use

### Tool Tiers

- igneous_intrusive
- igneous_extrusive
- sedimentary
- metamorphic
- copper
- bronze
- bismuth_bronze
- black_bronze
- wrought_iron
- steel
- black_steel
- blue_steel
- red_steel

### Armor Tiers

- copper
- bismuth_bronze
- black_bronze
- bronze
- wrought_iron
- steel
- black_steel
- blue_steel
- red_steel

## Fluids

KubeJS TFC adds a couple of methods to liquid builders relating to their in-world LiquidBlock

- `hotWaterBlock()`: Sets the fluid builder's fluid block to a HotWaterBlock, the fluid block used for spring water
- `bubbleParticle(string)`: Accepts a string representing the registry location of a particle, sets the 'bubble' particle of the liquid's block, defaults to `minecraft:bubble`
- `steamParticle(string)`: Accepts a string representing the registry location of a particle, sets the 'steam particle' of the liquid's block, defaults to `tfc:steam`
- `setHealAmount(number)`: Accepts a number, sets the amount of half hearts the living entity is healed by when in the liquid, defaults to `0.08`
- `noBubbles()`: Makes it so the liquid block doesn't give off 'bubble' particles
- `noSteam()`: Makes it so the liquid block doesn't give off 'steam' particles

### Example

```js
// Makes a new fluid that heals entities in it at around twice as quick as vanilla spring water
onEvent('fluid.registry', event => {
     event.create('my_healing_fluid').hotWaterBlock().setHealAmount(0.15)
})
```
