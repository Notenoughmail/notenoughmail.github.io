---
s: layered_area
title: '`LayeredArea`'
anchor: layered-area
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

{% capture transform %}[`TransformLayer`{:.f}](#{{ page.anchor }}-transform-layer){:.preserve-color}{% endcapture %}

`LayeredArea` is a specialized version of TFC's `Area`, an `AreaSource` overlaid with multiple {{ transform }}s which can be though of as a pseudo-[`Noise2D`{:.f}](#noise-2d){:.preserve-color}, designed to be easily [made]({% link kubejs_tfc/1.21.1/bindings/worldgen.md %}), edited, and used in scripts. It has the following methods:

{% capture a_ctx %}[`AreaContext`](#{{ page.anchor }}-area-context){% endcapture %}
{% capture area %}[`Area`](#{{ page.anchor }}-area){% endcapture %}

- `.getAt(x: int, z: int): int`{: .language-kube-21 #{{ page.anchor }}-get-at }: Gets the value at the given x-z point
- `.zoom(fuzzy: boolean, seed: int): @Self LayeredArea`{: .language-kube-21 #{{ page.anchor }}-zoom }: Applies a zoom layer to the area, effectively doubling the 'resolution' of the area. The params are:
    - `fuzzy: boolean`{:.language-kube-21}: If the zooming function should apply a smoothing/dither-like operation along value boundaries
    - `seed: int`{:.langauage-kube-21}: The seed for the {{ a_ctx }}'s random
- `.smooth(seed: int): @Self LayeredArea`{: .language-kube-21 #{{ page.anchor }}-smooth }: Applies a smoothing layer to the area. The param is the seed used by the {{ a_ctx }}'s random
- `.transform(transformer: TransformLayer, seed: int): @Self LayeredArea`{: .language-kube-21 #{{ page.anchor }}-transform }: Applies an arbitrary {{ transform }} to the area. The params are:
    - `transformer: TransformLayer`{:.langauge-kube-21}: The transformer
    - `seed: int`{:.language-kube-21}: The seed used by the {{ a_ctx }}'s random
- `.adjacentTransform(transformer: AdjacentTransformerLayer, seed: int): @Self LayeredArea`{: .language-kube-21 #{{ page.anchor }}-adjacent-transform }: Applies an arbitrary `Transformlayer`{:.f} that has [access to neighboring values](#{{ page.anchor }}-adjacent-transform-layer). The params are:
    - `transformer: AdjacentTransformLayer`{:.language-kube-21}: The transformer
    - `seed: int`{:.language-kube-21}: The seed used by the {{ a_ctx }}'s random
- `.merge(merge: MergeLayer, otherLayeredArea: LayeredArea, seed: int): @Self LayeredArea`{: .language-kube-21 #{{ page.anchor }}-merge }: Merges the `LayeredArea` with another via the given `MergeLayer`{:.f}. The params are:
    - `merger: MergeLayer`{:.language-kube-21}: A callback which merges the two `LayeredArea`s together. Has the following params:
        - `context: AreaContext`{:.language-kube-21}: The seeded {{ a_ctx }} at the point
        - `first: Area`{:.language-kube-21}: The {{ area }} from the `LayeredArea` being merged into
        - `second: Area`{:.language-kube-21}: The {{ area }} from the other `LayeredArea`
        - `x: int`{:.language-kube-21}: The x position being queried
        - `z: int`{:.language-kube-21}: The z position being queried
        - `return: int`{:.language-kube-21}: The resultant value of the merge
    - `otherLayeredArea: LayeredArea`{:.language-kube-21}: The `LayeredArea` to merge with this one
    - `seed: int`{:.language-kube-21}: The seed used by the {{ a_ctx }}'s random

{% capture layered %}[`LayeredArea`](#{{ page.anchor }}){% endcapture %}

{: #{{ page.anchor }}-source-layer }

## `SourceLayer`{:.f}

`SourceLayer`{:.f} is a functional interface that originates a {{ layered }}. It can be created in scripts as a callback with the params

- `context: AreaContext`{:.language-kube-21}: The seeded {{ a_ctx }} at the point
- `x: int`{:.language-kube-21}: The x position being queried
- `z: int`{:.language-kube-21}: The z position being queried
- `return: int`{:.language-kube-21}: The return value

{: #{{ page.anchor }}-transform-layer }

## `TransformLayer`{:.f}

`TransformLayer`{:.f} is a functional interface that transforms the result of a {{ layered }}. It can be created in scripts as a callback with the following params:

- `context: AreaContext`{:.language-kube-21}: The {{ a_ctx }} of the layer
- `area: Area`{:.language-kube-21}: The {{ area }} of the `LayeredArea`
- `x: int`{:.language-kube-21}: The x position being queried
- `z: int`{:.language-kube-21}: The z position being queried
- `return: int`{:.language-kube-21}: The return value

{: #{{ page.anchor }}-adjacent-transform-layer }

## `AdjacentTransformLayer`{:.f}

`AdjacentTransformLayer`{:.f} is a functional interface that transforms the result of a {{ layered }}. It can be created in scripts as a callback with the following params:

- `context: AreaContext`{:.language-kube-21}: The {{ a_ctx }} of the layer
- `north: int`{:.language-kube-21}: The value immediately north of the `center`{:.v} position
- `east: int`{:.language-kube-21}: The value immediately east of the `center`{:.v} position
- `south: int`{:.language-kube-21}: The value immediately south of the `center`{:.v} position
- `west: int`{:.language-kube-21}: The value immediately west of the `center`{:.v} position
- `center: int`{:.language-kube-21}: The value at the queried position
- `return: int`{:.language-kube-21}: The return value

{: #layer-area-area-context }

## `AreaContext`

`AreaContext`s provide some utility methods for making random choices in a thread-safe manner in layer transformation and sourcing. It has the following methods:

- `.random(): RandomSource`{:.language-kube-21}: Gets the `RandomSource` used by the context to make choices
- `.choose(first: int, second: int): int`{:.language-kube-21}: Makes a random choice between the two given values
- `.choose(first: int, second: int, third: int, fourth: int): int`{:.language-kube-21}: Makes a random choice between the four given values
- `.choose(choices: int[]): int`{:.language-kube-21}: Makes a random choice from the given values

{: #{{ page.anchor }}-are }

## `Area`

`Area`s represent a value source and the sum contribution of all layers applied to a {{ layered }}. It has one method:

- `.get(x: int, z: int): int`{:.language-kube-21}: Gets the value at the given x-z point

{% comment %}

## noise 2d

{% endcomment %}
