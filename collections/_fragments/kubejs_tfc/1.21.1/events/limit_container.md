---
type: server
target-type: ResourceKey<MenuType<?>>
name: limitContainer
title: Limit Container
anchor: limit-container
cat:
    - kubejs_tfc
    - 1.21.1
    - event
target: minecraft:generic_9x3
example:
    - event.limit('small', 0, 9)
    - event.limit('large', 18, 27)
    - event.lowerLimit('very_small', false)
---

TFC has an item size feature which it uses, in its own containers, to limit what items can enter. Via this event, KubeJS TFC allows for this behavior to be replicated with arbitrary containers, with some limitations

- It will only apply to containers with a registered `MenuType<?>`
- It only applies upon a plyer interaction
- It only applies upon *closing* and *opening* the container screen, not any intermediate actions

The basic idea and functionality of the event is based on [Oversized Item In Storage Area](https://github.com/DoubleDoorDevelopment/OversizedItemInStorageArea), a 1.12 addon that did similar

Upon the player opening/closing a container handled by this event, any items that are

1. in the limited slots
2. are not within the size limits

will be removed from the container and spawned around the player in-world

{: #{{ page.anchor }}-methods }

## Methods

- `.limit(size: Size, allowsEqual?: boolean): void`{: .language-kube-21 #{{ page.anchor }}-limit-0 }: Limits the entire container to the specified size, requiring any items in it to be smaller than the provided size. `allowsEqual`{:.v} determines if a `size`{:.v} of `small`{:.e} will permit items of size `small`{:.e} to remain in the container, defaults to `true`{:.p}
- `.limit(size: Size, min: int, max: int, allowsEqual?: boolean): void`{: .language-kube-21 #{{ page.anchor }}-limit-1 }: Limits the specified slot index range to the specified size, requiring any items in it to be smaller than the provided size. `allowsEqual`{:.v} determines if a `size`{:.v} of `small`{:.e} permits items of size `small`{:.e} to remain in the container, defaults to `true`{:.p}
- `.lowerLimit(size: Size, allowsEqual?: boolean): void`{: .language-kube-21 #{{ page.anchor }}-lower-limit-0 }: Limits the entire container to the specified size, requiring any items in it to be larger than the provided size. `allowsEqual`{:.v} determines if a `size`{:.v} of `small`{:.e} will permit items with a size of `small`{:.e} to remain in the container, defaults to `true`{:.p}
- `.lowerLimit(size: Size, min: int, max: int, allowsEqual?: boolean): void`{: .language-kube-21 #{{ page.anchor }}-lower-limit-1 }: Limits the specified slot index range to the specified size, requiring any items in it to be larger than the provided size. `allowsEqual`{:.v} determines if a `size`{:.v} of `small`{:.e} will permit items with a size of `small`{:.e} to remain in the container, defaults to `true`{:.p}
