---
title: Glassworking Tool
anchor: glassworking-tool
type: tfc:glassworking_tool
name: glass_knife
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .operation('kubejs:cut')
    - .knife()
---

Creates a new tool item which can perform a glassworking [operation]({% link kubejs_tfc/1.21.1/registry.md %}glass-operation)

Inherits the methods of the [tool item builder](#tool)

{: #glassworking-tool-methods }

## Extra Method

- `.operation(operation: holder<GlassOperation>)`{: .language-kube-21 #glassworking-tool-glass-operation }: Set the operation the tool performs, defaults to `tfc:saw`. A full list of available operations can be obtained by running the command `/kubejs dump_registry tfc:glass_operation` in-game
