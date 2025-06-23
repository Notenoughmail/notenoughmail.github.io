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
- [Log](#log)
- [Torch](#torch)

<a id="firmalife-blocks"></a>If [FirmaLife](https://modrinth.com/mod/firmalife) is installed, the following types are also available:

- [Cheese Wheel](#firmalife-cheese-wheel)

### Aqueduct

Creates a new aqueduct block

Inherits the methods of the default block builder

**Type**: `tfc:aqueduct`

#### Extra Method

- `.allowedFluids(fluids: String[])`{: .language-javascript }: Sets the fluids that the aqueduct may hold
    - `fluids`: The registry names of fluids the aqueduct can hold. Two liquids with different namespaces but same paths will not be accepted, `minecraft:empty` will automatically be added
- `models(models: BiConsumer<AqueductModelPart, ModelGenerator>)`{: .language-javascript }: Sets the model generation of the aqueduct. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following methods:
    - `.base()`{: .language-javascript }: A boolean. If the model part in operation is for the base
    - `.north()`{: .language-javascript }: A boolean. If the model part in operation is the north part
    - `.south()`{: .language-javascript }: A boolean. If the model part in operation is the south part
    - `.east()`{: .language-javascript }: A boolean. If the model part in operation is the east part
    - `.west()`{: .language-javascript }: A boolean. If the model part in operation is the west part

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_aqueduct', 'tfc:aqueduct')
        .models((type, m) => {
            if (type.north() || type.south()) {
                m.texture("texture", "minecraft:block/cobbled_deepslate");
            }
        })
})
```

### Ground Cover

Creates a new ground cover block

Inherits the methods of the default block builder

**Type**: `tfc:ground_cover`

#### Extra Methods

- `.ore()`{: .language-javascript }: Sets the collision shape to that of TFC's ores
- `.twig()`{: .language-javascript }: Sets the collision shape to that of TFC's twigs and makes the block flammable
- `.groundCoverModel(model: String)`{: .language-javascript }: Sets the default parent model, defaults to `loose/igneous_intrusive_2`
    - This accepts anything added to [kubejs_tfc/models/block/ground_cover/](https://github.com/Notenoughmail/KubeJS-TFC/tree/1.20.1/src/main/resources/assets/kubejs_tfc/models/block/ground_cover)
- `.notAxisAligned()`{: .language-javascript }: Rotates placed models by 45 degrees
- `.collision()`{: .language-javascript }: Enables collision for the block
- `.withPreexistingItem(item: ResourceLocation)`{: .language-javascript }: Sets the 'block item' of the block to be an existing item

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

- `.rotateModel(i: number)`{: .language-javascript }: Rotates the placed models by the given amount of degrees
- `.collision()`{: .language-javascript }: Enables collision for the block
- `.itemTexture(texture: String)`{: .language-javascript }: Sets the item's `layer0`{:.s} texture
- `.itemTexture(key: String, texture: String)`{: .language-javascript }: Sets the item's texture for the given key
- `.itemTextureJson(json: JsonObject)`{: .language-javascript }: Sets the json for the item model
- `.rockTypeModel(type: String)`Sets the rock type models that should automatically be used, accepts `igneous_extrusive`{:.s}, `igneous_intrusive`{:.s}, `metamorphic`{:.s}, or `sedimentary`{:.s}, defaults to `metamorphic`{:.s}

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

- `.naturallySupported(supported: boolean)`{: .language-javascript }: Determines if the block is considered to be naturally supported for the purposes of spawning particles indicating unsupported regions
- `.rockTypeTooltip(component: Component)`{: .language-javascript }: Sets the tooltip component indicating the block's rock type
- `.felsicIgneousExtrusive()`{: .language-javascript }: Sets the item's rock type tooltip to be that of felsic igneous extrusive rocks
- `.intermediateIgneousExtrusive()`{: .language-javascript }: Sets the item's rock type tooltip to be that of intermediate igneous extrusive rocks
- `.maficIgneousExtrusive()`{: .language-javascript }: Sets the item's rock type tooltip to be that of intermediate mafic extrusive rocks
- `.maficIgneousIntrusive()`{: .language-javascript }: Sets the item's rock type tooltip to be that of mafic igneous intrusive rocks
- `.felsicIgneousIntrusive()`{: .language-javascript }: Sets the item's rock type tooltip to be that of felsic igneous intrusive rocks
- `.intermediateIgneousIntrusive()`{: .language-javascript }: Sets the item's rock type tooltip to be that of intermediate igneous intrusive rocks
- `.metamorphic()`{: .language-javascript }: Sets the item's rock type tooltip to be that of metamorphic rocks
- `.sedimentary()`{: .language-javascript }: Sets the item's rock type tooltip to be that of sedimentary rocks
- `.uniqueSideTextures()`{: .language-javascript }: Makes the default model generator use the 'side' and 'end' textures instead of just the 'end'

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

#### Extra Method

- `.models(models: BiConsumer<SpikeModelType, ModelGenerator>)`{: .language-javascript }: Sets the model generation of the spike. Accepts a callback with two parameters. The second parameter is a model generator and the second generator has the following methods:
    - `.base()`{: .language-javascript }: A boolean. If the model type in operation represents a base state
    - `.middle()`{: .language-javascript }: A boolean. If the model type in operation represents a middle state
    - `.tip()`{: .language-javascript }: A boolean. If the model type in operation represents a tip state

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

- `.dripChance(f: number)`{: .language-javascript }: Sets the chance, in the range [0, 1], the block will drip per tick
- `.dripTemp(f: number)`{: .language-javascript }: Sets the temperature at which the block must be above to begin dripping
- `.melts()`{: .language-javascript }: makes the block melt under certain conditions
- `.meltChance(f: number)`{: .language-javascript }: Sets the chance, in the range [0, 1], that the block will melt per random tick
- `.meltTemp(f: number)`{: .language-javascript }: Sets the temperature above which the block can melt
- `.dripParticle(particle: String)`{: .language-javascript }: The registry name of a particle, the particle that will drip from the block. May be null to make the spike not drip. Defaults to null
- `.meltFluid(fluid: FluidStackJS)`{: .language-javascript }: The fluid that the block melts into
- `.tipModel(model: String)`{: .language-javascript }: Sets the parent model of the tip state

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

- `.mossyBlock(block: String)`{: .language-javascript }: Accepts a string, the registry name of the block this will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`{: .language-javascript }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

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

- `.mossyStair(block: String)`{: .language-javascript }: Accepts a string, the registry name of a stair block that the block will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`{: .language-javascript }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

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

- `.mossySlab(block: String)`{: .language-javascript }: Accepts a string, the registry name of a slab block that the block will turn into when moss grows to it
- `.mossyConversionFull(callback: MossGrowingCallback)`{: .language-javascript }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow when the `type` state is `double`
- `.mossyConversionHalf(callback: MossGrowingCallback)`{: .language-javascript }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow when the `type` state is `top` or `bottom`
- `.mossyConversion(callback: MossGrowingCallback)`{: .language-javascript }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow for any `type` state

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

- `.mossyWall(block: String)`{: .language-javascript }: Accepts a string, the registry name of a wall block that the block will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`{: .language-javascript }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

Example

```js
StartupEvents.registry('block', event => {
    event.create('my_moss_growing_wall', 'tfc:moss_growing_wall')
        .mossyWall('kubejs:my_moss_spreading_wall')
})
```

### Moss Growing Callback

This is used when determining if a moss growing block should convert to its mossy variant

You are given a `BlockContainerJS` and a boolean, known as `needsWater`, which, in default TFC, is always `true`{:.p} and expected to return a boolean indicating if the block should convert

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

- `.lightLevel(i: number)`{: .language-javascript }: Accepts a number, in the range [1, 15], sets the light level the lamp gives off when lit, defaults to `15`
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.models(models: BiConsumer<LampModelType, ModelGenerator>)`{: .language-javascript }: Sets the model generation of the lamp. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following properties:
    - `on`: A boolean. If the model type represents a lit state
    - `hanging`: A boolean. If the model type represents a hanging state

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_lamp', 'tfc:lamp')
        .lightLevel(4)
        .models((type, m) => {
            if (type.on) {
                m.texture("lamp", "minecraft:block/glowstone");
            }
        })
})
```

### Stationary Berry Bush

Creates a new stationary bush block

Inherits the methods of the default block builder

**Type**: `tfc:stationary_berry_bush`

#### Extra Methods

- `.lifecycle(month: Month, lifecycle: Lifecycle)`{: .language-javascript }: Sets the bush's lifecycle for a particular month, defaults to `dormant` for ever month, accepts a month for the first parameter, and either `healthy`{:.e}, `dormant`{:.e}, `fruiting`{:.e}, or `flowering`{:.e} for the second
- `.productItem(item: Consumer<ItemBuilder>)`{: .language-javascript }: Sets the properties of the bush's product item, the item gotten by right clicking a bush when it is fruiting
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.productItem(item: ResourceLocation)`{: .language-javascript }: Sets the bush's product item to be an existing item, will prevent the other product item from being created
- `.model(lifecycle: Lifecycle, stage: number, modelGenerator: Consumer<ModelGenerator>)`{: .language-javascript }: Sets the model for the given lifecycle and stage, stage can be one of `0`, `1`, and `2`
- `.models(models: TriConsumer<Lifecycle, number, ModelGenerator>)`{: .language-javascript }: Sets the model for all lifecycle and stage combinations
- `.texture(lifecycle: Lifecycle, stage: number, texture: String)`{: .language-javascript }: Sets the texture for the given lifecycle and stage

Additionally, this will register a climate range with the same id as the block, it can be set through the [data event]({% link kubejs_tfc/1.20.1/data.md %}#climate-ranges)

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_stationary_bush', 'tfc:stationary_berry_bush')
        .productItem('minecraft:glow_berries')
        .lifecycle('march', 'healthy')
        .lifecycle('april', 'healthy')
        .lifecycle('may', 'flowering')
        .lifecycle('june', 'fruiting')
        .lifecycle('july', 'healthy')
        .models((lifecycle, stage, modelGen) => {
            if (!lifecycle.active()) {
                m.parent(`tfc:block/plant/stationary_bush_${stage}`);
                m.texture('bush', 'tfc:block/nerry_bush/dead_bush');
                m.texture('particle', 'tfc:block/mud/silt');
            }
        })
        .texture('flowering', 2, 'minecraft:flowering_azalea_leaves')
})
```

### Spreading Berry Bush

Creates a new spreading bush block

Inherits the methods of the stationary bush builder

**Type**: `tfc:spreading_berry_bush`

#### Extra Methods

- `.maxHeight(i: number)`{: .language-javascript }: Sets the maximum number of blocks the bush may climb, defaults to `3`
- `.cane(cane: Consumer<SpreadingCaneBlockBuilder>)`{: .language-javascript }: Sets the properties of the cane block of this bush. Has the same id as the bush, but with `_cane` appended to the end. Has the same methods as the default block builder and:
    - `.model(lifecycle: Lifecycle, stage: number, modelGenerator: Consumer<ModelGenerator>)`{: .language-javascript }: Sets the model for the given lifecycle and stage. Stage can be be one of `0`, `1`, and `2`
    - `.models(models: TriConsumer<Lifecycle, number, ModelGenerator>)`{: .language-javascript }: Sets the model for all lifecycle and stage combinations
    - `.texture(lifecycle: Lifecycle, stage: number, texture: String)`{: .language-javascript }: Sets the cane texture for the given lifecycle and stage
    - `.texture(lifecycle: Lifecycle, stage: number, caneTexture: String, bushTexture)`{: .language-javascript }: Sets the cane and bush texture for the given lifecycle and stage

Additionally, this will register a climate range with the same id as the block, it can be set through the [data event]({% link kubejs_tfc/1.20.1/data.md %}#climate-ranges)

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

- `.grass(grass: Consumer<ConnectedGrassBlockBuilder>)`{: .language-javascript }: Sets the properties of the dirt block's grass block. Has the same id as the dirt block but with `_grass` appended to the end. Has the same methods as the default block builder and:
    - `.uniqueDirtTexture()`{: .language-javascript }: Textures the side of the grass block with a texture path based on the grass block instead of the dirt block
    - `.models(models: BiConsumer<GrassModelPart, ModelGenerator>)`{: .language-javascript }: Sets the model generation of the grass block. Accepts a callback with two parameters. The second parameter is a model generator and the first ahs the following properties:
        - `snowy`: A boolean. If the model part in operation represents a snowy state
        - `side`: A boolean. If the model part in operation represents a side part
        - `top`: A boolean. If the model part in operation represents a top part
        - `bottom`: A boolean. If the model part in operation represents a bottom part
- `.path(path: Consumer<TFCPathBlockBuilder>)`{: .language-javascript }: Creates and sets the properties of the dirt block's path bloc. Has the same id as the dirt block but with `_path` appended to the end. Has the same methods as the default block builder
- `.farmland(farmland: Consumer<TFCFarmlandBlockBuilder>)`{: .language-javascript }: Creates and sets the properties of the dirt block's farmland block. Has the same id as the dirt block but with `_farmland` appended to the end. Has the following methods:
    - Those of the default block builder
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.rooted(rooted: Consumer<TFCRootedDirtBlockBuilder>)`{: .language-javascript }: Creates and sets the properties of the dirt block's rooted dirt block. Has the same id as the dirt block but with `_rooted` appended to the end. Has the same methods as the default block builder
- `.mud(mud: Consumer<BlockBuilder>)`{: .language-javascript }: Creates and sets the properties of the dirt block's mud block. Has the same id as the dirt block but with `_mud` appended to the end

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_dirt', 'tfc:dirt')
        .grass(grass => {
            grass.hardness(1)
            grass.models((type, m) => {
                if (type.snowy && type.top) {
                    m.texture('texture', 'minecraft:block/snow')
                }
            })
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

- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.type(type: Type)`{: .language-javascript }: Sets the type of wild crop block to be used, available options are `default`{:.e}, `double`{:.e}, `flooded`{:.e}, and `spreading`{:.e}, defaults to `default`{:.e}
- `.spreadingFruitBlock(fruitBlock: ResourceLocation)`{: .language-javascript }: Sets the block to be used as the fruit block if the wild crop's type is `spreading`, defaults to `minecraft:honey_block`
- `.seeds(seedItem: ResourceLocation)`{: .language-javascript }: Sets the 'seed' item to be used in the auto-generated loot table
- `.food(foodItem: ResourceLocation)`{: .language-javascript }: Sets the 'food' item to be used in the auto-generated loot table
- `.deadModel(model: String)`{: .language-javascript }: Sets the model to use when the crop is dead/immature and its type is `default`{:.e} or `flooded`{:.e}
- `.doubleDeadModels(topModel: String, bottomModel: String)`{: .language-javascript }: Sets the models to use when the crop is dead/immature and sets the crop's type to `double`{:.e}
- `.spreadingDeadModels(coreModel: String, sideModel: String)`{: .language-javascript }: Sets the models to use when the crop is dead/immature and sets the crop's type to `spreading`{:.e}

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

- `.stages(i: number)`{: .language-javascript }: Sets the number of growth stages the block has, should be a number between 1 and 12, defaults to `8`
- `.deadBlock(deadCrop: Consumer<DeadCropBlockBuilder>)`{: .language-javascript }: Sets the properties of the crop's dead block. Accepts a consumer with the same methods as the default block builder and:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.models(models: BiConsumer<DeadModelVariant, ModelGenerator>)`{: .language-javascript }: Sets the model generation for the dead crop. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following methods:
        - `.variant()`{: .language-javascript }: A string. The variant key used for the model in the blockstate file
        - `.mature()`{: .language-javascript }: A boolean. If the variant in operation represents a mature state
- `.seedItem(seedItem: Consumer<SeedItemBuilder>)`{: .language-javascript }: A consumer for setting the properties of the block's seed item
- `.productItem(productItem: Consumer<ItemBuilder>)`{: .language-javascript }: A consumer for setting the properties of the block's product item
- `.productItem(productItem: ResourceLocation)`{: .language-javascript }: Sets the crop's 'product' item to be an existing item, will be prevent the other product item from existing
- `.nutrient(nutrient: NutrientType)`{: .language-javascript }: Sets the nutrient the crop consumes, available options are `nitrogen`{:.e}, `phosphorous`{:.e} , and `potassium`{:.e}, defaults to `nitrogen`{:.e}
- `.texture(texture: String)`{: .language-javascript }: Sets the crop's `crop` texture for all growth stages
- `.textureAll(id: String, texture: String)`{: .language-javascript }: Sets the crop's texture for the id for all growth stages
- `.model(model: String)`{: .language-javascript }: Sets the crop's model for all growth stages
- `.model(gen: Consumer<ModelGenerator>)`{: .language-javascript }: Sets the crop's model for all growth stages
- `.model(i: number, gen: Consumer<ModelGenerator>)`{: .language-javascript }: Sets the crop's model for a specific growth stage
- `.model(i: number, model: String)`{: .language-javascript }: Sets the crop's model for a specific growth stage
- `.texture(i: number, id: String, texture: String)`{: .language-javascript }: Textures a specific key for the given stage
- `.texture(i: number, texture: String)`{: .language-javascript }: Sets the crop's `crop` texture for the given growth stage
- `.textures(textures: JsonObject)`{: .language-javascript }: Sets the crop's textures for all growth stages
- `.textures(i: number, textures: JsonObject)`{: .language-javascript }: Sets the crop's textures for the given growth stage

Additionally this will register a climate range with the same id as the block, it can be set through the [data event]({% link kubejs_tfc/1.20.1/data.md %}#climate-ranges)

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

- `.stages(i: number)`{: .language-javascript }: Sets the number of growth stages the block has, should be a number between 1 and 6, defaults to `4`
- `.doubleStages(i: number)`{: .language-javascript }: Sets the number of stages the crop has in its top state, should be a number between 1 and 6, defaults to `4`
- `.requiresStick(required: boolean)`{: .language-javascript }: Determines if the crop needs a stick to grow
- `.deadBlock(deadCrop: Consumer<DeadCropBlockBuidler>)`{: .language-javascript }: Sets the properties of the crop's dead block. Accepts a consumer with the same methods as the default block builder and:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.models(models: BiConsumer<DeadModelVariant, ModelGenerator>)`{: .language-javascript }: Sets the model generation for the dead crop. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following methods:
        - `.variant()`{: .language-javascript }: A string. The variant key used for the model in the blockstate file
        - `.mature()`{: .language-javascript }: A boolean. If the variant in operation represents a mature state
        - `.bottom()`{: .language-javascript }: A boolean. If the variant in operation represents a bottom state
        - `.stick()`{: .language-javascript }: A boolean. If the variant in operation represents a a state with `stick=true`. Only relevant if `.requiresStick(true)`{: .language-javascript } has been called

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_double_crop', 'tfc:double_crop')
        .requiresStick(true)
        .dead(dead => {
            dead.models((variant, m) => {
                if (variant.stick()) {
                    m.parent('tfc:block/crop/stick');
                }
            })
        })
})
```

### Spreading Crops

Creates a new spreading crop block

Inherits the methods of the [TFC crop builder](#default-crops)

**Type**: `tfc:spreading_crop`

#### Extra Method

- `.fruitBlock(fruitBlock: ResourceLocation)`{: .language-javascript }: Sets the block that will be used as the block's fruit block, defaults to `minecraft:honey_block`

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

- `.fruit(fruit: ResourceLocation)`{: .language-javascript }: Sets the item the player will be given when they pick the block
- `.matureFruit(fruit: ResourceLocation)`{: .language-javascript }: Sets the item the player will be given when they pick the block and the crop is mature, defaults to `minecraft:apple`

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

Will not automatically support blocks, use the [support method]({% link kubejs_tfc/1.20.1/data.md %}#supports) in the data event for that

**Type**: `tfc:support`

#### Extra methods

- `.horizontal(horizontalSupport: Consumer<HorizontalSupportBlockBuilder>)`{: .language-javascript }: Allows for editing of the properties of the horizontal block
    - The consumer has the same methods as the default block builder and one additional one:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)

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

- `.tier(i: number)`{: .language-javascript }: Sets the tier of the anvil, defaults to 0
- `.defaultName(name: Component)`{: .language-javascript }: Sets the default name of the anvil screen, defaults to `Text.translatable('tfc.block_entity.anvil')`
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)

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

- `.axleTexture(texture: String)`{: .language-javascript }: Sets the texture the axle will be rendered with
- `.windmill(windmill: Consumer<WindmillBlockBuilder>)`{: .language-javascript }: Sets the properties of the axle's windmill block
    - The consumer has the same methods as the default block builder and one additional one:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.waterWheel(waterWheel: Consumer<WaterWheelBlockBuilder>)`{: .language-javascript }: Creates and sets the properties of the axle's water wheel block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.texture(texture: String)`{: .language-javascript }: Sets the texture the water wheel will use, the path is relative to `/textures/entity/waterwheel/`
- `.gearBox(gearBox: Consumer<GearBoxBlockBuilder>)`{: .language-javascript }: Creates and sets the properties of the axle's gear box block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.models(models: BiConsumer<GearBoxModelType, ModelGenerator>)`{: .language-javascript }: Sets the model generation of the gear box. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following method:
        - `.port()`{: .language-javascript }: A boolean. If the model type in operation represents a port (open) state
- `.clutch(clutch: Consumer<ClutchBlockBuilder>)`{: .language-javascript }: Creates and sets the properties of the axle's clutch block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.models(models: BiConsumer<ClutchModelType, ModelGenerator>)`{: .language-javascript }: Sets the model generation of the clutch. Accepts a callback with two parameters. The second parameter is a model generator, the first has the following method:
        - `.powered()`{: .language-javascript }: A boolean. If the model type in operation represents a powered state
- `.bladedAxle(bladed: Consumer<BladedAxleBlockBuilder>)`{: .language-javascript }: Creates and sets the properties of the axle's bladed axle block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-javascript }: A consumer, that sets some of TFC's [extended properties](#extended-properties)

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

### Log

Creates a new TFC log block

Inherits the methods of the default block builder

**Type**: `tfc:log`

#### Extra Methods

- `.stripped(builder: @Nullable Consumer<LogBlockBuilder>)`{: .language-javascript }: Sets the properties of the stripped log variant, consumer has same methods as this block except for this method. May pass in null to remove the stripped block
- `.useFullBlockForItemModel()`{: .language-javascript }: Makes the autogenerated item model use the model of the block instead of a custom texture

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_log', 'tfc:log')
        .useFullBlockForItemModel()
        .stripped(stripped => {
            stripped.useFullBlockForItemModel()
        })
})
```

### Torch

Creates a new TFC torch block

Inherits the methods of the default block builder

**Type**: `tfc:torch`

#### Extra Methods

- `.deadItem(item: @Nullable Consumer<ItemBuidler>)`{: .language-javascript }: Sets the properties of the dead/unlit item, may be null to not have a dead/unlit item
- `.decayLength(i: number)`{: .language-javascript }: Sets the time, in calendar ticks, the torch will burn for
- `.decayLengthSupplier(length: Supplier<Integer>)`{: .language-javascript }: Sets the supplier for the time, in calendar ticks, the torch will burn for. Defaults to Using TFC's server config value for torch burn length
- `.flameParticle(particle: String)`{: .language-javascript }: Sets the flame particle of the torch, may be null to not have a flame particle. Defaults to `minecraft:flame`[^1]
- `.smokeParticle(particle: String)`{: .language-javascript }: Sets the smoke particle of the torch, may be null to not have a smoke particle. Defaults to `minecraft:smoke`[^1]
- `.dead(dead: Consumer<DeadTorchBuidler>)`{: .language-javascript }: Sets the properties of the dead/unlit block. Accepts a consumer with all the methods of the default block builder
- `.wall(wall: Consumer<WallTorchBuilder>)`{: .language-javascript }: Sets the properties of the wall block. Accepts a consumer with the methods of the default block builder
- `.deadWall(deadWall: Consumer<DeadWallTorchBuidler>)`{: .language-javascript }: Sets the properties of the dead/unlit wall block. Accepts a consumer with the methods of the default block builder

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_torch', 'tfc:torch')
        .deacyLength(120000) // 6 in game days
        .flameParticle('minecraft:soul_fire_flame')
        .dead(dead => {
            dead.lootTable = (buidler) => {
                builder.addPool(pool => {
                    pool.survivesExplosion();
                    pool.addItem('3x minecraft:glowstone');
                })
            }
        })
})
```

### FirmaLife Cheese Wheel

Creates a new cheese wheel block

Inherits the methods of the default block builder

**Type**: `firmalife:cheese_wheel`

#### Extra Method

- `.sliceItem(slice: Consumer<ItemBuilder>)`{: .language-javascript }: Sets the properties of the cheese wheel's slice item
- `.freshInsideTexture(tex: String)`{: .language-javascript }: Sets the inside texture when the cheese is fresh
- `.agedInsideTexture(tex: String)`{: .language-javascript }: Sets the inside texture when the cheese is aged
- `.vintageInsideTexture(tex: String)`{: .language-javascript }: Sets the inside texture when the cheese is vintage

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_cheese_wheel', 'firmalife:cheese_wheel')
})
```

### Extended Properties

Some of TFC's blocks have extended properties which allow the block properties object passed into them to define more of their behavior, builders for these types of blocks have a method with a consumer that allows you to modify some of those properties

- `.flammable(flammability: number, fireSpreadSpeed: number)`{: .language-javascript }: Sets the flammability and fire spread speed of the block
- `.pathType(pathType: BlockPathTypes)`{: .language-javascript }: Sets the block's path type, used by mobs to determine if they may walk over it or not
- `.enchantPower(f: number)`{: .language-javascript }: Sets the block's enchant power
- `.enchantPowerFunction(function: Function<BlockState, Double>)`{: .language-javascript }: Sets the function the block uses to determine its enchant power based on its block state
- `.noCollision()`{: .language-javascript }: Removes the block's collision
- `.noOcclusion()`{: .language-javascript }: Makes the block not occlude blocks behind it
- `.friction(f: number)`{: .language-javascript }: Sets the friction of the block
- `.speedFactor(f: number)`{: .language-javascript }: Sets the speed factor of the block
- `.jumpFactor(f: number)`{: .language-javascript }: Sets the jump factor of the block
- `.sound(sound: SoundType)`{: .language-javascript }: Sets the sound type the block uses
- `.lightLevel(lightLevel: Function<BlockState, number>)`{: .language-javascript }: Sets the light level, in the range [0, 15], of the block, as a function of its state
- `.strength(destroyTime: number, explosionResistance: number)`{: .language-javascript }: Sets the destroy time and explosion resistance of the block
- `.instabreak()`{: .language-javascript }: Makes the block instabreak
- `.strength(f: number)`{: .language-javascript }: Sets the destroy time and explosion resistance of the block
- `.randomTicks()`{: .language-javascript }: Sets the block to random tick
- `.dynamicShape()`{: .language-javascript }: Marks the block as having a dynamic shape
- `.noLootTable()`{: .language-javascript }: Marks the block as having no loot table
- `.dropsLike(block: Supplier<Block>)`{: .language-javascript }: makes the block drop like the supplied block
- `.air()`{: .language-javascript }: Marks the block as being air-like
- `.isValidSpawn(isValidSpawn: BlockBehaviour$StateArgumentPredicate<EntityType<?>>)`{: .language-javascript }: Determines if an entity may spawn on the block
- `.isSuffocating(isSuffocating: BlockBehaviour$StatePredicate)`{: .language-javascript }: Determines if the block is suffocating
- `.isViewBlocking(isBlocking: BlockBehaviour$StatePredicate)`{: .language-javascript }: Determines if the block is view blocking
- `.requiresCorrectToolForDrops()`{: .language-javascript }: Sets the block to require a 'correct' tool (as determined by a tag) for it to drops its loot table
- `.mapColor(color: MapColor)`{: .language-javascript }: Sets the map color of the block
- `.mapColor(color: Function<BlockState, MapColor>)`{: .language-javascript }: Sets the map color of the block per state
- `.destroyTime(f: number)`{: .language-javascript }: Sets the destroy time of the block
- `.explosionResistance(f: number)`{: .language-javascript }: Sets the explosion resistance of the block
- `.ignitedByLava()`{: .language-javascript }: Sets the block to be ignited by lava
- `.forceSolidOn()`{: .language-javascript }: Forces the block to be solid
- `.forceSolidOff()`{: .language-javascript }: Forces the block to be non-solid (?)
- `.pushReaction(reaction: PushReaction)`{: .language-javascript }: Sets the block's reaction to being pushed by pistons
- `.offsetType(type: OffsetType)`{: .language-javascript }: Sets the block's hitbox offset type
- `.noParticlesOnBreak()`{: .language-javascript }: Sets the block to not create any particles when broken
- `.instrument(instrument: NoteBlockInstrument)`{: .language-javascript }: Sets the note block instrument the block has
- `.defaultInstrument()`{: .language-javascript }: Sets the block's not block instrument to be the harp
- `.replaceable()`{: .language-javascript }: Marks the block as being replaceable

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
- [Glass Bottle](#glass-bottle)
- [Jug](#jug)

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

{: .notice #fluid-container-texture-notice }
> This item requires two textures to function properly
>
> - item/\<name>: The base texture
> - item/\<name> + `_overlay`: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/ceramic/fired_mold/axe_head_overlay.png) for what it should look like
>
> For the example below, the textures would be in `kubejs/textures/item/my_fluid_container.png` and `kubejs/textures/item/my_fluid_container_overlay.png`
>
> These locations can be changed by setting the `base`{:.s} and `fluid`{:.s} textures using the `.texture(key: String, texture: String)`{: .language-javascript } method

#### Extra Methods

- `.canPlaceLiquid(b: boolean)`{: .language-javascript }: Determines if the item can place liquids in world, defaults to `false`{:.p}
- `.canPlaceLiquidSource(b: boolean)`{: .language-javascript }: Determines if the the item can place source blocks in world, defaults to `false`{:.p}
- `.capacity(i: number)`{: .language-javascript }: Sets the mB capacity of the item, defaults to `100`
- `.fluidTagAccept(tag: String)`{: .language-javascript }: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_jug`
- `.filledDisplayName(c: Component)`{: .language-javascript }: Accepts a text component, sets the display name when the object has a fluid in it, will be overridden by an entry in a lang file if it exists
- `.capacitySupplier(capacity: Supplier<Integer>)`{: .language-javascript }: Sets the mB supplier capacity of the item, defaults to `() => 100`

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

