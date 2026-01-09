---
title: Fluid Container
anchor: fluid-container
type: tfc:fluid_container
name: fluid_container
cat:
    - kubejs-tfc
    - 1.21.1
    - item
example:
    - .filledDisplayName('Container of %s')
    - .textures('kubejs:item/fluid_container', 'kubejs:item/fluid_container_overlay')
    - .capacity(500)
    - .allowedFluids('kubejs:non_volatile')
---

Creates a new fluid container item

Inherits the methods of the [jug item builder](#jug)

{: #fluid-container-methods }

## Extra Methods

- `.placeInWorld(place: boolean)`{: .language-kube-21 #fluid-container-place-in-world }: Set if the container can place fluids in-world, defaults to `false`{:.p}
- `.placeSources(place: boolean)`{: .language-kube-21 #fluid-container-place-sources }: Set if the container can place source blocks in-world, defaults to `false`{:.p}
- `.placeSourcesSupplier(place: Supplier<boolean>)`{: .language-kube-21 #fluid-container-place-sources-supplier }: Set if the container can place source blocks in-world via a supplier, defaults to `() => false`{:.language-kube-21}
