---
title: Hammer
anchor: hammer
type: tfc:hammer
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .tripHammerTexture('tfc:block/metal/smooth/red_steel')
    - .speed(1.5)
---

Creates a new hammer item

Inherits the methods of the [chisel item builder](#chisel)

{: #{{ page.anchor }}-methods }

## Extra Method

- `.tripHammerTexture(texture: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-trip-hammer-texture }: Set the texture the hammer uses while in a trip hammer and add the hammer to the `tfc:trip_hammers` tag