- `.metalTexture(texture: String)`{: .language-javascript }: Sets the texture of the hammer when in a trip hammer, this is required if you want the hammer to be usable in a trip hammer

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

- `.thrownDamage(f: number)`{: .language-javascript }: Sets the thrown damage of the javelin, defaults to `0.3`
- `.skeletonWeapon()`{: .language-javascript }: Adds the item to the `tfc:skeleton_weapons` item tag
- `.throwingModel(m: String)`{: .language-javascript }: Sets the model to use when throwing the javelin, before release
- `.modelAtPerspective(perspective: ItemDisplayContext, model: String)`{: .language-javascript }: Sets the model to use at the specified display context
- `.guiModel(m: String)`{: .language-javascript }: Sets the model to use for the `none`{:.e}, `fixed`{:.e}, `ground`{:.e}, and `gui`{:.e} display contexts

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

{: .notice #mold-texture-notice }
> This item requires two textures to function properly
>
> - item/\<name>: The base texture
> - item/\<name> + `_overlay`: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/ceramic/fired_mold/axe_head_overlay.png) for what it should look like
>
> For the example below, the textures would be in `kubejs/textures/item/my_mold.png` and `kubejs/textures/item/my_mold_overlay.png`
>
> These locations can be changed by setting the `base`{:.s} and `fluid`{:.e} textures using the `.texture(key: String, texture: String)`{: ,language-javascript } method

