---
title: Support
anchor: support
type: tfc:support
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .connectionModel('kubejs:block/metal_connection')
    - .extendedProperties(props => props.flammableLikeLogs())
    - .horizontal(horizontal => {
    - "    horizontal.extendedProperties(props => props.flammableLikePlanks())"
    - '})'
---

Creates a new support block

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.connectionModel(model: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-connection-model }: Set the model to use for sideways connections
- `.horizontal(horizontalSupport: Consumer<HorizontalSupportBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-horizontal }: Set the properties of the horizontal support block. Accepts a consumer with the methods
    - `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the horizontal support
    - All those of the default block builder
- `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{: .language-kube-21 #{{ page.anchor }}-extended-properties }: Set the [extended properties](#extended-properties) of the support

{% comment %}

## extended properties

{% endcomment %}
