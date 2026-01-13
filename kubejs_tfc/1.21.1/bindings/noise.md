---
layout: page
title: Noise Bindings
permalink: /kubejs_tfc/1.21.1/bindings/noise/
parent: Bindings
grand_parent: 1.21.1
desc: Bindings for creating and using TFC's noise objects
field: noise
---

# {{ page.title }}

{{ page.desc }}

```js-21
declare class NoiseBindings {

    // These are available via TFC.noise.*

    openSimplex2D(seed: int): OpenSimplex2D
    openSimplex3D(seed: int): OpenSimplex3D
    cellular2D(seed: int): Cellular2D
    cellular3D(seed: int): Cellular3D
    fastNoiseLite(seed: int): FastNoiseLite
    fnl2Noise2D(fnl: FastNoiseLite): Noise2D
    fnl2Noise3D(fnl: FastNoiseLite): Noise3D
    customNoise2D(noise: Noise2D): Noise2D
    customNoise3D(noise: Noise3D): Noise3D
    metaballs2D(random: RandomSource, minBalls: int, maxBalls: int, minSize: number, maxSize: number, radius: number): Metaballs2D
    metaballs3D(random: RandomSource, minBalls: int, maxBalls: int, minSize: number, maxSize: number, radius: number): Metaballs3D
    inspect2D(name: String, noise: Noise2D): void
    inspect3D(name: String, noise: Noise3D): void
}
```