#### Extra Methods

- `.capacity(i: number)`{: .language-javascript }: Sets the mB capacity of the mold, defaults to `100`
- `.fluidTagAccept(fluidTag: String)`{: .language-javascript }: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_ingot_mold`
- `.capacity(capacity: Supplier<Integer>)`{: .language-javascript }: Sets the mB capacity supplier of the mold, defaults to `() => 100`

<a id="tfccc"></a>If [TFC Casting with Channels](https://www.curseforge.com/minecraft/mc-mods/tfc-casting-with-channels) is installed, the following method is available

- `.tfcccAllowedInMoldTable(model?: List<String>)`{: .language-javascript }: Allows the mold to be placed in a mold table
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

- `.mineableBlocksTag(blockTag: String)`{: .language-javascript }: Sets the block tag that the scythe can properly dig at full speed, defaults to `tfc:mineable_with_scythe`

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

- `.mineableBlocksTag(blockTag: String)`{: .language-javascript }: Sets the block tag that the 'tool' can properly dig at full speed, defaults to `tfc:mineable_with_knife`
- `.knife()`{: .language-javascript }: Adds the item to the `tfc:knives` tag and sets its mineable blocks tag to `tfc:mineable_with_knife`

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

- `.fishingStrength(f: number)`{: .language-javascript }: Sets the fishing strength of the rod, defaults to a value based on the tool's tier
- `.castModel(model: String)`{: .language-javascript }: Sets the model used when the rod is cast, if not set a default one will be created which will use a texture with the same path as the normal texture with `_cast` appended to the end or the one provided via the `.castTexture` method
- `.smallBait()`{: .language-javascript }: Adds the rod to the correct tag to allow it to hold small bait
- `.largeBait()`{: .language-javascript }: Adds the rod to the correct tag to allow it to hold large bait
- `.castTexture(t: String)`{: .language-javascript }: Sets the texture used when the rod is cast out

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

- `.placedModel(model: String)`{: .language-javascript }: Sets the model of the jar when placed, defaults to the item's id

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

- `.operation(operation: GlassOperation)`{: .language-javascript }: Sets the `GlassOperation`{:.e} the item is capable of performing, defaults to `saw`{:.e}

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

- `.bladeColor(color: Color)`{: .language-javascript }: Sets the color of the blade, defaults to `0x000000`
- `.bladeTexture(texture: String)`{: .language-javascript }: Sets the texture of the windmill blade, defaults to `tfc:textures/entity/misc/windmill_blade.png`

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

#### Extra Method

- `.operation(operation: GlassOperation)`{: .language-javascript }: Sets the `GlassOperation`{:.e} the item is capable of performing, defaults to `saw`{:.e}

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_glass_working_tool', 'tfc:glassworking_tool')
        .operation('pinch')
        .mineableBlocksTag('kubejs:mineable/default')
})
```

