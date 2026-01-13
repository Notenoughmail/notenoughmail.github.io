---
title: Mold
anchor: mold
type: tfc:mold
name: happy_mold
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .textures('kubejs:item/happy_mold_empty', 'kubejs:item/happy_mold_overlay')
    - .capacity(15)
    - .allowFluids('kubejs:happy_fluids')
    - .moldTable([
    - "    'XXXXXXXXXXXXXX',"
    - "    'XXXXXXXXXXXXXX',"
    - "    'XXXXXXXXXXXXXX',"
    - "    'XX  XXXXXX  XX',"
    - "    'XX  XXXXXX  XX',"
    - "    'XXXXXXXXXXXXXX',"
    - "    'XXXXXXXXXXXXXX',"
    - "    'X XXXXXXXXXX X',"
    - "    'X XXXXXXXXXX X',"
    - "    'XX XXXXXXXX XX',"
    - "    'XXX  XXXX  XXX',"
    - "    'XXXXX    XXXXX',"
    - "    'XXXXXXXXXXXXXX',"
    - "    'XXXXXXXXXXXXXX'"
    - '])'
---

Creates a new mold item

Inherits the methods of the default item builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.moldTable(pattern: String[14], textures?: Map<String, String>)`{: language-kube-21 #{{ page.anchor }}-mold-table }: Allow the mold to be put in the mold table by adding it to the `tfc:usable_in_mold_table` tag and generating a model for it
    - `pattern: String[14]`{:.language-kube-21}: An array of strings, the shape of the model in the model table. The array must have 14 values, each 14 characters long. Empty spaces will be 'carved out'
    - `textures?: Map<String, String>`{:.language-kube-21}: The textures of the model in the mold table. The texture keys are `0` and `particle`. Optional, defaults to adding `tfc:block/mold` to both
- `.textures(base: String, fluid: String)`{: .language-kube-21 #{{ page.anchor }}-textures }: Set the base and fluid overlay texture of the mold's model. See [TFC](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/resources/assets/tfc/textures/item/metal/bucket/overlay.png) for what an overlay texture should look like
- `.capacity(amount: int)`{: .language-kube-21 #{{ page.anchor }}-capacity }: Set how much fluid, in mB, the mold can hold. Defaults to `100`{:.n}
- `.capacitySupplier(amount: Supplier<int>)`{: .language-kube-21 #{{ page.anchor }}-capacity-supplier }: Set how much fluid, in mB, the mold can hold via a supplier. Defaults to `() => 100`{:.language-kube-21}
- `.allowedFluids(allowed: TagKey<Fluid>)`{: .language-kube-21 #{{ page.anchor }}-allowed-fluids }: Set which fluids the mold can hold via a tag, defaults to `tfc:usable_in_jug`
