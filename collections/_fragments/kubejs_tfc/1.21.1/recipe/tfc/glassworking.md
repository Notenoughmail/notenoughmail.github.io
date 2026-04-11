---
title: Glassworking
anchor: glassworking
mod: tfc
group: g
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For working glass on a blowpipe
example:
    - "'kubejs:glass_trinket',"
    - "'tfc:silica_glass_batch'"
    - '['
    - "    'tfc:pinch',"
    - "    'tfc:gold',"
    - "    'tfc:blow',"
    - "    'tfc:pyrite'"
    - ']'
sig:
    - 'result: ItemStackProvider,'
    - 'batch: Ingredient,'
    - 'operations: List<Holder<GlassOperation>>'
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: An item ingredient, the initial batch item added to the blowpipe
- 3rd argument: A list of glass operation ids. A full list of available operations can be seen by running the command `/kubejs dump_registry tfc:glass_operation`{:.language-command} in-game. Custom operations can be [registered]({% link kubejs_tfc/1.21.1/registry.md %}#glass-operation) via scripts
