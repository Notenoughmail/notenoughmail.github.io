---
layout: none
s: noise_3d
title: '`Noise3D`{:.f}'
preserve-color: true
anchor: noise-3d
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

`Noise3D`{:.f} is a functional interface which serves as a wrapper for a 3D noise layer. It can be created in scripts as a callback with the params:

- `x: number`{:.language-kube-21}: The x coordinate being queried
- `y: number`{:.language-kube-21}: The y coordinate being queried
- `z: number`{:.language-kube-21}: The z coordinate being queried
- `return: number`{:.language-kube-21}: The value at the queried position

`Noise3D`{:.f} objects can be created from several methods in the [noise sub-binding]({% link kubejs_tfc/1.21.1/bindings/noise.md %}). instances of `Nosie3D`{:.f} also have several methods available

- `.noise(x: number, y: number, z: number): number`{: .language-kube-21 #{{ page.anchor }}-noise }: Gets the value of the noise at the given position
- `.octaves(octaves: int): Noise3D`{: .language-kube-21 #{{ page.anchor }}-octaves }: Applies an octave function to the noise, overlaying weaker, more spread copies of the noise on top of itself
    - `octaves: int`{:.language-kube-21}: The number of octaves to overlay
- `.spread(scaleFactor: number): Noise3D`{: .language-kube-21 #{{ page.anchor }}-spread }: Scales the input coordinates of the noise function by the given scale factor
- `.scaled(min: number, max: number): Noise3D`{: .language-kube-21 #{{ page.anchor }}-scaled-0 }: Re-scales the noise values to the new range, old values are expected to be {% in_range -1,1 %}
- `.scaled(oldMin: number, oldMax: number, min: number, max: number): Noise3D`{: .language-kube-21 #{{ page.anchor }}-scaled-1 }: Re-scaled the noise value from the old range to the new range
- `.warped(warp: OpenSimplex3D): Noise3D`{: .language-kube-21 #{{ page.anchor }}-warped }: Uses the `FastNoiseLite` of the simplex noise to warp the domain of the noise
- `.transposeXZ(): Noise3D`{: .language-kube-21 #{{ page.anchor }}-transpose-x-z }: Swaps the x and z coordinates
- `.transposeXY(): Noise3D`{: .language-kube-21 #{{ page.anchor }}-transpose-x-y }: Swaps the x and y coordinates
- `.transposeYZ(): Noise3D`{: .language-kube-21 #{{ page.anchor }}-transpose-y-z }: Swaps the y and z coordinates
- `.dissolve(yNoise: Noise2D): Noise2D`{: .language-kube-21 #{{ page.anchor }}-dissolve }: Dissolves the noise to a [`Noise2D`{:.f}](#noise-2d){:.preserve-color} using the given `Noise2D`{:.f}'s as the y coordinate at each point
- `.rotateX(angle: number): Noise3D`{: .language-kube-21 #{{ page.anchor }}-rotate-x }: Rotates the coordinate grid around the x-axis by the given angle, in degrees
- `.rotateY(angle: number): Noise3D`{: .language-kube-21 #{{ page.anchor }}-rotate-y }: Rotates the coordinate grid around the y-axis by the given angle, in degrees
- `.rotateZ(angle: number): Noise3D`{: .language-kube-21 #{{ page.anchor }}-rotate-z }: Rotates the coordinate grid around the z-axis by the given angle, in degrees

{% comment %}

## noise 2d

{% endcomment %}
