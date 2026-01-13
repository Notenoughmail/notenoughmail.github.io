---
title: Groundcover
anchor: groundcover
group: _
type: tfc:groundcover
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .groundcoverModelShape('bone')
    - .withPreexistingItem('bones:bone_spear')
---

Creates a new groundcover block

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.ore()`{: .language-kube-21 #{{ page.anchor }}-ore }: Gives the block the same bounding/hit box as ore pieces
- `.twig()`{: .language-kube-21 #{{ page.anchor }}-twig }: Gives the block the same bounding/hit box as twigs
- `.groundcoverModelShape(shape: String)`{: .language-kube-21 #{{ page.anchor }}-groundcover-model-shape }: Set the parent model to `kubejs_tfc:block/groundcover/<shape>`{:.language-fs}
- `.collision()`{: .language-kube-21 #{{ page.anchor }}-collision }: Set the block as having collision
- `.withPreexistingItem(item: Holder<Item>)`{: .language-kube-21 #{{ page.anchor }}-with-preexisting-item }: Set the block item and clone item of the block to the given item
- `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{: .language-kube-21 #{{ page.anchor }}-extended-properties }: Set the [extended properties](#extended-properties) of the block