{% capture d2 %}[`Noise2D`{:.f}]({% link kubejs_tfc/1.21.1/type-explanations.md %}#noise-2d){:.preserve-color}{% endcapture %}
{% capture d3 %}[`Noise3D`{:.f}]({% link kubejs_tfc/1.21.1/type-explanations.md %}#noise-3d){:.preserve-color}{% endcapture %}

- `.openSimplex2D(seed: int)`{: .language-kube-21 #open-simplex-2d }: Creates a new `OpenSimplex2D` object, an implementation of {{ d2 }} using the OpenSimplex noise function
- `.openSimplex3D(seed: int)`{: .language-kube-21 #open-simplex-3d }: Creates a new `OpenSimplex3D` object, an implementation of {{ d3 }} using the OpenSimplex noise function. It has one additional method to `Noise3D`{:.f}:
    - `.amplitude(): number`{:.language-kube-21}: Gets the amplitude of the noise
- `.cellular2D(seed: int)`{: .language-kube-21 #cellular-2d }: Creates a new `Cellular2D` object, an implementation of {{ d2 }} specialized to have polygonal blobs of constant value, instead of smooth, continuous values. It has additional methods
    - `.then(func: Function<Cell, number>): Noise2D`{:.language-kube-21}: Converts a `Cell` to a value via a function
    - `.cell(x: number, y: number): Cell`{:.language-kube-21}: Gets the `Cell` at the given x-y point, where `Cell` is an object with the methods
        - `.x(): number`{:.language-kube-21}: The x 'coordinate' of the cell center. Not tied to game coordinates
        - `.y(): number`{:.language-kube-21}: The y 'coordinate' of the cell center. Not tied to game coordinates
        - `.cx(): int`{:.language-kube-21}: The x 'coordinate' of nearest cell center
        - `.cy(): int`{:.language-kube-21}: The y 'coordinate' of nearest cell center
        - `.f1(): number`{:.language-kube-21}: The distance to {% range c,x,() %}
        - `.f2(): number`{:.language-kube-21}: The distance to {% range cx,cy,() %}
        - `.noise(): number`{:.language-kube-21}: The noise value of the cell, {% in_unit %}
        - `.angle(): number`{:.language-kube-21}: The diamond angle to the cell center, {% in_range 0,4 %} where `4`{:.n} is 360°
- `.cellular3D(seed: int)`{: .language-kube-21 #cellular-3d }: Creates a new `Cellular3D` object, an implementation of {{ d3 }} specialized to have polyhedral blobs of constant value, instead of smooth, continuous values. It has an additional method
    - `.cell(x: number, y: number, z: number): Cell`{:.language-kube-21}: Gets the `Cell` at the given x-y-z point, where `Cell` is an object with the methods
        - `.x(): number`{:.language-kube-21}: The x 'coordinate' of the cell
        - `.y(): number`{:.language-kube-21}: The y 'coordinate' of the cell
        - `.z(): number`{:.language-kube-21}: The z 'coordinate' of the cell
        - `.f1(): number`{:.language-kube-21}: The normalized distance from the center of the cell
        - `.f2(): number`{:.language-kube-21}: The normalized distance form the center of a face of the cell
        - `.noise(): number`{:.language-kube-21}: The noise value of the cell
- `.fastNoiseLite(seed: int)`{: .language-kube-21 #fast-noise-lite }: Creates a new [`FastNoiseLite`](https://github.com/Auburn/FastNoiseLite) object, an MIT library for producing noise and is used in TFC's open simplex and cellular noise types
- `.fnl2Noise2D(fnl: FastNoiseLite)`{: .language-kube-21 #fnl-2-noise-2d }: Converts a `FastNoiseLite` object to a {{ d2 }}
- `.fnl2Noise3D(fnl: FastNoiseLite)`{: .language-kube-21 #fnl-2-noise-3d }: Converts a `FastNoiseLite` object to a {{ d3 }}
- `.customNoise2D(noise: Noise2D)`{: .language-kube-21 #custom-noise-2d }: Converts a js callback to a full {{ d2 }} to use its methods
- `.customNoise3D(noise: Noise3D)`{: .language-kube-21 #custom-noise-3d }: Converts a js callback to a full {{ d3 }} to use its methods
- `.metaballs2D(random: RandomSource, minBalls: int, maxBalls: int, minSize: number, maxSize: number, radius: number)`{: .language-kube-21 #metaballs-2d }: Creates a new `Metaballs2D` object, the basis upon which [soil discs]({% link kubejs_tfc/1.21.1/worldgen.md %}#soil-disc) and [hot springs]({% link kubejs_tfc/1.21.1/worldgen.md %}#hot-spring) are shaped
    - `random: RandomSource`{:.language-kube-21}: The random source values are derived from
    - `minBalls: int`{:.language-kube-21}: The minimum number of balls to use
    - `maxBalls: int`{:.language-kube-21}: The maximum number of balls to use
    - `minSize: number`{:.language-kube-21}: The minimum size of an individual ball
    - `maxSize: number`{:.language-kube-21}: The maximum size of an individual ball
    - `radius: number`{:.language-kube-21}: The maximum radius of an individual ball
    `Metaballs2D` has the methods
    - `.inside(x: number, z: number)`{:.language-kube-21}: If the position is within the metaballs
    - `.sample(x: number, z: number)`{:.language-kube-21}: Gets the 'proximity' to the metaballs, values grater than one are considered inside
- `.metaballs3D(random: RandomSource, minBalls: int, maxBalls: int, minSize: number, maxSize: number, radius: number)`{: .language-kube-21 #metaballs-3d }: Creates a new `Metaballs3D` object, the basis upon which [boulders]({% link kubejs_tfc/1.21.1/worldgen.md %}#boulder) and [cluster veins]({% link kubejs_tfc/1.21.1/worldgen.md %}#custer-vein) are shaped
    - `random: RandomSource`{:.language-kube-21}: The random source values are derived from
    - `minBalls: int`{:.language-kube-21}: The minimum number of balls to use
    - `maxBalls: int`{:.language-kube-21}: The maximum number of balls to use
    - `minSize: number`{:.language-kube-21}: The minimum size of an individual ball
    - `maxSize: number`{:.language-kube-21}: The maximum size of an individual ball
    - `radius: number`{:.language-kube-21}: The maximum radius of an individual ball
    `Metaballs3D` has the method
    - `.inside(x: number, y: number, z: number)`{:.language-kube-21}: If the position is within the metaballs
- `.inspect2D(name: String, noise: Noise2D)`{: .language-kube-21 #inspect-2D }: Registers a {{ d2 }} so that it may be [inspected]({% link kubejs_tfc/1.21.1/commands.md %}#inspect-2d-noise) by command
- `.inspect3D(name: String, noise: Noise3D)`{: .language-kube-21 #inspect-3D }: Registers a {{ d3 }} so that it may be [inspected]({% link kubejs_tfc/1.21.1/commands.md %}#inspect-3d-noise) by command
