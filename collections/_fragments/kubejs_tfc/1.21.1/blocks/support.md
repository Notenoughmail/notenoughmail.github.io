---
title: Support
anchor: support
group: _
type: tfc:support
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example: |-
    .connectionModel('kubejs:block/metal_connection')
    .extendedProperties(props => props.flammableLikeLogs())
    .horizontal(horizontal => {
        horizontal.extendedProperties(props => props.flammableLikePlanks())
    })
---

Creates a new support block

[[ base ]]

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.connectionModel(model: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-connection-model }: Set the model to use for sideways connections
- `.horizontal(id?: ResourceLocation, horizontalSupport: Consumer<HorizontalSupportBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-horizontal }: Set the properties of the horizontal support block. Accepts a consumer with the methods
    - [[ raw_props ]]
    - [[ def ]]
- [[ props ]]
