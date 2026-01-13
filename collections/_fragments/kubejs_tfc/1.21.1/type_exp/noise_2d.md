---
layout: none
s: noise_2d
title: '`Noise2D`{:.f}'
preserve-color: true
anchor: noise-2d
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

`Noise2D`{:.f} is a functional interface which serves as a wrapper for a 2D noise layer. It can be created in scripts as a callback with the params:

- `x: number`{:.language-kube-21}: The x coordinate being queried
- `z: number`{:.language-kube-21}: The z coordinate being queried
- `return: number`{:.language-kube-21}: The value at the queried position

`Noise2D`{:.f} objects can be created from several methods in the [noise sub-binding]({% link kubejs_tfc/1.21.1/bindings/noise.md %}). Instances of `Noise2D`{:.f} also have several methods available

- `.noise(x: number, z: number): number`{: .language-kube-21 #{{ page.anchor }}-noise }: Gets the value of the noise the given position
- `.octaves(octaves: int): Noise2D`{: .language-kube-21 #{{ page.anchor }}-octaves }: Applies an octave function to the noise, overlaying weaker, more spread copies of the noise on top of itself
    - `octaves: int`{:.language-kube-21}: The number of octaves to overlay
- `.ridged(): Noise2D`{: .language-kube-21 #{{ page.anchor }}-ridged }: Creates a ridged noise using absolute values. Expects the noise's value to be {% in_range -1,1 %}
- `.abs(): Noise2D`{: .language-kube-21 #{{ page.anchor }}-abs }: Takes the absolute value of the function
- `.terraces(levels: int): Noise2D`{: .language-kube-21 #{{ page.anchor }}-terraces }: Creates 'terraces' by rounding the value to the nearest level. Expects the noise's value to be {% in_range -1,1 %}
    - `levels: int`{:.language-kube-21}: The number of levels to round to
- `.spread(scaleFactor: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-spread }: Scales the input coordinates of the noise function by the given scale factor
- `.scaled(min: number, max: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-scaled-0 }: Re-scales the noise value to the new range, old values are expected to be {% in_range -1,1 %}
- `.scaled(oldMin: number, oldMax: number, min: number, max: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-scaled-1 }: Re-scales the noise value from the old range to the new range
- `.affine(scale: number, shift: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-affine }: Scales then shifts the noise value
    - `scale: number`{:.language-kube-21}: The factor to multiply the noise value by
    - `shift: number`{:.language-kube-21}: The amount to add to the scaled value
- `.clampedScaled(min: number, max: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-clamped-scaled-0 }: [`.scaled(number,number)`{:.language-kube-21}](#{{ page.anchor }}-scaled-0){:.preserve-color} but also clamping the noise value to the `min`{:.v} and `max`{:.v} values
- `.clampedScaled(oldMin: number, oldMax: number, min: number, max: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-clamped-scaled-1 }: [`.scaled(number,number,number,number)`{:.language-kube-21}](#{{ page.anchor }}-scaled-1){:.preserve-color}, but clamping the noise value to the `min`{:.v} and `max`{:.v} values
- `.warped(warp: OpenSimplex2D): Noise2D`{: .language-kube-21 #{{ page.anchor }}-warped }: Uses the `FastNoiseLite` of the simplex noise to warp the domain of the noise
- `.clamped(min: number, max: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-clamped }: Clamps the noise to the given range
- `.add(other: Noise2D): Noise2D`{: .language-kube-21 #{{ page.anchor }}-add }: Sums this noise with the other
- `.addConstant(constant: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-add-constant }: Adds a constant value to the noise
- `.min(other: Noise2D): Noise2D`{: .language-kube-21 #{{ page.anchor }}-min }: Takes the minimum value of this noise and the other
- `.max(other: Noise2D): Noise2D`{: .language-kube-21 #{{ page.anchor }}-max }: Takes the maximum value of this noise and the other
- `.lazyProduct(other: Noise2D): Noise2D`{: .language-kube-21 #{{ page.anchor }}-lazy-product }: Multiplies this noise with the other
- `.map(mappingFunction: Function<number, number>): Noise2D`{: .language-kube-21 #{{ page.anchor }}-map }: Maps the output of the noise using the given function
- `.cliffMap(compare: Noise2D, addend: Noise2D): Noise2D`{: .language-kube-21 #{{ page.anchor }}-cliff-map }: Creates varying-height cliffs
    - `compare: Noise2D`{:.language-kube-21}: The noise to compare to, cliffs will be added when the noise is greater than the `compare`{:.v} value
    - `addend: Noise2D`{:.language-kube-21}: The cliff noise to add
- `.slopedCliffMap(compareNoise: Noise2D, addendNoise: Noise2D, slopeNoise: Noise2D): Noise2D`{: .language-kube-21 #{{ page.anchor }}-sloped-cliff-map }: Creates caring-height cliffs with slopes
    - `compareNoise: Noise2D`{:.language-kube-21}: The noise to compare to, cliffs will be added when sum of the noise and the addend is greater than the `compare`{:.v} value
    - `addendNoise: Noise2D`{:.language-kube-21}: The cliff noise to add
    - `slopeNoise: Noise2D`{:.language-kube-21}: The slope noise to use
- `.stretchX(stretch: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-stretch-x }: Stretches the z coordinate by the given factor
- `.stretchZ(stretch: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-stretch-z }: Stretches the x coordinate by the given factor
- `.transpose(): Noise2D`{: .language-kube-21 #{{ page.anchor }}-transpose }: Swaps the x and z coordinates
- `.rotate(angle: number): Noise2D`{: .language-kube-21 #{{ page.anchor }}-rotate }: Rotates the coordinate grid around the origin by the given angle, in degrees
- `.overChunk(pos: ChunkPos): LerpFloatLayer`{: .language-kube-21 #{{ page.anchor }}-over-chunk }: Evaluates the noise at the corners of the chunk and returns them as a [`LerpFloatLayer`]({% link kubejs_tfc/1.21.1/bindings/worldgen.md %}#lerp-float-layer)
- `.overGrid(x: int, z: int): LerpFloatLayer`{: .language-kube-21 #{{ page.anchor }}-over-grid }: Evaluates the noise at the corners of the grid coordinate and returns them as a [`LerpFloatLayer`]({% link kubejs_tfc/1.21.1/bindings/worldgen.md %}#lerp-float-layer)
