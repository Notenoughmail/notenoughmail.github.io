---
layout: page
title: Type Explanations
permalink: /kubejs_tfc/1.20.1/type-explanations/
parent: 1.20.1
grand_parent: KubeJS TFC
desc: Explanations of certain Java types that may be encountered in complex situations
---

# Type Explanations

Lists and describes the methods available on

- [Noise2D](#noise2d)
- [Noise3D](#noise3d)
- [ChunkData](#chunk-data)
- [LayeredArea](#layered-area)
- [NamedRegistryMetal](#namedregistrymetal)
- [NamedRegistryWood](#namedregistrywood)

{: .related #types-note }
> Throughout the docs on this page (and elsewhere for the mod) you may notice some odd type declarations/specifications for JavaScript. This primarily stems from the fact JS/TS types do not perfectly align with Java's type system and a prioritization of displaying the correct Java type over a valid TS type. The most pertinent example is the usage of the Java primitive types `int`{:.p}, `long`{:.p}, `float`{:.p}, and `double`{:.p} instead of JavaScript's `number`{:.p} type
>
> Another thing of note regarding types, is some additional colors for specific categories of Java types with special behavior
>
> - Types colored `#{{ site.colors.enum }}`{:.e} are Java enums which have a defined set of values. They can be wrapped from JavaScript as either a case-insensitive string of a value's name or its ordinal
> - Types colored `#{{ site.colors.func }}`{:.f} are Java functional interfaces. They can be wrapped from javascript as a function or callback with the appropriate arguments. See the [Rhino docs](https://rhino.github.io/tutorials/scripting_java/#javascript-functions-as-java-interfaces), any moderately sized modpack, or many of the examples here for examples of this

## Noise2D

[`Noise2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Noise2D.java) is TFC's base type for noise functions with two dimensions. It has the following methods:

- `.noise(x: double, z: double): Noise2D`{: .language-kube-20 #noise2d-noise }: Gets the value of the noise at the given x-z point
- `.octaves(octaves: int): Noise2D`{: .language-kube-20 #noise2d-octaves }: Applies an octave function to the noise, overlaying weaker, more spread copies of the noise on top of itself
- `.ridged(): Noise2D`{: .language-kube-20 #noise2d-ridged }: Creates a ridged noise using absolute values. Expects the noise's value to be {% in_range -1,1 %}
- `.abs(): Noise2D`{: .language-kube-20 #noise2d-abs }: Takes the absolute value of the function
- `.terraces(levels: int): Noise2D`{: .language-kube-20 #noise2d-terraces }: Creates 'terraces' by taking the nearest level and rounding. Expects the noise's value to be {% in_range -1,1 %}
- `.spread(scaleFactor: double): Noise2D`{: .language-kube-20 #noise2d-spread }: Scales the input dimension of the noise by the given scale factor
- `.scaled(min: double, max: double): Noise2D`{: .language-kube-20 #noise2d-spread-2 }: Maps the output value, expected to be {% in_range -1,1 %}, to the given min and max values
- `.scaled(oldMin: double, oldMax: double, min: double, max: double): Noise2D`{: .language-kube-20 #noise2d-spread-4 }: Re-scales the output of the noise to a new range
- `.affine(scale: double, shift: double): Noise2D`{: .language-kube-20 #noise2d-affine }: Scales then shifts the noise output
- `.warped(warp: OpenSimplex2D): Noise2D`{: .language-kube-20 #noise2d-warp }: Uses the `FastNoiseLite` of the simplex noise to domain warp this noise
- `.clamped(min: double, max: double): Noise2D`{: .language-kube-20 #noise2d-clamp }: Clamps the noise to the given range
- `.add(noise: Noise2D): Noise2D`{: .language-kube-20 #noise2d-add }: Sums this noise and the other
- `.lazyProduct(other: Noise2D): Noise2D`{: .language-kube-20 #noise2d-lazy-product }: Multiplies the two noises
- `.map(mappingFunction: Function<double, double>): Noise2D`{: .language-kube-20 #noise2d-map }: Maps the output of this noise by the given function
- `.transpose(): Noise2D`{: .language-kube-20 #noise2d-transpose }: Swaps the input axes
- `.rotate(angle: double): Noise2D`{: .language-kube-20 #noise2d-rotate }: Rotates the input axes by the given angle (in degrees)

### OpenSimplex2D

[`OpenSimplex2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/OpenSimplex2D.java) is an implementation of [`Noise2D`](#noise2d) which uses `FastNoiseLite`'s `OpenSimplex` noise type.

### Cellular2D

[`Cellular2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Cellular2D.java) is an implementation of [`Noise2D`](#noise2d) specialized to have polygonal blobs of constant value, instead of smooth, constantly changing values. It has these additional methods:

- `.then(func: Function<Cell, double>): Noise2D`{: .language-kube-20 #cellular2d-then }: Converts the `Cell` to value via a function
- `.cell(x: double, z: double): Cell`{: .language-kube-20 #cellular2d-cell }: Gets the `Cell` at the given x-z point. `Cell` is an object with the following methods
    - `.x()`{: .language-kube-20 }: The x 'coordinate' of the center of this cell
    - `.y()`{: .language-kube-20 }: The y 'coordinate' of the center of this cell
    - `.cx()`{: .language-kube-20 }: The x 'coordinate' of this cell
    - `.cy()`{: .language-kube-20 }: The y 'coordinate' of this cell
    - `.f1()`{: .language-kube-20 }: The normalized distance from the center of a cell
    - `.f2()`{: .language-kube-20 }: The normalized distance from the center of a edge of a cell
    - `.noise()`{: .language-kube-20 }: The noise value of the cell

## Noise3D

[`Noise3D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Noise3D.java) is TFC's base type for noise functions with with tree dimensions. It has the following methods:

- `.noise(x: double, y: double, z: double): Noise3D`{: .language-kube-20 #noise3d-noise }: Gets the value of noise at the give x-y-z point
- `.octaves(octaves: int): Noise3D`{: .language-kube-20 #noise3d-octaves }: Applies an octave function to this noise, overlaying weaker, more spread out copies of the noise on top of itself
- `.spread(scaleFactor: double): Noise3D`{: .language-kube-20 #noise3d-spread }: Scales the input dimensions of the noise by the given scale factor
- `.scaled(min: double, max: double): Noise3D`{: .language-kube-20 #noise3d-scaled-2 }: Maps the output value, expected to be {% in_range -1,1 %}, to the given min and max values
- `.scaled(oldMin: double, oldMax: double, min: double, max: double): Noise3D`{: .language-kube-20 #noise3d-scaled-4 }: Re-scales the output of the noise to a new range
- `.warped(warp: OpenSimplex3D): Noise3D`{: .language-kube-20 #noise3d-warp }: Uses the `FastNoiseLite` of the simplex noise to domain warp this noise
- `.transposeXZ(): Noise3D`{: .language-kube-20 #noise3d-transpose-x-z }: Swaps the x and z axes
- `.transposeXY(): Noise3D`{: .language-kube-20 #noise3d-transpose-x-y }: Swaps the x and y axes
- `.transposeYZ(): Noise3D`{: .language-kube-20 #noise3d-transpose-y-z }: Swaps the y and z axes
- `.dissolve(yNoise: Noise2D): Noise2D`{: .language-kube-20 #noise3d-dissolve}: Dissolves the `Noise3D`{:.f} to a [`Noise2D`](#noise2d) by using the provided `Noise2D`{:.f} as the input y-value at a given x-z coordinate
- `.rotateX(angle: double): Noise3D`{: .language-kube-20 #noise3d-rotate-x }: Rotates the noise around the x axis
- `.rotateY(angle: double): Noise3D`{: .language-kube-20 #noise3d-rotate-y }: Rotates the noise around the y axis
- `.rotateZ(angle: double): Noise3D`{: .language-kube-20 #noise3d-rotate-z }: Rotates the noise around the z axis

### OpenSimplex3D

[`OpenSimplex3D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/OpenSimplex3D.java) is an implementation of [`Noise3D`](#noise3d) which uses `FastNoiseLite`'s `OpenSimplex` noise type

### Cellular3D

[`Cellular3D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Cellular3D.java) is an implementation of [`Noise3D`](#noise3d) specialized to have polyhedral blobs of constant value, instead of smooth, constantly changing values. It has these additional methods:

- `.cell(x: double, y: double, z: double): Cell`{: .language-kube-20 #cellular3d-cell }: Gets the `Cell` at the given x-y-z point. `Cell` is an object with the following methods:
    - `.x()`{: .language-kube-20 }: The x 'coordinate' of the cell
    - `.y()`{: .language-kube-20 }: The y 'coordinate' of the cell
    - `.z()`{: .language-kube-20 }: The z 'coordinate' of the cell
    - `.f1()`{: .language-kube-20 }: The normalized distance from the center of a cell
    - `.f2()`{: .language-kube-20 }: The normalized distance from the center of a face of a cell
    - `.noise()`{: .language-kube-20 }: The noise value of the cell

{: #chunk-data }

## ChunkData

`ChunkData` is TFC's additional data it attaches to chunks during chunk generation for use during and after world generation. It has the following methods:

- `.getPos(): ChunkPos`{: .language-kube-20 #chunk-data-get-pos }: Get the `ChunkPos` that data is attached to
- `.getRockData(): RockData`{: .language-kube-20 #chunk-data-get-rock-data }: Get the chunk's [`RockData`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/chunkdata/RockData.java)
- `.getAquiferSurfaceHeight(): int[16]`{: .language-kube-20 #chunk-data-get-aquifer-surface-height }: Get the chunk's aquifer surface heights as an array of ints. The array has sixteen elements, representing aquifer heights at a `QuartPos` resolution
- `.getRainfall(pos: BlockPos): float`{: .language-kube-20 #chunk-data-get-rainfall-pos }: Get the interpolated rainfall value at the given position
- `.getRainfall(x: int, z: int): float`{: .language-kube-20 #chunk-data-get-rainfall-x-z }: Get the interpolated rainfall value at the given x and z coordinates
- `.getAverageTemperature(pos: BlockPos): float`{: .language-kube-20 #chunk-data-get-average-temperature-pos }: Get the interpolated average temperature value at the given position
- `.getAverageTemperature(x: int, z: int): float`{: .language-kube-20 #chunk-data-get-average-temperature-x-z }: Get the interpolated average temperature value at the given x and z coordinates
- `.getForestType(): ForestType`{: .language-kube-20 #chunk-data-get-forest-type }: Get the chunk's `ForestType`{:.e}
- `.getForestWeirdness(): float`{: .language-kube-20 #chunk-data-get-forest-weirdness }: Get the chunk's forest weirdness value
- `.getForestDensity(): float`{: .language-kube-20 #chunk-data-get-forest-density }: Get the chunk's forest density value
- `.status(): ChunkData$Status`{: .language-kube-20 #chunk-data-status }: Gets the `Status`{:.e} of the chunk data
- `.generatePartial(...): void`{: .language-kube-20 #chunk-data-generate-partial }: Promotes the chunk data to `PARTIAL`{:.e} from `EMPTY`{:.e} and fills in the temperature, rainfall, and forest values of the chunk. Has five parameters, in order they are:
    - `rainfallLayer: LerpFloatLayer`{: .language-kube-20 }: A [`LerpFloatLayer`]({% link kubejs_tfc/1.20.1/bindings/misc.md %}#lerp-float-layer) of the yearly average rainfall at the corners of the chunk. Used in climate models to determine the rainfall at a position
    - `temperatureLayer: LerpFloatLayer`{: .language-kube-20 }: A [`LerpFloatLayer`]({% link kubejs_tfc/1.20.1/bindings/misc.md %}#lerp-float-layer) of the yearly average temperature at the corners of the chunk. Used by climate models to determine the average temperature at a position
    - `forestType: ForestType`{: .language-kube-20 }: The forest type of the chunk, may be `none`{:.e}, `sparse`{:.e}, `edge`{:.e}, `normal`{:.e}, or `old_growth`{:.e}
    - `forestWeirdness: float`{: .language-kube-20 }: The forest 'weirdness' of the chunk, {% in_unit %}. Used by TFC's forest configured feature
    - `forestDensity: float`{: .language-kube-20 }: The forest density of the chunk, {% in_unit %}. Used by TFC's forest configured feature
- `.generateFull(...): void`{: .language-kube-20 #chunk-data-generate-full }: Promotes the chunk data from `PARTIAL`{:.e} to `FULL`{:.e} and fills in the chunk's surface and aquifer heights. Has two parameters, in order they are:
    - `surfaceHeight: int[256]`{: .language-kube-20 }: An array of integer values of size `256`{:.n}[^1] representing the surface height of the world. Values indexes are `x + 16 * z`{: .language-kube-20 } where `x` and `z` are the local x and z coordinates within the chunk and are {% in_range 0,15 %}. For custom chunk data providers, this is where the `surfaceY`{:.v} parameter of the `RocksGetter`{:.f} [callback]({% link kubejs_tfc/1.20.1/events.md %}#chunk-data-provider-rocks) is gotten from
    - `aquiferSurfaceHeight: int[16]`{: .language-kube-20 }: An array of integer values of size `16`{:.n}[^2] representing the height of aquifer surfaces. Only used by [`TFCAquifer`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/TFCAquifer.java)s

[^1]: `16`{:.n} * `16`{:.n}; `BlockPos` resolution
[^2]: `4`{:.n} * `4`{:.n}; `QuartPos` resolution

{: #layered-area }

## LayeredArea

`LayeredArea` is a specialized version of TFC's `Area`, an `AreaSource` overlaid with multiple [`TransformLayer`](#layered-area-transform-layer)s which can be thought of as a pseudo-[`Noise2D`](#noise2d), designed to be easily made, edited, and used in scripts. It has the following methods:

- `.getAt(x: int, z: int): int`{: .language-kube-20 #layered-area-get-at }: Gets the value at the given x-z point
- `.zoom(fuzzy: boolean, seed: long): @Self LayeredArea`{: .language-kube-20 #layered-area-zoom }: Applies a zoom layer to the area, effectively doubling the 'resolution' of the area. The params are:
    - `fuzzy: boolean`{: .language-kube-20 }: If the zooming function should apply a smoothing operation along value boundaries
    - `seed: long`{: .language-kube-20 }: The seed for the [`AreaContext`](#layered-area-area-context)'s random
- `.smooth(seed: long): @Self LayeredArea`{: .language-kube-20 #layered-area-smooth }: Applies a smoothing layer to the area. The param is the seed used by the [`AreaContext`](#layered-area-area-context)'s random
- `.transform(transformer: TransformLayer, seed: long): @Self LayeredArea`{: .language-kube-20 #layered-area-transform }: Applies an arbitrary [`TransformLayer`](#layered-area-transform-layer) to the area. The params are:
    - `transformer: TransformLayer`{: .language-kube-20 }: The transformer
    - `seed: long`{: .language-kube-20 }: The seed used by the [`AreaContext`](#layered-area-area-context)'s random
- `.adjacentTransform(transformer: AdjacentTransformLayer, seed: long): @Self LayeredArea`{: .language-kube-20 #layered-area-adjacent-transform }: Applies an arbitrary `TransformLayer`{:.f} that has [access to neighboring values](#layered-area-adjacent-transform-layer). The params are:
    - `transformer: AdjacentTransformLayer`{: .language-kube-20 }: The transformer
    - `seed: long`{: .language-kube-20 }: The seed used by the [`AreaContext`](#layered-area-area-context)'s random
- `.merge(merger: MergeLayer, otherLayeredArea: LayeredArea, seed: long): @Self LayeredArea`{: .language-kube-20 #layered-area-merge }: Merges this `LayeredArea` with another via the given `Mergelayer`{:.f}. The params are:
    - `merger: MergeLayer`{: .language-kube-20 }: A callback which merges the two `LayeredArea`s together. Has the following params:
        - `context: AreaContext`{: .language-kube-20 }: The seeded [`AreaContext`](#layered-area-area-context) at the point
        - `first: Area`{: .language-kube-20 }: The [`Area`](#layered-area-area) from this `LayeredArea`
        - `second: Area`{: .language-kube-20 }: The [`Area`](#layered-area-area) from the other `LayeredArea`
        - `x: int`{: .language-kube-20 }: The x position being queried
        - `z: int`{: .language-kube-20 }: The z position being queried
        - `return: int`{: .language-kube-20 }: The return value
    - `otherLayeredArea: LayeredArea`{: .language-kube-20 }: The `LayeredArea` to merge with this one
    - `seed: long`{: .language-kube-20 }: The seed used by the [`AreaContext`](#layered-area-area-context)'s random

{: #layered-area-source-layer }

### SourceLayer

`SourceLayer`{:.f} is a functional interface that originates a [`LayeredArea`](#layered-area). It can be created in scripts as a callback with the params:

- `context: AreaContext`{: .language-kube-20 }: The seeded [`AreaContext`](#layered-area-area-context) at the point
- `x: int`{: .language-kube-20 }: The x position being queried
- `z: int`{: .language-kube-20 }: The z position being queried
- `return: int`{: .language-kube-20 }: The return value

{: #layered-area-transform-layer }

### TransformLayer

`Transformlayer`{:.f} is a functional interface that transforms the result of a [`LayeredArea`](#layered-area). It can be created in scripts as a callback with the following params:

- `context: AreaContext`{: .language-kube-20 }: The [`AreaContext`](#layered-area-area-context) of the layer
- `area: Area`{: .language-kube-20 }: The [`Area`](#layered-area-area) of the `LayeredArea`
- `x: int`{: .language-kube-20 }: The x position being queried
- `z: int`{: .language-kube-20 }: The z position being queried
- `return: int`{: .language-kube-20 }: The return value

{: #layered-area-adjacent-transform-layer }

### AdjacentTransformLayer

`AdjacentTransformlayer`{:.f} is a functional interface that transforms the result of a [`LayeredArea`](#layered-area). It can be created in scripts as a callback with the following params:

- `context: AreaContext`{: .language-kube-20 }: The [`AreaContext`](#layered-area-area-context) of the layer
- `north: int`{: .language-kube-20 }: The value immediately north of the `center`{:.v} position
- `east: int`{: .language-kube-20 }: The value immediately east of the `center`{:.v} position
- `south: int`{: .language-kube-20 }: The value immediately south of the `center`{:.v} position
- `west: int`{: .language-kube-20 }: The value immediately west of the `center`{:.v} position
- `center: int`{: .language-kube-20 }: The value at the queried position
- `return: int`{: .language-kube-20 }: The return value

{: #layered-area-area-context }

### AreaContext

`AreaContext` is an object which provides some utility methods for making random choices in layer transformations. it has the following methods:

- `.random(): RandomSource`{: .language-kube-20 }: Gets the `RandomSource` used by the context to make choices
- `.choose(first: int, second: int): int`{: .language-kube-20 }: Randomly chooses between the two options and returns the selection
- `.choose(first: int, second: int, third: int, fourth: int): int`{: .language-kube-20 }: Randomly chooses between the four options and returns the selection

{: #layered-area-area }

### Area

`Area`s are objects which represent a value source and the sum contribution of all layers applied to a [`LayeredArea`](#layered-area). It has one method:

- `.get(x: int, z: int): int`{: .language-kube-20 }: Gets the value at the given x-z point

{: #named-registry-metal }

## NamedRegistryMetal

A `NamedRegistryMetal` is an easy way to access the items, blocks, and fluid associated with a metal. It has the following methods:

- `.getMod(): String`{: .language-kube-20 #named-reg-metal-get-mod }: Get the mod id the metal is added by
- `.getBlock(type: Metal$BlockType): @Nullable Supplier<Block>`{: .language-kube-20 #named-reg-metal-get-block }: Get a possibly null supplier for the block of the given type. Accepts `anvil`{:.e}, `block`{:.e}, `block_slab`{:.e}, `block_stairs`{:.e}, `bars`{:.e}, `chain`{:.e}, `lamp`{:.e}, or `trapdoor`{:.e}
- `.getItem(type: Metal$ItemType): @Nullable Supplier<Item>`{: .language-kube-20 #named-reg-metal-get-item }: Get a possibly null supplier for the item of the given type. Accepts `ingot`{:.e}, `double_ingot`{:.e}, `sheet`{:.e}, `double_sheet`{:.e}, `rod`{:.e}, `tuyere`{:.e}, `fish_hook`{:.e}, `fishing_rod`{:.e}, `unfinished_lamp`{:.e}, `pickaxe`{:.e}, `pickaxe_head`{:.e}, `propick`{:.e}, `propick_head`{:.e}, `axe`{:.e}, `axe_head`{:.e}, `shovel`{:.e}, `shovel_head`{:.e}, `hoe`{:.e}, `hoe_head`{:.e}, `chisel`{:.e}, `chisel_head`{:.e}, `hammer`{:.e}, `hammer_head`{:.e}, `saw`{:.e}, `saw_head`{:.e}, `javelin`{:.e}, `javelin_head`{:.e}, `sword`{:.e}, `sword_blade`{:.e}, `mace`{:.e}, `mace_head`{:.e}, `knife`{:.e}, `knife_head`{:.e}, `scythe`{:.e}, `scythe_head`{:.e}, `shears`{:.e}, `unhinished_helmet`{:.e}, `helmet`{:.e}, `unfinished_chestplate`{:.e}, `chestplate`{:.e}, `unfinished_greaves`{:.e}, `greaves`{:.e}, `unfinished_boots`{:.e}, `boots`{:.e}, `horse_armor`{:.e}, or `shield`{:.e}
- `.getFluid(): @Nullable Supplier<Fluid>`{: .language-kube-20 #named-reg-metal-get-fluid }: Get the possibly null supplier for the source fluid of the metal
- `.toolTier(): ToolTier`{: .language-kube-20 #named-reg-metal-tool-tier }: Get the tool tier of the metal and all tools it contains
- `.armorTier(): ArmorMaterial`{: .language-kube-20 #named-reg-metal-armor-tier }: Get the armor material of the metal and all armor pieces it contains
- `.metalTier(): Metal$Tier`{: .language-kube-20 #named-reg-metal-metal-tier }: Get the tier of the metal, typically the tier of [working recipes]({% link kubejs_tfc/1.20.1/recipes.md %}#working) its metal can handle
- `.getFullBlock(): Supplier<Block>`{: .language-kube-20 #named-reg-metal-get-full-block }: Get a supplier for the metal's full block
- `.mapColor(): MapColor`{: .language-kube-20 #named-reg-metal-map-color }: Get the map color of the blocks contained by this metal
- `.getRarity(): Rarity`{: .language-kube-20 #named-reg-metal-get-rarity }: Get the rarity of the items contained by this metal
- `.getSerializedName(): String`{: .language-kube-20 #named-reg-metal-get-serialized-name }: Get the name of the metal

{: #named-registry-wood }

## NamedRegistryWood

A `NamedRegistryWood` is an easy way to access the blocks associated with a wood type. It has the following methods:

- `.getMod(): String`{: .language-kube-20 #named-reg-wood-get-mod }: Get the mod id the wood is added by
- `.woodColor(): MapColor`{: .language-kube-20 #named-reg-wood-wood-color }: Get the map color of the blocks contained by the wood
- `.barkColor(): MapColor`{: .language-kube-20 #named-reg-wood-bark-color }: Get the map color of the barks of the wood
- `.tree(): TFCTreeGrower`{: .language-kube-20 #named-reg-wood-tree }: Get the [`TFCTreeGrower`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/feature/tree/TFCTreeGrower.java) of the wood
- `.daysToGrow(): number`{: .language-kube-20 #named-reg-wood-}: Gets the number of days it takes for the wood's sapling to grow
- `.autumnIndex(): number`{: .language-kube-20 #named-reg-wood-autumn-index }: Get the vertical coordinate, {% in_range 0,255 %}, on the `foliage_fall` colormap for this wood's leaves
- `.getBlock(type: Wood$BlockType): @Nullable Supplier<Block>`{: .language-kube-20 #named-reg-wood-get-block }: Get a possibly null supplier for the block of the given type. Accepts `log`{:.e}, `stripped_log`{:.e}, `wood`{:.e}, `stripped_wood`{:.e}, `leaveas`{:.e}, `planks`{:.e}, `sapling`{:.e}, `potted_sapling`{:.e}, `bookshelf`{:.e}, `door`{:.e}, `trapdoor`{:.e}, `fence`{:.e}, `log_fence`{:.e}, `fence_gate`{:.e}, `button`{:.e}, `pressure_plate`{:.e}, `slab`{:.e}, `stairs`{:.e}, `too_rack`{:.e}, `twig`{:.e}, `fallen_leaves`{:.e}, `vertical_support`{:.e}, `horizontal_support`{:.e}, `workbench`{:.e}, `trapped_chest`{:.e}, `chest`{:.e}, `loom`{:.e}, `sluice`{:.e}, `sign`{:.e}, `wall_sign`{:.e}, `barrel`{:.e}, `lectern`{:.e}, `scribing_table`{:.e}, `sewing_table`{:.e}, `jar_shelf`{:.e}, `axle`{:.e}, `bladed_axle`{:.e}, `encased_axle`{:.e}, `clutch`{:.e}, `gear_box`{:.e}, `windmill`{:.e}, or `water_wheel`{:.e}
- `.getBlockSet(): BlockSetType`{: .language-kube-20 #named-reg-get-block-set }: Get the vanilla `BlockSetType` of the wood
- `.getVanillaWoodType(): WoodType`{: .language-kube-20 #named-reg-get-vanilla-wood-type }: Get the vanilla wood type of the wood
- `.getSerializedName(): String`{: .language-kube-20 #named-reg-get-serialized-name }: Get the name of the wood

{% comment %}

### chunk data

### layered area

### layered area transform layer

### layered area adjacent transform layer

### layered area area context

### layered area area

{% endcomment %}
