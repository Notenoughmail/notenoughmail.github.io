---
title: Glassworking
anchor: glassworking
type: tfc:glassworking
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .operation('tfc:saw')
---

Creates a new item which can perform a glassworking [operation]({% link kubejs_tfc/1.21.1/registry.md %}#glass-operation)

Inherits the methods of the default item builder

{: #{{ page.anchor }}-methods }

## Extra Method

- `.operation(operation: Holder<GlassOperation>)`{: .language-kube-21 #{{ page.anchor }}-operation }: Set the operation the item performs. A full list of available operations can be obtained by running the command `/kubejs dump_registries tfc:glass_operation`{:.language-command} in-game