### Glass Bottle

Creates a new glass bottle item

Inherits the methods of the basic item builder

**Type**: `tfc:glass_bottle`

{: .notice #glass-bottle-texture-notice }
> This item requires two textures to function properly
>
> - item/\<name>: The base texture
> - item/\<name> + `_overlay`: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/bucket/glass_bottle_overlay.png) for what it should look like
>
> For the example below, the textures would be in `kubejs/textures/item/my_glass_bottle.png` and `kubejs/textures/item/my_glass_bottle_overlay.png`
>
> These locations can be changed by setting the `base`{:.s} and `fluid`{:.s} textures using the `.texture(key: String, texture: String)`{: .language-javascript } method

#### Extra Methods

- `.filledDisplayName(c: Component)`{: .language-javascript }: Accepts a text component, sets the display name when the object has a fluid in it, will be overridden by an entry in a lang file if it exists
- `.capacity(i: number)`{: .language-javascript }: Sets the mB capacity of the item, defaults to `100`
- `.capacitySupplier(capacity: Supplier<Integer>)`{: .language-javascript }: Sets the mB supplier capacity of the item, defaults to `() => 100`
- `.breakChance(chance: number)`{: .language-javascript }: Sets the break chance, in the range [0, 1], of the bottle
- `.breakChanceSupplier(chance: Supplier<Double>)`{: .language-javascript }: Sets the break chance, in the range [0, 1], supplier of the bottle
- `.fluidTagAccept(tag: String)`{: .language-javascript }: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_jug`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_glass_bottle', 'tfc:glass_bottle')
        .capacity(500)
        .filledDisplayName('Bottle of %s')
})
```

