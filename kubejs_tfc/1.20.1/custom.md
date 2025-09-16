---
layout: page
title: Custom Blocks, Items, and Fluids
permalink: /kubejs_tfc/1.20.1/custom/
parent: 1.20.1
grand_parent: KubeJS TFC
desc: Documentation on the custom block, item, and fluid types added by KubeJS TFC
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
- [Sapling](#sapling)
- [Leaves](#leaves)

<a id="firmalife-blocks"></a>If *FirmaLife* {% include mr.html link='firmalife' %} {% include cf.html link='firmalife' %} is installed, the following types are also available:

- [Cheese Wheel](#firmalife-cheese-wheel)

### Aqueduct

Creates a new aqueduct block

Inherits the methods of the default block builder

**Type**: `tfc:aqueduct`

{: #aqueduct-methods }

#### Extra Methods

- `.allowedFluids(fluids: String[])`{: .language-kube #aqueduct-allowed-fluids }: Sets the fluids that the aqueduct may hold
    - `fluids`{:.v}: The registry names of fluids the aqueduct can hold. Two liquids with different namespaces but same paths will not be accepted, `minecraft:empty` will automatically be added
- `.models(models: BiConsumer<AqueductModelPart, ModelGenerator>)`{: .language-kube #aqueduct-models }: Sets the model generation of the aqueduct. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following methods:
    - `.base()`{: .language-kube }: A boolean. If the model part in operation is for the base
    - `.north()`{: .language-kube }: A boolean. If the model part in operation is the north part
    - `.south()`{: .language-kube }: A boolean. If the model part in operation is the south part
    - `.east()`{: .language-kube }: A boolean. If the model part in operation is the east part
    - `.west()`{: .language-kube }: A boolean. If the model part in operation is the west part

{: #aqueduct-example }

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

{: #ground-cover-methods }

#### Extra Methods

- `.ore()`{: .language-kube #ground-cover-ore }: Sets the collision shape to that of TFC's ores
- `.twig()`{: .language-kube #ground-cover-twig }: Sets the collision shape to that of TFC's twigs and makes the block flammable
- `.groundCoverModelShape(model: String)`{: .language-kube #ground-cover-model }: Sets the default parent model, defaults to `loose/igneous_intrusive_2`{:.s}
    - This accepts anything added to [kubejs_tfc/models/block/ground_cover/](https://github.com/Notenoughmail/KubeJS-TFC/tree/1.20.1/src/main/resources/assets/kubejs_tfc/models/block/ground_cover)
- `.collision()`{: .language-kube #ground-cover-collision }: Enables collision for the block
- `.withPreexistingItem(item: ResourceLocation)`{: .language-kube #ground-cover-preexisting-item }: Sets the 'block item' of the block to be an existing item
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube #ground-cover-extend-props}: A consumer, that sets some of TFC's [extended properties](#extended-properties)

{: #ground-cover-example }

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_placed_ore', 'tfc:ground_cover').ore()
})
```

### Loose Rock

Creates a new loose rock block

Inherits the methods of the default block builder

**Type**: `tfc:loose_rock`

{: #loose-rock-methods }

#### Extra Methods

- `.rotateModel(i: number)`{: .language-kube #loose-rock-rate-model }: Rotates the placed models by the given amount of degrees
- `.collision()`{: .language-kube #loose-rock-collision }: Enables collision for the block
- `.itemTexture(texture: String)`{: .language-kube #loose-rock-item-texture-0 }: Sets the item's `layer0`{:.s} texture
- `.itemTexture(key: String, texture: String)`{: .language-kube #loose-rock-item-texture-1 }: Sets the item's texture for the given key
- `.itemTextureJson(json: JsonObject)`{: .language-kube #loose-rock-item-texture-json }: Sets the json for the item model
- `.rockTypeModel(type: String)`{: .language-kube #loose-rock-rock-type-model }Sets the rock type models that should automatically be used, accepts `igneous_extrusive`{:.s}, `igneous_intrusive`{:.s}, `metamorphic`{:.s}, or `sedimentary`{:.s}, defaults to `metamorphic`{:.s}

{: #loose-rock-example }

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

{: #raw-rock-methods }

#### Extra Methods

- `.naturallySupported(supported: boolean)`{: .language-kube #raw-support }: Determines if the block is considered to be naturally supported for the purposes of spawning particles indicating unsupported regions
- `.rockTypeTooltip(component: Component)`{: .language-kube #raw-tooltip }: Sets the tooltip component indicating the block's rock type
- `.felsicIgneousExtrusive()`{: .language-kube #raw-felsic-extrusive }: Sets the item's rock type tooltip to be that of felsic igneous extrusive rocks
- `.intermediateIgneousExtrusive()`{: .language-kube #raw-intermediate-extrusive }: Sets the item's rock type tooltip to be that of intermediate igneous extrusive rocks
- `.maficIgneousExtrusive()`{: .language-kube #raw-mafic-extrusive }: Sets the item's rock type tooltip to be that of intermediate mafic extrusive rocks
- `.maficIgneousIntrusive()`{: .language-kube #raw-mafic-intrusive }: Sets the item's rock type tooltip to be that of mafic igneous intrusive rocks
- `.felsicIgneousIntrusive()`{: .language-kube #raw-felsic-intrusive }: Sets the item's rock type tooltip to be that of felsic igneous intrusive rocks
- `.intermediateIgneousIntrusive()`{: .language-kube #raw-intermediate-intrusive}: Sets the item's rock type tooltip to be that of intermediate igneous intrusive rocks
- `.metamorphic()`{: .language-kube #raw-metamorphic }: Sets the item's rock type tooltip to be that of metamorphic rocks
- `.sedimentary()`{: .language-kube #raw-sedimentary }: Sets the item's rock type tooltip to be that of sedimentary rocks
- `.uniqueSideTextures()`{: .language-kube #raw-unique-sides }: Makes the default model generator use the `side`{:.s} and `end`{:.s} textures instead of just the `end`{:.s}

{: #raw-rock-example }

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

{: #rock-spike-methods }

#### Extra Method

- `.models(models: BiConsumer<SpikeModelType, ModelGenerator>)`{: .language-kube }: Sets the model generation of the spike. Accepts a callback with two parameters. The second parameter is a model generator and the second generator has the following methods:
    - `.base()`{: .language-kube }: A boolean. If the model type in operation represents a base state
    - `.middle()`{: .language-kube }: A boolean. If the model type in operation represents a middle state
    - `.tip()`{: .language-kube }: A boolean. If the model type in operation represents a tip state

{: #rock-spike-example }

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

{: #thin-spike-methods }

#### Extra Methods

- `.dripChance(f: number)`{: .language-kube #thin-spike-drip-chance }: Sets the chance, in the range [0, 1], the block will drip per tick
- `.dripTemp(f: number)`{: .language-kube #thin-spike-drip-temp }: Sets the temperature at which the block must be above to begin dripping
- `.melts()`{: .language-kube #thin-spike-melts }: makes the block melt under certain conditions
- `.meltChance(f: number)`{: .language-kube #thin-spike-melt-chance}: Sets the chance, in the range [0, 1], that the block will melt per random tick
- `.meltTemp(f: number)`{: .language-kube #thin-spike-melt-temp }: Sets the temperature above which the block can melt
- `.dripParticle(particle: String)`{: .language-kube #thin-spike-drip-particle }: The registry name of a particle, the particle that will drip from the block. May be null to make the spike not drip. Defaults to `null`{:,p}
- `.meltFluid(fluid: FluidStack)`{: .language-kube #thin-spike-melt-fluid }: The fluid that the block melts into
- `.tipModel(model: String)`{: .language-kube #thin-spike-tip-model }: Sets the parent model of the tip state

{: #thin-spike-example }

#### Example

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

{: #moss-spreading-examples }

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

- `.mossyBlock(block: String)`{: .language-kube #moss-growing-block-mossy-block }: Accepts a string, the registry name of the block this will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`{: .language-kube #moss-growing-block-conversion }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

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

- `.mossyStair(block: String)`{: .language-kube #moss-growing-stair-mossy-stair }: Accepts a string, the registry name of a stair block that the block will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`{: .language-kube #moss-growing-stair-conversion }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

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

- `.mossySlab(block: String)`{: .language-kube #moss-growing-slab-mossy-slab }: Accepts a string, the registry name of a slab block that the block will turn into when moss grows to it
- `.mossyConversionFull(callback: MossGrowingCallback)`{: .language-kube #moss-growing-slab-full-conversion }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow when the `type` state is `double`
- `.mossyConversionHalf(callback: MossGrowingCallback)`{: .language-kube #moss-growing-slab-half-conversion }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow when the `type` state is `top` or `bottom`
- `.mossyConversion(callback: MossGrowingCallback)`{: .language-kube #moss-growing-slab-any-conversion }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow for any `type` state

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

- `.mossyWall(block: String)`{: .language-kube #moss-growing-wall-mossy-wall }: Accepts a string, the registry name of a wall block that the block will turn into when moss grows to it
- `.mossyConversion(callback: MossGrowingCallback)`{: .language-kube #moss-growing-wall-conversion }: Accepts a [MossGrowingCallback](#moss-growing-callback), sets how the block determines if moss should grow

Example

```js
StartupEvents.registry('block', event => {
    event.create('my_moss_growing_wall', 'tfc:moss_growing_wall')
        .mossyWall('kubejs:my_moss_spreading_wall')
})
```

### Moss Growing Callback

This is used when determining if a moss growing block should convert to its mossy variant

The parameters of the callback are:

- `container: BlockContainerJS`{: .language-kube }: The block and level being checked
- `needsWater: boolean`{: .language-kube }: A boolean representing if a need for water should be respected. This is always `true`{:.p} in default TFC
- `return: boolean`{: .language-kube }: If the block should convert

{: #moss-growing-callback-examples }

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

{: #lamp-methods }

#### Extra Methods

- `.lightLevel(i: number)`{: .language-kube #lamp-light-level }: Accepts a number, in the range [1, 15], sets the light level the lamp gives off when lit, defaults to `15`
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube #lamp-extend-props }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.models(models: BiConsumer<LampModelType, ModelGenerator>)`{: .language-kube #lamp-models }: Sets the model generation of the lamp. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following properties:
    - `on`: A boolean. If the model type represents a lit state
    - `hanging`: A boolean. If the model type represents a hanging state

{: #lamp-example }

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

{: #stationary-berry-bush-methods }

#### Extra Methods

- `.lifecycle(month: Month, lifecycle: Lifecycle)`{: .language-kube #stationary-bush-lifecycle }: Sets the bush's lifecycle for a particular month, defaults to `dormant`{:.e} for every month, accepts a month for the first parameter, and either `healthy`{:.e}, `dormant`{:.e}, `fruiting`{:.e}, or `flowering`{:.e} for the second
- `.productItem(item: Consumer<ItemBuilder>)`{: .language-kube #stationary-bush-product-item-0 }: Sets the properties of the bush's product item, the item gotten by right clicking a bush when it is fruiting
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube #stationary-bush-extend-props }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.productItem(item: ResourceLocation)`{: .language-kube #stationary-bush-product-item-1 }: Sets the bush's product item to be an existing item, will prevent the other product item from being created
- `.model(lifecycle: Lifecycle, stage: number, modelGenerator: Consumer<ModelGenerator>)`{: .language-kube #stationary-bush-model }: Sets the model for the given lifecycle and stage, stage can be one of `0`{:.n}, `1`{:.n}, and `2`{:.n}
- `.models(models: TriConsumer<Lifecycle, number, ModelGenerator>)`{: .language-kube #stationary-bush-models }: Sets the model for all lifecycle and stage combinations
- `.texture(lifecycle: Lifecycle, stage: number, texture: String)`{: .language-kube #stationary-bush-texture }: Sets the texture for the given lifecycle and stage

Additionally, this will register a climate range with the same id as the block, it can be set through the [data event]({% link kubejs_tfc/1.20.1/data.md %}#climate-ranges)

{: #stationary-berry-bush-example }

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

{: #spreading-berry-bush-methods }

#### Extra Methods

- `.maxHeight(i: number)`{: .language-kube #spreading-bush-max-height }: Sets the maximum number of blocks the bush may climb, defaults to `3`{:.n}
- `.cane(cane: Consumer<SpreadingCaneBlockBuilder>)`{: .language-kube #spreading-bush-cane }: Sets the properties of the cane block of this bush. Has the same id as the bush, but with `_cane` appended to the end. Has the same methods as the default block builder and:
    - `.model(lifecycle: Lifecycle, stage: number, modelGenerator: Consumer<ModelGenerator>)`{: .language-kube #cane-bush-model }: Sets the model for the given lifecycle and stage. Stage can be be one of `0`{:.n}, `1`{:.n}, and `2`{:.n}
    - `.models(models: TriConsumer<Lifecycle, number, ModelGenerator>)`{: .language-kube #cane-bush-models }: Sets the model for all lifecycle and stage combinations
    - `.texture(lifecycle: Lifecycle, stage: number, texture: String)`{: .language-kube #cane-bush-texture-0 }: Sets the cane texture for the given lifecycle and stage
    - `.texture(lifecycle: Lifecycle, stage: number, caneTexture: String, bushTexture)`{: .language-kube #cane-bush-texture-1}: Sets the cane and bush texture for the given lifecycle and stage

Additionally, this will register a climate range with the same id as the block, it can be set through the [data event]({% link kubejs_tfc/1.20.1/data.md %}#climate-ranges)

{: @spreading-berry-bush-example }

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

{: #dirt-methods }

#### Extra Methods

- `.grass(grass: Consumer<ConnectedGrassBlockBuilder>)`{: .language-kube #dirt-grass }: Sets the properties of the dirt block's grass block. Has the same id as the dirt block but with `_grass` appended to the end. Has the following methods:
    - Those of the default block builder
    - `.uniqueDirtTexture()`{: .language-kube #dirt-grass-unique-texture}: Textures the side of the grass block with a texture path based on the grass block instead of the dirt block
    - `.models(models: BiConsumer<GrassModelPart, ModelGenerator>)`{: .language-kube #dirt-grass-models }: Sets the model generation of the grass block. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following properties:
        - `snowy`: A boolean. If the model part in operation represents a snowy state
        - `side`: A boolean. If the model part in operation represents a side part
        - `top`: A boolean. If the model part in operation represents a top part
        - `bottom`: A boolean. If the model part in operation represents a bottom part
- `.path(path: Consumer<TFCPathBlockBuilder>)`{: .language-kube #dirt-path }: Creates and sets the properties of the dirt block's path bloc. Has the same id as the dirt block but with `_path` appended to the end. Has the same methods as the default block builder
- `.farmland(farmland: Consumer<TFCFarmlandBlockBuilder>)`{: .language-kube #dirt-farmland }: Creates and sets the properties of the dirt block's farmland block. Has the same id as the dirt block but with `_farmland` appended to the end. Has the following methods:
    - Those of the default block builder
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube #dirt-farmland-extend-properties }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.rooted(rooted: Consumer<TFCRootedDirtBlockBuilder>)`{: .language-kube #dirt-rooted }: Creates and sets the properties of the dirt block's rooted dirt block. Has the same id as the dirt block but with `_rooted` appended to the end. Has the same methods as the default block builder
- `.mud(mud: Consumer<BlockBuilder>)`{: .language-kube #dirt-mud }: Creates and sets the properties of the dirt block's mud block. Has the same id as the dirt block but with `_mud` appended to the end

{: #dirt-example }

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

{: #wild-crop-methods }

#### Extra Methods

- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube #wild-crop-extend-properties }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.type(type: Type)`{: .language-kube #wild-crop-type }: Sets the type of wild crop block to be used, available options are `default`{:.e}, `double`{:.e}, `flooded`{:.e}, and `spreading`{:.e}, defaults to `default`{:.e}
- `.spreadingFruitBlock(fruitBlock: ResourceLocation)`{: .language-kube #wild-crop-fruit-block }: Sets the block to be used as the fruit block if the wild crop's type is `spreading`{:.e}, defaults to `minecraft:honey_block`
- `.seeds(seedItem: ResourceLocation)`{: .language-kube #wild-crop-seeds }: Sets the 'seed' item to be used in the auto-generated loot table
- `.food(foodItem: ResourceLocation)`{: .language-kube #wild-crop-food }: Sets the 'food' item to be used in the auto-generated loot table
- `.deadModel(model: String)`{: .language-kube #wild-crop-dead-model }: Sets the model to use when the crop is dead/immature and its type is `default`{:.e} or `flooded`{:.e}
- `.doubleDeadModels(topModel: String, bottomModel: String)`{: .language-kube #wild-crop-double-models }: Sets the models to use when the crop is dead/immature and sets the crop's type to `double`{:.e}
- `.spreadingDeadModels(coreModel: String, sideModel: String)`{: .language-kube #wild-crop-spreading-dead-models }: Sets the models to use when the crop is dead/immature and sets the crop's type to `spreading`{:.e}

{: #wild-crop-example }

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

{: #default-crop-methods }

#### Extra Methods

- `.stages(i: number)`{: .language-kube #crop-stages }: Sets the number of growth stages the block has, should be a number between `1`{:.n} and `12`{:.n}, defaults to `8`{:.n}
- `.deadBlock(deadCrop: Consumer<DeadCropBlockBuilder>)`{: .language-kube #crop-dead }: Sets the properties of the crop's dead block. Accepts a consumer with the same methods as the default block builder and:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.models(models: BiConsumer<DeadModelVariant, ModelGenerator>)`{: .language-kube }: Sets the model generation for the dead crop. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following methods:
        - `.variant()`{: .language-kube }: A string. The variant key used for the model in the blockstate file
        - `.mature()`{: .language-kube }: A boolean. If the variant in operation represents a mature state
- `.seedItem(seedItem: Consumer<SeedItemBuilder>)`{: .language-kube #crop-seed-item }: A consumer for setting the properties of the block's seed item
- `.productItem(productItem: Consumer<ItemBuilder>)`{: .language-kube #crop-product-item-0 }: A consumer for setting the properties of the block's product item
- `.existingProductItem(productItem: ResourceLocation)`{: .language-kube #crop-product-item-1 }: Sets the crop's 'product' item to be an existing item, will be prevent the other product item from existing
- `.nutrient(nutrient: NutrientType)`{: .language-kube #crop-nutrient }: Sets the nutrient the crop consumes, available options are `nitrogen`{:.e}, `phosphorous`{:.e} , and `potassium`{:.e}, defaults to `nitrogen`{:.e}
- `.textureAll(id: String, texture: String)`{: .language-kube #crop-texture-all }: Sets the crop's texture for the id for all growth stages
- `.model(model: String)`{: .language-kube #crop-model-0 }: Sets the crop's model for all growth stages
- `.setModel(gen: Consumer<ModelGenerator>)`{: .language-kube #crop-model-1 }: Sets the crop's model for all growth stages
- `.setModel(i: number, gen: Consumer<ModelGenerator>)`{: .language-kube #crop-model-2 }: Sets the crop's model for a specific growth stage
- `.model(i: number, model: String)`{: .language-kube #crop-model-3 }: Sets the crop's model for a specific growth stage
- `.texture(texture: String)`{: .language-kube crop-texture-0 }: Sets the crop's `crop`{:.s} texture for all growth stages
- `.textureAt(i: number, id: String, texture: String)`{: .language-kube #crop-texture-1 }: Textures a specific key for the given stage
- `.textureAt(i: number, texture: String)`{: .language-kube #crop-texture-2 }: Sets the crop's `crop`{:.s} texture for the given growth stage
- `.textures(textures: JsonObject)`{: .language-kube #crop-textures-0 }: Sets the crop's textures for all growth stages
- `.textures(i: number, textures: JsonObject)`{: .language-kube #crop-textures-1 }: Sets the crop's textures for the given growth stage
- `.growthModifier(d: number)`{: .language-kube #crop-growth-modifier }: Sets the growth modifier of the crop. A higher value will slow growth
- `.growthModifierSupplier(mod: Supplier<Double>)`{: .language-kube #crop-growth-modifier-supplier }: Sets the growth modifier of the crop as a supplier. A higher value will slow growth
- `.expiryModifier(d: number)`{: .language-kube #crop-expiry-modifier }: Sets the expiry modifier of the crop. A higher value will slow death
- `.expiryModifierSupplier(mod: Supplier<Double>)`{: .language-kube #crop-expiry-modifier-suppler }: Sets the expiry modifier of the crop as a supplier. A higher value will slow death

Additionally this will register a climate range with the same id as the block, it can be set through the [data event]({% link kubejs_tfc/1.20.1/data.md %}#climate-ranges)

{: #default-crop-example }

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

{: #double-crop-method }

#### Extra Methods

- `.stages(i: number)`{: .language-kube #double-crop-stages }: Sets the number of growth stages the block has, should be a number between `1`{:.n} and `6`{:.n}, defaults to `4`{:.n}
- `.doubleStages(i: number)`{: .language-kube #double-crop-double-stages }: Sets the number of stages the crop has in its top state, should be a number between `1`{:.n} and `6`{:.n}, defaults to `4`{:.n}
- `.requiresStick(required: boolean)`{: .language-kube #double-crop-requires-stick }: Determines if the crop needs a stick to grow
- `.deadBlock(deadCrop: Consumer<DeadCropBlockBuidler>)`{: .language-kube #double-crop-dead-block }: Sets the properties of the crop's dead block. Accepts a consumer with the same methods as the default block builder and:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.models(models: BiConsumer<DeadModelVariant, ModelGenerator>)`{: .language-kube }: Sets the model generation for the dead crop. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following methods:
        - `.variant()`{: .language-kube }: A string. The variant key used for the model in the blockstate file
        - `.mature()`{: .language-kube }: A boolean. If the variant in operation represents a mature state
        - `.bottom()`{: .language-kube }: A boolean. If the variant in operation represents a bottom state
        - `.stick()`{: .language-kube }: A boolean. If the variant in operation represents a a state with `stick=true`. Only relevant if `.requiresStick(true)`{: .language-kube } has been called

{: #double-crop-example }

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_double_crop', 'tfc:double_crop')
        .requiresStick(true)
        .deadBlock(dead => {
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

{: #spreading-crop-methods }

#### Extra Method

- `.fruitBlock(fruitBlock: ResourceLocation)`{: .language-kube #spreading-crop-fruit-block }: Sets the block that will be used as the block's fruit block, defaults to `minecraft:honey_block`

{: .notice #spreading-crop-side-texture-notice }
The texture of the side models can be set by calling `.texture("side", "<texture>")`{: .language-kube }

{: #spreading-crop-example }

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

{: #flooded-crop-example }

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

{: #pickable-crop-methods }

#### Extra Methods

- `.fruit(fruit: ResourceLocation)`{: .language-kube #pickable-crop-fruit }: Sets the item the player will be given when they pick the block
- `.matureFruit(fruit: ResourceLocation)`{: .language-kube #pickable-crop-mature-fruit }: Sets the item the player will be given when they pick the block and the crop is mature, defaults to `minecraft:apple`

{: #pickable-crop-example }

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

{: #support-methods }

#### Extra methods

- `.horizontal(horizontalSupport: Consumer<HorizontalSupportBlockBuilder>)`{: .language-kube #support-horizontal }: Allows for editing of the properties of the horizontal block
    - The consumer has the same methods as the default block builder and one additional one:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube #support-extend-props }: A consumer, that sets some of TFC's [extended properties](#extended-properties)

{: #support-example }

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

{: #anvil-methods }

#### Extra Methods

- `.tier(i: number)`{: .language-kube #anvil-tier }: Sets the tier of the anvil, defaults to `0`{:.n}
- `.defaultName(name: Component)`{: .language-kube #anvil-default-name }: Sets the default name of the anvil screen, defaults to `Text.translatable('tfc.block_entity.anvil')`{: .language-kube }
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube #anvil-extend-props }: A consumer, that sets some of TFC's [extended properties](#extended-properties)

{: #anvil-example }

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

{: #axle-methods }

#### Extra Methods

- `.axleTexture(texture: String)`{: .language-kube #axle-axle-texture}: Sets the texture the axle will be rendered with
- `.windmill(windmill: Consumer<WindmillBlockBuilder>)`{: .language-kube #axle-windmill }: Sets the properties of the axle's windmill block
    - The consumer has the same methods as the default block builder and one additional one:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.waterWheel(waterWheel: Consumer<WaterWheelBlockBuilder>)`{: .language-kube #axle-water-wheel }: Creates and sets the properties of the axle's water wheel block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.texture(texture: string)`{: .language-kube }: Sets the texture the water wheel will use, the path is relative to the `/textures/entity/water_wheel/`{:.language-fs} subdirectory
    - `.textureRaw(texture: String)`{: .language-kube}: Sets the texture the water wheel will use, the path is relative to the `/textures/`{:.language-fs} subdirectory
- `.gearBox(gearBox: Consumer<GearBoxBlockBuilder>)`{: .language-kube #axle-gear-box }: Creates and sets the properties of the axle's gear box block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.models(models: BiConsumer<GearBoxModelType, ModelGenerator>)`{: .language-kube }: Sets the model generation of the gear box. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following method:
        - `.port()`{: .language-kube }: A boolean. If the model type in operation represents a port (open) state
- `.clutch(clutch: Consumer<ClutchBlockBuilder>)`{: .language-kube #axle-clutch }: Creates and sets the properties of the axle's clutch block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
    - `.models(models: BiConsumer<ClutchModelType, ModelGenerator>)`{: .language-kube }: Sets the model generation of the clutch. Accepts a callback with two parameters. The second parameter is a model generator, the first has the following method:
        - `.powered()`{: .language-kube }: A boolean. If the model type in operation represents a powered state
- `.bladedAxle(bladed: Consumer<BladedAxleBlockBuilder>)`{: .language-kube #axle-bladed-axle }: Creates and sets the properties of the axle's bladed axle block
    - The consumer has the same methods as the default block builder plus:
    - `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube }: A consumer, that sets some of TFC's [extended properties](#extended-properties)
- `.extendedProperties(props: Consumer<ExtendedPropertiesJS>)`{: .language-kube #axle-extend-props }: A consumer, that sets some of TFC's [extended properties](#extended-properties)

{: #axle-example }

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

{: #encased-axle-example }

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

{: #log-methods }

#### Extra Methods

- `.stripped(builder: @Nullable Consumer<LogBlockBuilder>)`{: .language-kube #log-stripped }: Sets the properties of the stripped log variant, consumer has same methods as this block except for this method. May pass in `null`{:.p} to remove the stripped block
- `.useFullBlockForItemModel()`{: .language-kube #log-full-item-model }: Makes the autogenerated item model use the model of the block instead of a custom texture

{: #log-example }

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

{: #torch-methods }

#### Extra Methods

- `.deadItem(item: @Nullable Consumer<ItemBuidler>)`{: .language-kube #torch-dead-item }: Sets the properties of the dead/unlit item, may be `null`{:.p} to not have a dead/unlit item
- `.decayLength(i: number)`{: .language-kube #torch-decay-length }: Sets the time, in calendar ticks, the torch will burn for. Defaults to the value in TFC's server config value for torch burn length
- `.decayLengthSupplier(length: Supplier<Integer>)`{: .language-kube #torch-decay-length-supplier }: Sets the supplier for the time, in calendar ticks, the torch will burn for. Defaults to using TFC's server config value for torch burn length
- `.flameParticle(particle: String)`{: .language-kube #torch-flame-particle }: Sets the flame particle of the torch, may be null to not have a flame particle. Defaults to `minecraft:flame`[^1]
- `.smokeParticle(particle: String)`{: .language-kube #torch-smoke-particle }: Sets the smoke particle of the torch, may be null to not have a smoke particle. Defaults to `minecraft:smoke`[^1]
- `.dead(dead: Consumer<DeadTorchBuidler>)`{: .language-kube #torch-dead }: Sets the properties of the dead/unlit block. Accepts a consumer with all the methods of the default block builder
- `.wall(wall: Consumer<WallTorchBuilder>)`{: .language-kube #torch-wall }: Sets the properties of the wall block. Accepts a consumer with the methods of the default block builder
- `.deadWall(deadWall: Consumer<DeadWallTorchBuidler>)`{: .language-kube #torch-dead-wall }: Sets the properties of the dead/unlit wall block. Accepts a consumer with the methods of the default block builder
- `.deadModel(model: String)`{: .language-kube #torch-dead-model }: Sets the model for the dead block and item

{: #torch-example }

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_torch', 'tfc:torch')
        .decayLength(120000) // 6 in game days
        .flameParticle('minecraft:soul_fire_flame')
        .dead(dead => {
            dead.lootTable = (builder) => {
                builder.addPool(pool => {
                    pool.survivesExplosion();
                    pool.addItem('3x minecraft:glowstone');
                })
            }
        })
})
```

### Sapling

Creates a new TFC sapling block

Inherits the methods of the default block builder

**Type**: `tfc:sapling`

{: #sapling-methods }

#### Extra Methods

- `.placeableOnSand()`{: .language-kube #sapling-place-on-sand }: Allows the sapling to be placed on sand
- `.growthDays(i: number)`{: .language-kube #sapling-growth-days }: Sets the number of days it takes for the sapling to grow. Defaults to `8`{:.n}
- `.growthDaysSupplier(days: Supplier<Integer>)`{: .language-kube #sapling-growth-days-supplier }: Sets the number of days, via a supplier, it takes for the sapling to grow. Defaults to `() => 8`{: .language-kube }
- `.features(normal: ResourceLocation, oldGrowth: ResourceLocation)`{: .language-kube #sapling-features-0 }: Sets the normal and old growth features of the sapling. Defaults to `minecraft:oak` for both
- `.features(trees: ResourceLocation)`{: .language-kube #sapling-features-1 }: Sets the normal and old growth features of the sapling to the same feature. Defaults to `minecraft:oak`

{: #sapling-example }

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_sapling', 'tfc:sapling')
        .features('kubejs:tree/coconut')
        .placeableOnSand()
        .growthDays(22)
})
```

### Leaves

Creates a new TFC leaves block

Inherits the methods of the default block builder

**Type**: `tfc:leaves`

{: #leaves-methods }

#### Extra Methods

- `.autumnIndex(i: number)`{: .language-kube #leaves-autumn-index }: Sets the vertical coordinate, in the range [0, 255], on TFC's `foliage_fall` colormap for leaves. Defaults to `0`{:.n}
- `.fallenLeaves(fallenLeaves: @Nullable Consumer<FallenLeavesBlockBuidler>)`{: .language-kube #leaves-fallen }: Sets the properties of the fallen leaves block. May pass null to not have a fallen leaves block
    - The consumer has the same methods as the default block builder and:
    - `.models(models: BiConsumer<FallenLeafModelType, ModelGenerator>)`{: .language-kube }: Sets the model generation of the fallen leaves block. Accepts a callback with two parameters. The second parameter is a model generator and the first has the following properties:
        - `.height`{: .language-kube }: A number, the height in pixels of the state
        - `.layers`{: .language-kube }: A number, the `layers` block state property value of the state
    - `.noDynamicTinting()`{: .language-kube #leaves-no-dynamic-tinting }: Removes seasonal tinting completely
- `.twig(id: ResourceLocation)`{: .language-kube #leaves-twig }: Sets the twig block to be placed when a natural leaf is broken
- `.seasonalColors(seasonalColors: boolean)`{: .language-kube #leaves-seasonal-colors}: If the tint of the leaves should change seasonally. Defaults to `true`{:.p}
- `.noDynamicTinting()`{: .language-kube #leaves-no-dynamic-tinting }: Removes seasonal tinting completely

{: #leaves-example }

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_leaves', 'tfc:leaves')
        .seasonalColors(false)
        .fallenLeaves(null)
})
```

### FirmaLife Cheese Wheel

Creates a new cheese wheel block

Inherits the methods of the default block builder

**Type**: `firmalife:cheese_wheel`

{: #cheese-wheel-methods }

#### Extra Method

- `.sliceItem(slice: Consumer<ItemBuilder>)`{: .language-kube #cheese-wheel-slice }: Sets the properties of the cheese wheel's slice item
- `.freshInsideTexture(tex: String)`{: .language-kube #cheese-wheel-fresh-inside }: Sets the inside texture when the cheese is fresh
- `.agedInsideTexture(tex: String)`{: .language-kube #cheese-wheel-aged-inside }: Sets the inside texture when the cheese is aged
- `.vintageInsideTexture(tex: String)`{: .language-kube #cheese-wheel-vintage-inside }: Sets the inside texture when the cheese is vintage
- `.barrelRackModel(model: String)`{: .language-kube #cheese-wheel-barrel-rack-model }: Sets the barrel rack model to use. Defaults to `tfc:block/barrel_rack`

{: #cheese-wheel-example }

#### Example

```js
StartupEvents.registry('block', event => {
    event.create('my_cheese_wheel', 'firmalife:cheese_wheel')
})
```

### Extended Properties

Some of TFC's blocks have extended properties which allow the block properties object passed into them to define more of their behavior, builders for these types of blocks have a method with a consumer that allows you to modify some of those properties

- `.flammable(flammability: number, fireSpreadSpeed: number)`{: .language-kube #extend-props-flammable }: Sets the flammability and fire spread speed of the block
- `.pathType(pathType: BlockPathTypes)`{: .language-kube #extend-props-path-type }: Sets the block's path type, used by mobs to determine if they may walk over it or not
- `.adjacentPathType(pathType: BlockPathTypes)`{: .language-kube #extend-props-adjacent-path-types }: Sets the path type the block should 'project' onto adjacent blocks
- `.enchantPower(f: number)`{: .language-kube #extend-props-enchant-power }: Sets the block's enchant power
- `.enchantPowerFunction(function: Function<BlockState, Double>)`{: .language-kube #extend-props-enchant-power-function }: Sets the function the block uses to determine its enchant power based on its block state
- `.noCollision()`{: .language-kube #extend-props-no-collision }: Removes the block's collision
- `.noOcclusion()`{: .language-kube #extend-props-no-occlusion }: Makes the block not occlude blocks behind it
- `.friction(f: number)`{: .language-kube #extend-props-friction }: Sets the friction of the block
- `.speedFactor(f: number)`{: .language-kube #extend-props-speed-factor }: Sets the speed factor of the block
- `.jumpFactor(f: number)`{: .language-kube #extend-props-jump-factor }: Sets the jump factor of the block
- `.sound(sound: SoundType)`{: .language-kube #extend-props-sound }: Sets the sound type the block uses
- `.lightLevel(lightLevel: Function<BlockState, number>)`{: .language-kube #extend-props-light-level }: Sets the light level, in the range [0, 15], of the block, as a function of its state
- `.strength(destroyTime: number, explosionResistance: number)`{: .language-kube #extend-props-strength-0 }: Sets the destroy time and explosion resistance of the block
- `.instabreak()`{: .language-kube #extend-props-instabreak }: Makes the block instabreak
- `.strength(f: number)`{: .language-kube #extend-props-strength-1 }: Sets the destroy time and explosion resistance of the block
- `.randomTicks()`{: .language-kube #extend-props-random-ticks }: Sets the block to random tick
- `.dynamicShape()`{: .language-kube #extend-props-dynamic-shape }: Marks the block as having a dynamic shape
- `.noLootTable()`{: .language-kube #extend-props-no-loot-table }: Marks the block as having no loot table
- `.dropsLike(block: Supplier<Block>)`{: .language-kube #extend-props-drops-like }: makes the block drop like the supplied block
- `.air()`{: .language-kube #extend-props-air }: Marks the block as being air-like
- `.isValidSpawn(isValidSpawn: BlockBehaviour$StateArgumentPredicate<EntityType<?>>)`{: .language-kube #extend-props-is-valid-spawn }: Determines if an entity may spawn on the block
- `.isRedstoneConductor(conductor: BlockBehaviour$StatePredicate)`{: .language-kube #extend-props-is-redstone-conductor }: Determines if the block is a redstone conductor
- `.alwaysIsRedstoneConductor()`{: .language-kube #extend-props-always-redstone-conductor }: Sets the block to always be a redstone conductor
- `.neverIsRedstoneConductor()`{: .language-kube #extend-props-never-redstone-conductor }: Sets the block to never be a redstone conductor
- `.isSuffocating(isSuffocating: BlockBehaviour$StatePredicate)`{: .language-kube #extend-props-is-suffocating }: Determines if the block is suffocating
- `.alwaysSuffocating()`{: .language-kube #extended-props-always-suffocating }: Sets the block as always suffocating
- `.neverSuffocating()`{: .language-kube #extended-props-never-suffocating }: Sets the block as never suffocating
- `.isViewBlocking(isBlocking: BlockBehaviour$StatePredicate)`{: .language-kube #extend-props-is-view-blocking }: Determines if the block is view blocking
- `.alwaysViewBlocking()`{: .language-kube #extend-props-always-view-blocking }: Sets the block as always view blocking
- `.neverViewBlocking()`{: .language-kube #extend-props-never-view-blocking }: Sets the block as never view blocking
- `.hasPostProcess(hasProcess: BlockBehaviour$StatePredicate)`{: .language-kube #extend-props-has-post-process }: Determines if the block has post processing during block placement
- `.alwaysPostProcess()`{: .language-kube #extend-props-always-post-process }: Sets the block to always be post processed
- `.neverPostProcess()`{: .language-kube #extend-props-never-post-process }: Sets the block to never be post processed
- `.emissiveRendering(emissive: BlockBehaviour$StatePredicate)`{: .language-kube #extended-props-emissive }: Determines if the block has emissive rendering
- `.alwaysEmissive()`{: .language-kube #extend-props-always-emissive }: Sets the block to always have emissive rendering
- `.neverEmissive()`{: .language-kube #extend-props-never-emissive }: Sets the block to never have emissive rendering
- `.requiresCorrectToolForDrops()`{: .language-kube #extend-props-requires-correct-tool }: Sets the block to require a 'correct' tool (as determined by a tag) for it to drops its loot table
- `.mapColor(color: MapColor)`{: .language-kube #extend-props-map-color-0 }: Sets the map color of the block
- `.mapColor(color: Function<BlockState, MapColor>)`{: .language-kube #extend-props-map-color-1 }: Sets the map color of the block per state
- `.destroyTime(f: number)`{: .language-kube #extend-props-destroy-time }: Sets the destroy time of the block
- `.explosionResistance(f: number)`{: .language-kube #extend-props-explosion-resistance }: Sets the explosion resistance of the block
- `.ignitedByLava()`{: .language-kube #extend-props-ignited-by-lava }: Sets the block to be ignited by lava
- `.forceSolidOn()`{: .language-kube #extend-props-force-solid-on }: Forces the block to be solid (?)
- `.forceSolidOff()`{: .language-kube #extend-props-force-solid-off }: Forces the block to be non-solid (?)
- `.pushReaction(reaction: PushReaction)`{: .language-kube #extend-props-push-reaction }: Sets the block's reaction to being pushed by pistons
- `.offsetType(type: OffsetType)`{: .language-kube #extend-props-offset-type }: Sets the block's hitbox offset type
- `.noParticlesOnBreak()`{: .language-kube #extend-props-no-particles-on-break }: Sets the block to not create any particles when broken
- `.instrument(instrument: NoteBlockInstrument)`{: .language-kube #extend-props-instrument }: Sets the note block instrument the block has
- `.defaultInstrument()`{: .language-kube #extend-props-default-instrument }: Sets the block's not block instrument to be the harp
- `.replaceable()`{: .language-kube #extend-props-replaceable }: Marks the block as being replaceable

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

<a id="firmalife-items"></a>If *FirmaLife* {% include mr.html link='firmalife' %} {% include cf.html link='firmalife' %} is installed, the following types are also available:

- [Watering Can](#firmalife-watering-can)

<a id="precision-prospecting-items"></a>If *Precision Prospecting* {% include mr.html link='precision-prospecting' %} {% include cf.html link='precision-prospecting' %} is installed, the following types are also available:

- [Prospector's Hammer](#precision-prospecting-prospector-hammer)
- [Prospector's Drill](#precision-prospecting-prospector-drill)
- [Mineral Prospector](#precision-prospecting-mineral-prospector)
- [Custom Prospector](#precision-prospecting-custom-prospector)

Additionally, TFC's [tool](#tool-tiers) and [armor](#armor-tiers) tiers are added to KubeJS's tool and armor tier values

### Chisel

Creates a new chisel item

Inherits the methods of other tool builders

**Type**: `tfc:chisel`

{: #chisel-example }

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
> - `item/<name>`{:.language-fs}: The base texture
> - `item/<name>_overlay`{:.language-fs}: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/ceramic/fired_mold/axe_head_overlay.png) for what it should look like
>
> For the example below, the textures would be in `kubejs/textures/item/my_fluid_container.png`{:.language-fs} and `kubejs/textures/item/my_fluid_container_overlay.png`{:.language-fs}
>
> These locations can be changed by setting the `base`{:.s} and `fluid`{:.s} textures using the `.texture(key: String, texture: String)`{: .language-kube } method

{: #fluid-container-methods }

#### Extra Methods

- `.canPlaceLiquid(b: boolean)`{: .language-kube #fluid-container-can-place-liquid }: Determines if the item can place liquids in world, defaults to `false`{:.p}
- `.canPlaceLiquidSource(b: boolean)`{: .language-kube #fluid-container-can-place-liquid-source }: Determines if the the item can place source blocks in world, defaults to `false`{:.p}
- `.capacity(i: number)`{: .language-kube #fluid-container-capacity }: Sets the mB capacity of the item, defaults to `100`{:.n}
- `.fluidTagAccept(tag: String)`{: .language-kube #fluid-container-fluid-tag-accept }: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_jug`
- `.filledDisplayName(c: Component)`{: .language-kube #fluid-container-filled-display-name }: Accepts a text component, sets the display name when the object has a fluid in it, will be overridden by an entry in a lang file if it exists
- `.capacitySupplier(capacity: Supplier<Integer>)`{: .language-kube #fluid-container-capacity-supplier }: Sets the mB supplier capacity of the item, defaults to `() => 100`{: .language-kube }

{: #fluid-container-example }

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

{: #hammer-methods }

#### Extra Method

- `.metalTexture(texture: String)`{: .language-kube #hammer-metal-texture }: Sets the texture of the hammer when in a trip hammer, this is required if you want the hammer to be usable in a trip hammer

{: #hammer-example }

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

{: #javelin-methods }

#### Extra Methods

- `.thrownDamage(f: number)`{: .language-kube #javelin-thrown-damage }: Sets the thrown damage of the javelin, defaults to `0.3`{:.n}
- `.skeletonWeapon()`{: .language-kube #javelin-skeleton-weapon }: Adds the item to the `tfc:skeleton_weapons` item tag
- `.throwingModel(m: String)`{: .language-kube #javelin-throwing-model }: Sets the model to use when throwing the javelin, before release
- `.modelAtPerspective(perspective: ItemDisplayContext, model: String)`{: .language-kube #javelin-model-at-perspective }: Sets the model to use at the specified display context
- `.guiModel(m: String)`{: .language-kube #javelin-gui-model }: Sets the model to use for the `none`{:.e}, `fixed`{:.e}, `ground`{:.e}, and `gui`{:.e} display contexts

{: #javelin-example }

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

{: #mace-example }

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
> - `item/<name>`{:.language-fs}: The base texture
> - `item/<name>_overlay`{:.language-fs}: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/ceramic/fired_mold/axe_head_overlay.png) for what it should look like
>
> For the example below, the textures would be in `kubejs/textures/item/my_mold.png`{:.language-fs} and `kubejs/textures/item/my_mold_overlay.png`{:.language-fs}
>
> These locations can be changed by setting the `base`{:.s} and `fluid`{:.s} textures using the `.texture(key: String, texture: String)`{: .language-kube } method

{: #mold-methods }

#### Extra Methods

- `.capacity(i: number)`{: .language-kube #mold-capacity }: Sets the mB capacity of the mold, defaults to `100`{:.n}
- `.fluidTagAccept(fluidTag: String)`{: .language-kube #mold-fluid-tag-accept }: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_ingot_mold`
- `.capacity(capacity: Supplier<Integer>)`{: .language-kube #mold-capacity-supplier }: Sets the mB capacity supplier of the mold, defaults to `() => 100`{: .language-kube }

<a id="tfccc"></a>If *TFC Casting with Channels* {% include cf.html link='tfc-casting-with-channels' %} is installed, the following method is available

- `.tfcccAllowedInMoldTable(model?: String[])`{: .language-kube #mold-tfccc-allowed-in-mold-table }: Allows the mold to be placed in a mold table
    - *Optional 1st parameter*: A list of strings, may be omitted to not automatically generate a model. If present, there should be 14 strings each with 14 characters in them. See one of the [defaults](https://github.com/lJuanGB/TFCCasting/blob/main/src/main/resources/assets/tfcchannelcasting/models/mold/tfc/ceramic/axe_head_mold.json) for an example of how it should look

{: #mold-example }

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

{: #propick-example }

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

{: #scythe-methods }

#### Extra Method

- `.mineableBlocksTag(blockTag: String)`{: .language-kube #scythe-mineable-blocks-tag }: Sets the block tag that the scythe can properly dig at full speed, defaults to `tfc:mineable_with_scythe`

{: #scythe-example }

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

{: #hoe-example }

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

{: #tool-methods }

#### Extra methods

- `.mineableBlocksTag(blockTag: String)`{: .language-kube #tool-minable-blocks-tag }: Sets the block tag that the 'tool' can properly dig at full speed, defaults to `tfc:mineable_with_knife`
- `.knife()`{: .language-kube #tool-knife }: Adds the item to the `tfc:knives` tag and sets its mineable blocks tag to `tfc:mineable_with_knife`

{: #tool-example }

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

{: #fishing-rod-methods }

#### Extra Methods

- `.fishingStrength(f: number)`{: .language-kube #fishing-rod-strength }: Sets the fishing strength of the rod, defaults to a value based on the tool's tier
- `.castModel(model: String)`{: .language-kube #fishing-rod-cast-model }: Sets the model used when the rod is cast, if not set a default one will be created which will use a texture with the same path as the normal texture with `_cast` appended to the end or the one provided via the `.castTexture(t: String)`{: .language-kube } method
- `.smallBait()`{: .language-kube #fishing-rod-small-bait }: Adds the rod to the correct tag to allow it to hold small bait
- `.largeBait()`{: .language-kube #fishing-rod-large-bait }: Adds the rod to the correct tag to allow it to hold large bait
- `.castTexture(t: String)`{: .language-kube #fishing-rod-cast-texture }: Sets the texture used when the rod is cast out

{: #fishing-rod-example }

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

{: #jar-methods }

#### Extra Methods

- `.placedModel(model: String)`{: .language-kube #jar-placed-model }: Sets the model of the jar when placed, defaults to the item's id
- `.withoutCraftingRemainder()`{: .language-kube #jar-without-crafting-remainder }: Makes it so the jar does not have a crafting remainder

{: #jar-example }

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

{: #glassworking-methods }

#### Extra Method

- `.operation(operation: GlassOperation)`{: .language-kube #glassworking-operation }: Sets the `GlassOperation`{:.e} the item is capable of performing, defaults to `saw`{:.e}

{: #glassworking-example }

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

{: #windmill-blade-methods }

#### Extra Methods

- `.bladeColor(color: Color)`{: .language-kube #windmill-blade-color }: Sets the color of the blade, defaults to `0x000000`{:.n}
- `.bladeTexture(texture: String)`{: .language-kube #windmill-blade-texture }: Sets the texture of the windmill blade, defaults to `tfc:textures/entity/misc/windmill_blade.png`{:.language-fs}. `textures/`{:.language-fs} and `.png`{:.language-fs} must be specified

{: #windmill-blade-example }

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

{: #glassworking-too-methods }

#### Extra Method

- `.operation(operation: GlassOperation)`{: .language-kube #glassworking-tool-operation }: Sets the `GlassOperation`{:.e} the item is capable of performing, defaults to `saw`{:.e}

{: #glassworking-tool-example }

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
> - `item/<name>`{:.language-fs}: The base texture
> - `item/<name>_overlay`{:.language-fs}: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/bucket/glass_bottle_overlay.png) for what it should look like
>
> For the example below, the textures would be in `kubejs/textures/item/my_glass_bottle.png`{:.language-fs} and `kubejs/textures/item/my_glass_bottle_overlay.png`{:.language-fs}
>
> These locations can be changed by setting the `base`{:.s} and `fluid`{:.s} textures using the `.texture(key: String, texture: String)`{: .language-kube } method

{: #glass-bottle-methods }

#### Extra Methods

- `.filledDisplayName(c: Component)`{: .language-kube #glass-bottle-filled-display-name }: Accepts a text component, sets the display name when the object has a fluid in it, will be overridden by an entry in a lang file if it exists
- `.capacity(i: number)`{: .language-kube #glass-bottle-capacity }: Sets the mB capacity of the item, defaults to `100`{:.n}
- `.capacitySupplier(capacity: Supplier<Integer>)`{: .language-kube #glass-bottle-capacity-supplier }: Sets the mB supplier capacity of the item, defaults to `() => 100`{: .language-kube }
- `.breakChance(chance: number)`{: .language-kube #glass-bottle-break-chance }: Sets the break chance, in the range [0, 1], of the bottle
- `.breakChanceSupplier(chance: Supplier<Double>)`{: .language-kube #glass-bottle-break-chance-supplier }: Sets the break chance, in the range [0, 1], supplier of the bottle
- `.fluidTagAccept(tag: String)`{: .language-kube #glass-bottle-fluid-tag-accept }: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_jug`

{: #glass-bottle-example }

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
> - `item/<name>`{:.language-fs}: The base texture
> - `item/<name>_overlay`{:.language-fs}: The overlay texture, defines where the contained fluid will be shown in the item's sprite. See one of [TFC's overlays](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/resources/assets/tfc/textures/item/bucket/glass_bottle_overlay.png) for what it should look like
>
> These locations can be changed by setting the `base`{:.s} and `fluid`{:.s} textures using the `.texture(key: String, texture: String)`{: .language-kube } method as seen in the example

{: #jug-methods }

#### Extra Methods

- `.filledDisplayName(c: Component)`{: .language-kube #jug-filled-display-name }: Accepts a text component, sets the display name when the object has a fluid in it, will be overridden by an entry in a lang file if it exists
- `.capacity(i: number)`{: .language-kube #jug-capacity }: Sets the mB capacity of the item, defaults to `100`{:.n}
- `.capacitySupplier(capacity: Supplier<Integer>)`{: .language-kube #jug-capacity-supplier }: Sets the mB supplier capacity of the item, defaults to `() => 100`{: .language-kube }
- `.fluidTagAccept(tag: String)`{: .language-kube #jug-fluid-tag-accept }: Sets the fluid tag that the item accepts, defaults to `tfc:usable_in_jug`

{: #jug-example }

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

{: #watering-can-example }

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

{: #pros-hammer-example }

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

{: #pros-drill-example }

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

{: #mineral-pros-example }

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

{: #custom-pros-methods }

#### Extra Methods

- `.cooldown(i: number)`{: .language-kube #prospector-cooldown }: Sets the cooldown, in ticks, the item gets when it prospects, defaults to `20`{:.n}
- `.primaryRadius(i: number)`{: .language-kube #prospector-primary-radius-0 }: Sets the primary radius of the prospector, defaults to `10`{:.n}
- `.primaryRadius(supplier: Supplier<Integer>)`{: .language-kube #prospector-primary-radius-1 }: Sets the integer supplier that defines the item's primary radius, defaults to `() => 10`{: .language-kube }
- `.secondaryRadius(i: number)`{: .language-kube #prospector-secondary-radius-0 }: Sets the secondary radius of the prospector, defaults to `10`{:.n}
- `.secondaryRadius(supplier: Supplier<Integer>)`{: .language-kube #prospector-secondary-radius-1 }: Sets the integer supplier that defines the item's secondary radius, defaults to `() => 10`{: .language-kube }
- `.displacement(i: number)`{: .language-kube #prospector-displacement-0 }: Sets the displacement of the prospector, defaults to `0`{:.n}
- `.displacement(supplier: Supplier<Integer>)`{: .language-kube #prospector-displacement-1 }: Sets the integer supplier that defines the item's displacement, defaults to `() => 0`{: .language-kube }
- `.prospectTag(blockTag: String)`{: .language-kube #prospector-prospect-tag }: Sets the block tag that the item can prospect, defaults to `tfc:prospectable`

{: #custom-pros-example }

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

{: #spring-methods }

#### Extra Methods

- `.bubbleParticle(particle: String)`{: .language-kube #spring-bubble-particle }: Accepts a string, the registry name of a particle, sets the bubble particle of the liquid block, defaults to `minecraft:bubble`[^1]. May be null to not have bubble particles
- `.steamParticle(particle: String)`{: .language-kube #spring-steam-particle  }: Accepts a string, the registry name of a particle, sets the steam particle of the liquid block, defaults to `tfc:steam`[^1]. May be null to not have steam particles
- `.healingAmount(f: number)`{: .language-kube #spring-healing-amount }: Sets the amount of health an entity gets while standing in the fluid, defaults to `0.08`{:.n}

[^1]: A full list of all particle types can be attained by running the command `/kubejs dump_registry minecraft:particle_type`{:.language-command} in-game

{: #spring-example }

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
- [Sealable Inventory](#sealable-inventory)

### Inventory

Adds a new inventory attachment that can have its contents restricted based on TFC's size and weight values

**Type**: `tfc:inventory`

{: #inv-attach-def }

#### Definition

- `width: number`{: .language-kube }: A number, determines how wide the container is, identical to KubeJS's default inventory width. Required
- `height: number`{: .language-kube }: A number, determines how tall the container is, identical to KubeJS's default inventory height. Required
- `inputFilter?: Ingredient`{: .language-kube }: An ingredient, a filter for what items are allowed into the container, identical to KubeJS's default inventory `inputFilter`{:.v}. Optional
- `size?: Predicate<Size>`{: .language-kube }: A `Predicate<Size>`{: .language-kube }, a filter for what size of items are allowed into the container. Optional
- `weight?: Predicate<Weight>`{: .language-kube }: A `Predicate<Weight>`{: .language-kube }, a filter for what weight of items are allowed into the container. Optional

{: #inv-attach-example }

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

{: #heat-attach-definition }

#### Definition

- `temperatureCallback: (number | TemperatureCallback)`{: .language-kube }: One of:
    - A number, a constant temperature
    - A callback, dynamically sets the temperature based on the parameters:
        - `be: BlockEnttiyJS`{: .language-kube }: The block entity
        - `currentTemperature: number`{: .language-kube }: The current temperature of the block
        - `calendarTick: number`{: .language-kube }: The current calendar tick during the calculation
        - `calendarTicksSinceLastUpdate: number`{: .language-kube }: The number of calendar ticks that have passed since the calculation was last run
        - `return: number`{: .language-kube }: The new temperature to set the block to. May be negative to keep the previous temperature
- `providesHeat: boolean`{: .language-kube }: A boolean. Optional, defaults to false. If true, the block will provide its temperature to a heat block above it, similar to the charcoal forge

{: #heat-attach-example }

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

{: #calendar-attach-definition }

#### Definition

- `defaultDuration: number`{: .language-kube }: A number. Optional, defaults to `-1`{:.n}. Specifies the duration, in calendar ticks, to time for if a duration is not provided in `.startTiming()`{: .language-kube }

{: #calendar-attach-methods }

#### Methods

- `.startTiming(duration?: number)`{: .language-kube #calendar-attachment-start-timing }: Sets the attachment's tick to the current tick and duration to either the default duration or the duration provided
- `.getCalendarTick()`{: .language-kube #calendar-attachment-get-calendar-tick }: Returns a number. Gets the calendar tick the attachment is timing from
- `.hasDurationElapsed()`{: .language-kube #calendar-attachment-has-duration-elapsed }: Returns a boolean. If current calendar tick is more than `duration` ticks after the calendar tick the attachment is timing from
- `.reset()`{: .language-kube #calendar-attachment-reset }: Sets the calendar tick the attachment is timing from to be `-1`{:.n}, considered to be a 'non-timing' timestamp

{: #calendar-attach-example }

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

### Sealable Inventory

Adds a new inventory attachment can have its content restricted based on their size and weights, can be sealed, and applies a [food trait]({% link kubejs_tfc/1.20.1/events.md %}#custom-food-traits) to items either while sealed or just within the inventory

**Type**: `tfc:sealable_inventory`

{: #seal-inv-attach-definition }

#### Definition

- `width: number`{: .language-kube }: A number, determines how wide the container is, identical to KubeJS's default inventory width. Required
- `height: number`{: .language-kube }: A number, determines how tall the container is, identical to KubeJS's default inventory height. Required
- `inputFilter?: Ingredient`{: .language-kube }: An ingredient, a filter for what items are allowed into the container, identical to KubeJS's default inventory `inputFilter`{:.v}. Optional
- `size?: Predicate<Size>`{: .language-kube }: A `Predicate<Size>`{: .language-kube }, a filter for what size of items are allowed into the container. Optional
- `weight?: Predicate<Weight>`{: .language-kube }: A `Predicate<Weight>`{: .language-kube }, a filter for what weight of items are allowed into the container. Optional
- `requiresSeal?: boolean`{: .language-kube }: A boolean, if the inventory needs to be sealed for the food trait to apply to items within the inventory. Optional, defaults to `true`{:.p}
- `canSeal?: boolean`{: .language-kube }: A boolean, if the inventory can seal. Optional, defaults to `true`{:.p}
- `trait: ResourceLocation`{: .language-kube }: A `ResourceLocation`, the id of the food trait to apply to items within the inventory

{: #seal-inv-attach-methods }

#### Methods

- `.seal()`{: .language-kube #seal-inv-attachment-seal }: Seals the inventory if not already and sealing is enabled
- `.unseal()`{: .language-kube #seal-inv-attachment-unseal }: Unseals the inventory if not already
- `.toggleSeal()`{: .language-kube #seal-inv-attachment-toggle-seal }: Toggles the seal of the inventory if sealing is enabled. Returns the sealed state after toggling
- `.isSealed()`{: .language-kube #seal-inv-is-sealed }: Returns the sealed state of the inventory

{: #seal-inv-attach-examples }

#### Examples

```js
StartupEvents.registry('block', event => {
    event.create('sealable_example')
        .blockEntity(be => {
            be.attach('tfc:sealable_inventory', {
                width: 9,
                height: 1,
                trait: 'kubejs:sealed'
            });
        })
        .rigthClick(e => {
            let { player } = e;
            let be = event.block.entity;
            if (player.shiftKeyDown) {
                be.inventory.toogleSeal();
            } else {
                player.openInventoryGUI(be.inventory, event.block.blockState.name);
            }
        });
    event.create('preserve_example')
        .blockEntity(be => {
            be.attach('tfc:sealable_inventory', {
                width: 9,
                height: 1,
                requiresSeal: false,
                canSeal: false,
                trait: 'kubejs:sealed'
            });
            be.rightClickOpensInventory();
        });
})
```
