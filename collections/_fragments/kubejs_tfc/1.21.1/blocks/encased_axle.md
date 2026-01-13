---
title: Encased Axle
anchor: encased-axle
group: _
name: encased
type: tfc:encased-axle
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .extendedProperties(props => {
    - "    props.flammableLikePlanks()"
    - '})'
---

Creates a new encased axle block

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Method

- `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{: .language-kube-21 #{{ page.anchor }}-extended-properties }: Set the [extended-properties](#extended-properties) of the encased axle