### Jug

Creates a new jug item

Inherits the methods of the default item builder

**Type**: `tfc:jug`

{: .notice #jug-texture-notice }
> This item requires two textures to function properly
>
> - item/\<name>: The base texture
> - item/\<name> + `_overlay`: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/bucket/glass_bottle_overlay.png) for what it should look like
>
> These locations can be changed by setting the `base`{:.s} and `fluid`{:.s} textures using the `.texture(key: String, texture: STring)`{: .language-javascript } method as seen in the example

#### Extra Methods

- `.filledDisplayName(c: Component)`{: .language-javascript }: Accepts a text component, sets the display name when the object has a fluid in it, will be overridden by an entry in a lang file if it exists
- `.capacity(i: number)`{: .language-javascript }: Sets the mB capacity of the item, defaults to `100`
- `.capacitySupplier(capacity: Supplier<Integer>)`{: .language-javascript }: Sets the mB supplier capacity of the item, defaults to `() => 100`
- `.fluidTagAccept(tag: String)`{: .language-javascript }: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_jug`

#### Example

```js
StartupEvents.registry('item', event => {
    event.create('my_jug', 'tfc:jug')
        .texture('base', 'tfc:item/ceramic/jug_empty')
        .texture('fluid', 'tfc:item/ceramic/jug_overlay')
        .fluidTagAccept('kubejs:juices')
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

- `.cooldown(i: number)`{: .language-javascript }: Sets the cooldown, in ticks, the item gets when it prospects, defaults to `20`
- `.primaryRadius(i: number)`{: .language-javascript }: Sets the primary radius of the prospector, defaults to `10`
- `.primaryRadius(supplier: Supplier<Integer>)`{: .language-javascript }: Sets the integer supplier that defines the item's primary radius, defaults to `() => 10`
- `.secondaryRadius(i: number)`{: .language-javascript }: Sets the secondary radius of the prospector, defaults to `10`
- `.secondaryRadius(supplier: Supplier<Integer>)`{: .language-javascript }: Sets the integer supplier that defines the item's secondary radius, defaults to `() => 10`
- `.displacement(i: number)`{: .language-javascript }: Sets the displacement of the prospector, defaults to `0`
- `.displacement(supplier: Supplier<Integer>)`{: .language-javascript }: Sets the integer supplier that defines the item's displacement, defaults to `() => 0`
- `.prospectTag(blockTag: String)`{: .language-javascript }: Sets the block tag that the item can prospect, defaults to `tfc:prospectable`

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

- `.bubbleParticle(particle: String)`{: .language-javascript }: Accepts a string, the registry name of a particle, sets the bubble particle of the liquid block, defaults to `minecraft:bubble`[^1]. May be null to not have bubble particles
- `.steamParticle(particle: String)`{: .language-javascript }: Accepts a string, the registry name of a particle, sets the steam particle of the liquid block, defaults to `tfc:steam`[^1]. May be null to not have steam particles
- `.healingAmount(f: number)`{: .language-javascript }: Sets the amount of health an entity gets while standing in the fluid, defaults to `0.08`

[^1]: A full list of all particle types can be attained by running the command `/kubejs dump_registry minecraft:particle_type` in-game

#### Example

```js
StartupEvents.registry('fluid', event => {
    event.create('my_cool_fluid', 'tfc:spring')
        .steamParticle('minecraft:lava_drip_particle')
})
```

## Attachments

In 1.20.1, KubeJS added the ability to add block entity attachments to its basic blocks, KubeJS TFC adds a few attachments that can be used in scripts

- [Inventory](#inventory)
- [Heat](#heat)
- [Calendar](#calendar)

### Inventory

Adds a new inventory attachment that can have its contents restricted based on TFC's size and weight values

**Type**: `tfc:inventory`

#### Definition

- `width`: A number, determines how wide the container is, identical to KubeJS's default inventory width. Required
- `height`: A number, determines how tall the container is, identical to KubeJS's default inventory height. Required
- `inputFilter`: An ingredient, a filter for what items are allowed into the container, identical to KubeJS's default inventory `inputFilter`. Optional
- `size`: A `Predicate<Size>`, a filter for what size of items are allowed into the container. Optional
- `weight`: A `Predicate<Weight>`{: .language-javascript }, a filter for what weight of items are allowed into the container. Optional

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

### Heat

Adds a new attachment that implements TFC's `IHeatBlock` interface, updates its temperature every tick, and can provide heat to blocks above it like the charcoal forge

**Type**: `tfc:heat`

**Note**: Due to the way KubeJS works, this does not directly expose the `IHeatBlock` interface on the block entity, nor does it attach a block heat capability to it so other blocks will not be able to automatically interface with it, nor will Jade show the temperature

#### Definition

- `temperatureCallback`: One of:
    - A number, a constant temperature
    - A callback, dynamically sets the temperature based on the parameters:
        - `be: BlockEnttiyJS`{: .language-javascript }: The block entity
        - `currentTemperature: number`{: .language-javascript }: The current temperature of the block
        - `calendarTick: number`{: .language-javascript }: The current calendar tick during the calculation
        - `calendarTicksSinceLastUpdate: number`{: .language-javascript }: The number of calendar ticks that have passed since the calculation was last run
        - `return: number`: The new temperature to set the block to. May be negative to keep the previous temperature
- `providesHeat`: A boolean. Optional, defaults to false. If true, the block will provide its temperature to a heat block above it, similar to the charcoal forge

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('heat_example')
        .blockEntity(be => {
            be.attach('tfc:heat', {
                temperatureCallback: (be, currentTemperature, calendarTick, skippedTicks) => {
                    if (skippedTicks > 1) {
                        // Cools down while unloaded
                        var afterSkip = currentTemperature - (2.5 * skippedTicks) // Cools 2.5°C per tick unloaded
                        return Math.max(0, afterSkip);
                    } else {
                        if (be.data.heating) {
                            return Math.min(5000, currentTemperture + 0.5);
                        } else {
                            return -1;
                        }
                    }
                },
                providesHeat: true
            })
        })
})
```

### Calendar

Adds a new attachment that can be used to keep track of a calendar timestamp

**Type**: `tfc:calendar`

#### Definition

- `defaultDuration`: A number. Optional, defaults to -1. Specifies the duration, in calendar ticks, to time for if a duration is not provided in `.startTiming()`{: .language-javascript }

#### Methods

- `.startTiming(duration?: number)`{: .language-javascript }: Sets the attachment's tick to the current tick and duration to either the default duration or the duration provided
- `.getCalendarTick()`{: .language-javascript }: Returns a number. Gets the calendar tick the attachment is timing from
- `.hasDurationElapsed()`{: .language-javascript }: Returns a boolean. If current calendar tick is more than `duration` ticks after the calendar tick the attachment is timing from
- `.reset()`{: .language-javascript }: Sets the calendar tick the attachment is timing from to be -1, considered to be a 'non-timing' timestamp

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('calendar_example')
        .blockEntity(be => {
            be.attach('tfc:calendar', {
                defaultDuration: 500
            })
            be.serverTicks(be => {
                let cal = be.attachments[0];
                if (cal.calendarTick != -1 && cal.hasDurationElapsed()) {
                    be.level.playSound(null, be.x, be.y, be.z, 'minecraft:block.anvil.place', 'blocks', 1, 1);
                    cal.reset();
                }
            })
        })
        .rightClick(event => {
            event.block.enttiy.attachments[0].startTiming();
        })
})
```
