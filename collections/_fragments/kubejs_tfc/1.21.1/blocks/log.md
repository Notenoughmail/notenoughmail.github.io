---
title: Log
anchor: log
type: tfc:log
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .stripped(null)
    - .extendedProperties(props => {
    - '    props.flammableLikeLogs()'
    - '})'
---

Creates a new log block

Inherits the methods of the default block builder

{: #log-methods }

## Extra Methods

- `.stripped(builder: @Nullable Consumer<LogBlockBuilder>)`{: .language-kube-21 #log-stripped }: Set the properties of the the log's stripped variant, or remove the stripped variant by passing `null`{:.p}. Accepts a consumer with the following methods
    - `.useFullBlockForItemModel()`{:.language-kube-21}: Set the item model generation to parent from the block model
    - `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{:.language-kube-21}: Set the [extended properties](#extended-properties) of the stripped log
    - All those of the default block builder
- `.useFullBlockForItemModel()`{: .language-kube-21 #log-use-full-block-for-item-model }: Set the item model generation to parent from the block model
- `.extendedProperties(extendedProperties: Consumer<ExtendedProperties>)`{: .language-kube-21 #log-extended-properties }: Set the [extended properties](#extended-properties) of the log block
