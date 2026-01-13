---
type: client
name: placeItemModels
title: Placed Item Models
anchor: placed-item-model
cat:
    - kubejs_tfc
    - 1.21.1
    - event
example:
    - event.cutout('minecraft:iron_door', 'minecraft:block/glass')
---

TFC adds the ability to place items in-world via a keybind. By default the item model is displayed, but the ability to override the models used by specific items does exist. This event allows for scripts to define such overrides

{: #{{ page.anchor }}-methods }

## Methods

- `.cutout(item: Item, model: ResourceLocation): void`{: .language-kube-21 #{{ page.anchor }}-cutout }: Register the given model to the item with the `cutout` render type
- `.translucent(item: Item, model: ResourceLocation): void`{: .language-kube-21 #{{ page.anchor }}-translucent }: Register the given model to the item with the `translucent` render type
