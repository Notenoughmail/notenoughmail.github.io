---
title: Dirt
anchor: dirt
type: tfc:dirt
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .texture('tfc:block/charcoal_pile')
    - .grass(grass => {
    - "    grass.texture('tfc:block/wood/planks/oak')"
    - '})'
---

Creates a new TFC dirt block

Inherits the methods of the default block builder

{:# dirt-methods }

## Extra Methods

- `.grass(grass: Consumer<ConnectedGrassBlockBuilder>)`{: .language-kube-21 #dirt-grass }: Set the properties of the dirt's grass block. Accepts a consumer with the methods
    - `.models(models: BiConsumer<GrassModelPart, ModelGenerator>)`{:.language-kube-21}: Set the model generation of the grass block. Accepts a callback with two arguments, the second being a model generator and the first being an object with four accessible fields
        - `.snowy: boolean`{:.language-kube-21}: If the model is for a snowy state
        - `.side: boolean`{:.language-kube-21}: If the model is for the side of the grass block
        - `.top: boolean`{:.language-kube-21}: If the model is for the top of the grass block
        - `.bottom: boolean`{:.language-kube-21}: If the model is for the bottom of the grass block
    - All those of the default block builder
- `.path(path: Consumer<TFCPathBlockBuilder>)`{: .language-kube-21 #dirt-path }: Create and set the properties of the path block associated with the dirt block. Accepts a consumer with the same methods as the base block builder
- `.farmland(farmland: Consumer<TFCFarmlandBlockBuilder>)`{: .language-kube-21 #dirt-farmland }: Create and set the properties of the farmland block associated with the dirt block. Accepts a consumer with the methods
    - `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the farmland block
    - All those of the default block builder
- `.rooted(rooted: Consumer<TFCRootedDirtBlockBuilder>)`{: .language-kube-21 #dirt-rooted }: Set the properties of the dirt's rooted dirt block. Accepts a consumer with the same methods as the default block builder
- `.mud(mud: Consumer<BlockBuilder>)`{: .language-kube-21 #dirt-mud }: Set the properties of the dirt's mud block. Accepts a consumer with the same methods as the default block builder
