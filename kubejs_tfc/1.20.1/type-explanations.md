---
layout: page
title: Type Explanations
permalink: /kubejs_tfc/1.20.1/type-explanations/
parent: 1.20.1
grand_parent: KubeJS TFC
---

# Type Explanations

Lists and describes the methods available on

- [Noise2D](#noise2d)
- [Noise3D](#noise3d)
- [ChunkData](#chunk-data)
- [LayeredArea](#layered-area)
- [NamedRegistryMetal](#namedregistrymetal)
- [NamedRegistryWood](#namedregistrywood)

## Noise2D

[`Noise2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Noise2D.java) is TFC's base type for noise functions with two dimensions. It has the following methods:

- `.noise(x: double, z: double): Noise2D`{: .language-kube #noise2d-noise }: Gets the value of the noise at the given x-z point
- `.octaves(octaves: int): Noise2D`{: .language-kube #noise2d-octaves }: Applies an octave function to the noise, overlaying weaker, more spread copies of the noise on top of itself
- `.ridged(): Noise2D`{: .language-kube #noise2d-ridged }: Creates a ridged noise using absolute values. Expects the noise's value to be in the range [-1, 1]
- `.abs(): Noise2D`{: .language-kube #noise2d-abs }: Takes the absolute value of the function
- `.terraces(levels: int): Noise2D`{: .language-kube #noise2d-terraces }: Creates 'terraces' by taking the nearest level and rounding. Expects the noise's value to be in the range [-1, 1]
- `.spread(scaleFactor: double): Noise2D`{: .language-kube #noise2d-spread }: Scales the input dimension of the noise by the given scale factor
- `.scaled(min: double, max: double): Noise2D`{: .language-kube #noise2d-spread-2 }: Maps the output value, expected to be in the range [-1, 1], to the given min and max values
- `.scaled(oldMin: double, oldMax: double, min: double, max: double): Noise2D`{: .language-kube #noise2d-spread-4 }: Re-scales the output of the noise to a new range
- `.affine(scale: double, shift: double): Noise2D`{: .language-kube #noise2d-affine }: Scales then shifts the noise output
- `.warped(warp: OpenSimplex2D): Noise2D`{: .language-kube #noise2d-warp }: Uses the `FastNoiseLite` of the simplex noise to domain warp this noise
- `.clamped(min: double, max: double): Noise2D`{: .language-kube #noise2d-clamp }: Clamps the noise to the given range
- `.add(noise: Noise2D): Noise2D`{: .language-kube #noise2d-add }: Sums this noise and the other
- `.lazyProduct(other: Noise2D): Noise2D`{: .language-kube #noise2d-lazy-product }: Multiplies the two noises
- `.map(mappingFunction: Function<double, double>): Noise2D`{: .language-kube #noise2d-map }: Maps the output of this noise by the given function
- `.transpose(): Noise2D`{: .language-kube #noise2d-transpose }: Swaps the input axes
- `.rotate(angle: double): Noise2D`{: .language-kube #noise2d-rotate }: Rotates the input axes by the given angle (in degrees)

### OpenSimplex2D

[`OpenSimplex2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/OpenSimplex2D.java) is an implementation of [`Noise2D`](#noise2d) which uses `FastNoiseLite`'s `OpenSimplex` noise type.

### Cellular2D

[`Cellular2D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Cellular2D.java) is an implementation of [`Noise2D`](#noise2d) which creates `Cell`s, large area with the same value, instead of smooth Perlin-like gradients. It has these additional methods:

- `.then(func: Function<Cell, double>): Noise2D`{: .language-kube #cellular2d-then }: Converts the `Cell` to value via a function
- `.cell(x: double, z: double): Cell`{: .language-kube #cellular2d-cell }: Gets the `Cell` at the given x-z point. `Cell` is an object with the following methods
    - `.x()`{: .language-kube }: The x 'coordinate' of the center of this cell
    - `.y()`{: .language-kube }: The y 'coordinate' of the center of this cell
    - `.cx()`{: .language-kube }: The x 'coordinate' of this cell
    - `.cy()`{: .language-kube }: The y 'coordinate' of this cell
    - `.f1()`{: .language-kube }: The normalized distance from the center of a cell
    - `.f2()`{: .language-kube }: The normalized distance from the center of a edge of a cell
    - `.noise()`{: .language-kube }: The noise value of the cell

## Noise3D

[`Noise3D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Noise3D.java) is TFC's base type for noise functions with with tree dimensions. It has the following methods:

- `.noise(x: double, y: double, z: double): Noise3D`{: .language-kube #noise3d-noise }: Gets the value of noise at the give x-y-z point
- `.octaves(octaves: int): Noise3D`{: .language-kube #noise3d-octaves }: Applies an octave function to this noise, overlaying weaker, more spread out copies of the noise on top of itself
- `.spread(scaleFactor: double): Noise3D`{: .language-kube #noise3d-spread }: Scales the input dimensions of the noise by the given scale factor
- `.scaled(min: double, max: double): Noise3D`{: .language-kube #noise3d-scaled-2 }: Maps the output value, expected to be in the range [-1, 1], to the given min and max values
- `.scaled(oldMin: double, oldMax: double, min: double, max: double): Noise3D`{: .language-kube #noise3d-scaled-4 }: Re-scales the output of the noise to a new range
- `.warped(warp: OpenSimplex3D): Noise3D`{: .language-kube #noise3d-warp }: Uses the `FastNoiseLite` of the simplex noise to domain warp this noise
- `.transposeXZ(): Noise3D`{: .language-kube #noise3d-transpose-x-z }: Swaps the x and z axes
- `.transposeXY(): Noise3D`{: .language-kube #noise3d-transpose-x-y }: Swaps the x and y axes
- `.transposeYZ(): Noise3D`{: .language-kube #noise3d-transpose-y-z }: Swaps the y and z axes
- `.dissolve(yNoise: Noise2D): Noise2D`{: .language-kube #noise3d-dissolve}: Dissolves the `Noise3D` to a [`Noise2D`](#noise2d) by using the provided `Noise2D` as the input y-value at a given x-z coordinate
- `.rotateX(angle: double): Noise3D`{: .language-kube #noise3d-rotate-x }: Rotates the noise around the x axis
- `.rotateY(angle: double): Noise3D`{: .language-kube #noise3d-rotate-y }: Rotates the noise around the y axis
- `.rotateZ(angle: double): Noise3D`{: .language-kube #noise3d-rotate-z }: Rotates the noise around the z axis

### OpenSimplex3D

[`OpenSimplex3D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/OpenSimplex3D.java) is an implementation of [`Noise3D`](#noise3d) which uses `FastNoiseLite`'s `OpenSimplex` noise type

### Cellular3D

[`Cellular3D`](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.20.x/src/main/java/net/dries007/tfc/world/noise/Cellular3D.java) is an implementation of [`Noise3D`](#noise3d) which creates `Cell`s, large areas with the same value, instead of sooth Perlin-like gradients. It has these additional methods:

- `.cell(x: double, y: double, z: double): Cell`{: .language-kube #cellular3d-cell }: Gets the `Cell` at the given x-y-z point. `Cell` is an object with the following methods:
    - `.x()`{: .language-kube }: The x 'coordinate' of the cell
    - `.y()`{: .language-kube }: The y 'coordinate' of the cell
    - `.z()`{: .language-kube }: The z 'coordinate' of the cell
    - `.f1()`{: .language-kube }: The normalized distance from the center of a cell
    - `.f2()`{: .language-kube }: The normalized distance from the center of a face of a cell
    - `.noise()`{: .language-kube }: The noise value of the cell

{: .chunk-data }

## ChunkData

{: .layered-area }

## LayeredArea

`LayeredArea` is a specialized version of TFC's `Area`, an `AreaSource` overlaid with multiple [`TransformLayer`](#layered-area-transform-layer)s which can be though of as a pseudo-[`Noise2D`](#noise2d), designed to be easily made, edited, and used in scripts. It has the following methods:

- `.getAt(x: int, z: int): int`{: .language-kube #layered-area-get-at }: Gets the value at the given x-z point
- `.zoom(fuzzy: boolean, seed: long): @Self LayeredArea`{: .language-kube #layered-area-zoom }: Applies a zoom layer to the area, effectively doubling the 'resolution' of the area. The params are:
    - `fuzzy: boolean`{: .language-kube }: If the zooming function should apply a smoothing operation along value boundaries
    - `seed: long`{: .language-kube }: The seed for the [`AreaContext`](#layered-area-area-context)'s random
- `.smooth(seed: long): @Self LayeredArea`{: .language-kube #layered-area-smooth }: Applies a smoothing layer to the area. The param is the seed used by the [`AreaContext`](#layered-area-area-context)'s random
- `.transform(transformer: TransformLayer, seed: long): @Self LayeredArea`{: .language-kube #layered-area-transform }: Applies an arbitrary [`TransformLayer`](#layered-area-transform-layer) to the area. The params are:
    - `transformer: TransformLayer`{: .language-kube }: The transformer
    - `seed: long`{: .language-kube }: The seed used by the [`AreaContext`](#layered-area-area-context)'s random
- `.adjacentTransform(transformer: AdjacentTransformLayer, seed: long): @Self LayeredArea`{: .language-kube #layered-area-adjacent-transform }: Applies an arbitrary `TransformLayer` that has [access to neighboring values](#layered-area-adjacent-transform-layer). The params are:
    - `transformer: AdjacentTransformLayer`{: .language-kube }: The transformer
    - `seed: long`{: .language-kube }: The seed used by the [`AreaContext`](#layered-area-area-context)'s random
- `.merge(merger: MergeLayer, otherLayeredArea: LayeredArea, seed: long): @Self LayeredArea`{: .language-kube #layered-area-merge }: Merges this `LayeredArea` with another via the given `Mergelayer`. The params are:
    - `merger: MergeLayer`{: .language-kube }: A callback which merges the two `LayeredArea` together. Has the following params:
        - `context: AreaContext`{: .language-kube }: The seeded [`AreaContext`](#layered-area-area-context) at the point
        - `first: Area`{: .language-kube }: The [`Area`](#layered-area-area) from this `LayeredArea`
        - `second: Area`{: .language-kube }: The [`Area`](#layered-area-area) from the other `LayeredArea`
        - `x: int`{: .language-kube }: The x position being queried
        - `z: int`{: .language-kube }: The z position being queried
        - `return: int`{: .language-kube }: The return value
    - `otherLayeredArea: LayeredArea`{: .language-kube }: The `LayeredArea` to merge with this one
    - `seed: long`{: .language-kube }: The seed by the [`AreaContext`](#layered-area-area-context)'s random

{: .layered-area-source-layer }

### SourceLayer

`SourceLayer` is a functional interface that originates a [`LayeredArea`](#layered-area). It can be created in scripts as a callback with the params:

- `context: AreaContext`{: .language-kube }: The seeded [`AreaContext`](#layered-area-area-context) at the point
- `x: int`{: .language-kube }: The x position being queried
- `z: int`{: .language-kube }: The z position being queried
- `return: int`{: .language-kube }: The return value

{: .layered-area-transform-layer }

### TransformLayer

`Transformlayer` is a functional interface that transforms the result of a [`LayeredArea`](#layered-area). It can be created in scripts as a callback with the following params:

- `context: AreaContext`{: .language-kube }: The [`AreaContext`](#layered-area-area-context) of the layer
- `area: Area`{: .language-kube }: The [`Area`](#layered-area-area) of the `LayeredArea`
- `x: int`{: .language-kube }: The x position being queried
- `z: int`{: .language-kube }: The z position being queried
- `return: int`{: .language-kube }: The return value

{: .layered-area-adjacent-transform-layer }

### AdjacentTransformLayer

`AdjacentTransformlayer` is a functional interface that transforms the result of a [`LayeredArea`](#layered-area). It can be created in scripts as a callback with the following params:

- `context: AreaContext`{: .language-kube }: The [`AreaContext`](#layered-area-area-context) of the layer
- `north: int`{: .language-kube }: The value immediately north of the `center`{:.v} position
- `east: int`{: .language-kube }: The value immediately east of the `center`{:.v} position
- `south: int`{: .language-kube }: The value immediately south of the `center`{:.v} position
- `west: int`{: .language-kube }: The value immediately west of the `center`{:.v} position
- `center: int`{: .language-kube }: The value at the queried position
- `return: int`{: .language-kube }: The return value

{: .layered-area-area-context }

### AreaContext

`AreaContext` is an object which provides some utility methods for making random choices in layer transformations. it has the following methods:

- `.random(): RandomSource`{: .language-kube }: Gets the `RandomSource` used by the context to make choices
- `.choose(first: int, second: int): int`{: .language-kube }: Randomly chooses between the two options and returns the selection
- `.choose(first: int, second: int, third: int, fourth: int): int`{: .language-kube }: Randomly chooses between the four options and returns the selection

{: #layered-area-area }

### Area

`Area`s are objects which represent a value source and sum contribution of all layers applied to a [`LayeredArea`](#layered-area). It has one method:

- `.get(x: int, z: int): int`{: .language-kube }: Gets the value at the given x-z point

## NamedRegistryMetal

## NamedRegistryWood

{% comment %}

### chunk data

### layered area

### layered area transform layer

### layered area adjacent transform layer

### layered area area context

### layered area area

{% endcomment %}
