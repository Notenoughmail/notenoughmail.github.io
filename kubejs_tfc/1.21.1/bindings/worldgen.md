---
layout: page
title: Worldgen Bindings
permalink: /kubejs_tfc/1.21.1/bindings/worldgen/
parent: Bindings
grand_parent: 1.21.1
desc: Bindings for interacting with TFC-specific worldgen functions, particularly useful for [custom chunk data providers]({% link kubejs_tfc/1.21.1/events.md %}#create-chunk-data-provider)
field: worldgen
---

# {{ page.title }}

{{ page.desc | render_liquid }}

```js-21
declare class WorldgenBindings {

    // These are available via TFC.worldgen.*

    layeredArea(source: SourceLayer, seed: int): LayeredArea
    layeredAreaFromNoise(noise: Noise2D, rounder?: Function<number, int>, seed: int): LayeredArea
    uniformLayeredArea(seed: int): LayeredArea
    lerpFloatLayer(value00: number, value01: number, value10: number, value11: number): LerpFloatLayer
}
```

{% capture exp %}{% link kubejs_tfc/1.21.1/type-explanations.md %}{% endcapture %}
{% capture layer %}[`LayeredArea`]({{ exp }}#layered-area){% endcapture %}

- `.layeredArea(source: SourceLayer, seed: int)`{: .language-kube-21 #layered-area }: Creates a new {{ layer }} from a [`SourceLayer`{:.f}]({{ exp }}#layered-area-source-layer){:.preserve-color}
- `.layeredAreaFromNoise(noise: Noise2D, rounder?: Function<number, int>, seed: int)`{: .language-kube-21 #layered-area-from-noise }: Creates a new {{ layer }} from a [`Noise2D`{:.f}]({{ exp }}#noise-2d), optionally with a rounding callback
- `.uniformLayeredArea(seed: int)`{: .language-kube-21 #uniform-layered-area }: Creates a new {{ layer }} with values uniformly distributed across the 32-bit signed integer range
- `.lerpFloatLayer(value00: number, value01: number, value10: number, value11: number)`{: .language-kube-21 #lerp-float-layer }: Creates a `LerpFloatLayer`, an interpolatable square of numbers, primarily used when [promoting `ChunkData` to `partial`{:.e}]({{ exp }}#chunk-data-generate-partial){:.preserve-color}
