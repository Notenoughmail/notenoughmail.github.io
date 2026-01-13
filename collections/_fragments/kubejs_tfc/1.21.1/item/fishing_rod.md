---
title: Fishing Rod
anchor: fishing-rod
type: tfc:fishing_rod
name: fishing_rod
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .fishingStrength(12)
    - .texture('minecraft:block/dirt')
    - .largeBait()
---

Creates a new TFC fishing rod item

Inherits the methods of the default item builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.fishingStrength(f: number)`{: .language-kube-21 #{{ page.anchor }}-fishing-strength }: Set the strength of the fishing rod, defaults to `1`{:.n}
- `.castModel(model: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-cast-model }: Set the model to use while the rod is cast, defaults to `minecraft:item/fishing_rod/cast`
- `.smallBait()`{: .language-kube-21 #{{ page.anchor }}-small-bait }: Allow the rod to accept small bait by adding it to the `tfc:holds_small_fishing_bait` tag
- `.largeBait()`{: .language-kube-21 #{{ page.anchor }}-large-bait }: Allow the rod to accept large bait by adding it to the `tfc:holds_large_fishing_bait` tag
