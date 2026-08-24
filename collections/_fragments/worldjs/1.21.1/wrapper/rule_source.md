---
title: Rule Source
anchor: rule-source
cat:
    - worldjs
    - 1.21.1
    - wrapper
---

[Rule sources](https://minecraft.wiki/w/Surface_rule?oldid=3066946) determine the block for each solid position of the terrain

In scripts, they can be defined as

- A `RuleSource` object: itself
- The string `'badlands'`{:.s}: a `minecraft:badlands` rule source
- A list: A `minecraft:sequence` rule source
    - List values will be parsed as rule sources, the rules for the sequence
- A map:
    - If the map contains a `'type'`{:.s} field, the map is parsed as if it were defined in json, using the specification linked above
    - If the map contains a `'badlands'`{:.s} field, a `minecraft:badlands` rule source
    - If the map contains a `'sequence'`{:.s} field, a `minecraft:sequence` rule source will be created
        - The `sequence` object is expected to a list
            - The list entries will be parsed as rule sources, the rules of the sequence
    - If the map contains a `'block'`{:.s} field, a `minecraft:block` rule source will be created
        - The `block` object is expected to be a block state
    - If the map contains a `'condition'`{:.s} field, a `minecraft:condition` rule source will be created
        - The `condition` object is expected to be a map with the following fields
            - `'if_true'`{:.s}: A [condition source](#condition-source)
            - `'then_run'`{:.s}: A rule source
- A block state, or anything which can parse as one: A `minecraft:block` rule source placing that block state is placed

Other values will emit an error
