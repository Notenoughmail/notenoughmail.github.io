---
title: Jug
anchor: jug
type: tfc:jug
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .filledDisplayName("Big 'ol Jug of %s")
    - .displayName('Big Jug')
    - .textures('tfc:item/ceramic/jug_empty', 'tfc:item/ceramic/jug_overlay')
    - .capacity(5000)
---

Creates a new jug item

Inherits the methods the default item builder

{: #jug-methods }

## Extra Methods

- `.filledDisplayName(text: String)`{: .language-kube-21 #jug-filled-display-name }: Set the `en_us` text of the jug's display when it contains fluid. The `%s`{:.s} template can be used to place the fluid's name where wanted
- `.textures(base: String, fluid: String)`{: .language-kube-21 #jug-textures }: Set the base and fluid overlay texture of the jug's model. See [an example from TFC](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/resources/assets/tfc/textures/item/metal/bucket/overlay.png) for what an overlay texture should look like
- `.capacity(amount: int)`{: .language-kube-21 #jug-capacity }: Set how much fluid, in mB, the jug can hold. Defaults to `100`{:.n}
- `.capacitySupplier(amount: Supplier<int>)`{: .language-kube-21 #jug-capacity-supplier }: Set how much fluid, in mB, the jug can hold via a supplier. Defaults to `() => 100`{:.language-kube-21}
- `.allowedFluids(allowed: TagKey<Fluid>)`{: .language-kube-21 #jug-allowed-fluids }: Set which fluids the jug can hold via a tag, defaults to `tfc:usable_in_jug`
