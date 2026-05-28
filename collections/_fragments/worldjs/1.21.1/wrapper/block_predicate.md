---
title: Block Predicate
anchor: block-predicate
cat:
    - worldjs
    - 1.21.1
    - wrapper
---

{% capture offset %}
`'offest'`{:.s}: A `Vec3i`, the offset applied to the check when validating a checked position
                - Optional, defaults to `[0, 0, 0]`{:.language-kube-21}
{% endcapture %}

[Block predicates](https://minecraft.wiki/w/Block_predicate) test for a block state at a position within the world

In scripts, they can de defined as

- A `BlockPredicate` object: itself
- A `Block` object: A `minecraft:matching_blocks` predicate matching the given block
- A `Fluid` object: A `minecraft:matching_fluids` predicate matching the given fluid
- A `TagKey` object: A `minecraft:matching_block_tag` predicate matching the given tag
- A string:
    - If starts with a `#` character: A `minecraft:matching_block_tag` predicate matching the given tag id
    - Else: A `minecraft:matching_blocks` predicate matching the given block id
- A list: A `minecraft:all_of` predicate
    - List values are expected to be block predicates (or capable of being wrapped as block predicates) themselves
- A `boolean`{:.p} object:
    - If `true`{:.p}: A `minecraft:true` predicate
    - If `false`{:.p}: A `minecraft:not` predicate wrapping a `minecraft:true` predicate
- A map:
    - If the map contains a `'type'`{:.s} field, the map is parsed as if it were defined in json, using the specification linked above
    - If the map contains a `'not'`{:.s} field, a `minecraft:not` predicate will be made
        - The `not` object is expected to be a block predicate or capable of being wrapped as a block predicate
    - If the map contains an `'all'`{:.s} field, a `minecraft:all_of` predicate will be made
        - The `all` object is expected to be a list whose values are block predicates themselves (or are capable of being wrapped as block predicates) themselves
    - If the map contains an `'any'`{:.s} field, a `minecraft:any_of` predicate will be made
        - The `any` object is expected to be a list whose values are block predicates themselves (or are capable of being wrapped as block predicates) themselves
    - If the map contains a `'blocks'`{:.s} field, a `minecraft:matching_blocks` predicate is made
        - The `blocks` object is expected to be a map with the following fields
            - {{ offset }}
            - `'match'`{:.s}: A block `HolderSet`, the valid blocks
                - Most commonly a list of block ids, or a `#`-prefixed tag id
    - If the map contains a `'tag'`{:.s} field, a `minecraft:matching_block_tag` predicate is made
        - The `tag` object is expected to be a map with the following fields
            - {{ offset }}
            - `'match'`{:.s}: A block `TagKey`, the valid blocks
                - Can be defined as a string, the id of the tag
    - If the map contains a `'fluids'`{:.s} field, a `minecraft:matching_fluids` predicate is made
        - The `fluids` object is expected to be a map with the following fields
            - {{ offset }}
            - `'match'`{:.s}: A fluid `HolderSet`, the valid fluids
                - Most commonly a list of fluid ids, or a `#`-prefixed tag id
    - If the map contains a `'replaceable'`{:.s} field, a `minecraft:replaceable` predicate is made
        - The `replaceable` object is expected to be a map with the following field
            - {{ offset }}
    - If the map contains a `'would_survive'`{:.s} field, a `minecraft:would_survive` predicate is made
        - The `would_survive` object is expected to be a map with the following fields
            - {{ offset }}
            - `'state'`{:.s}: A block state, the state survivability is being checked with
    - If the map contains a `'has_sturdy_face'`{:.s} field, a `minecraft:has_sturdy_face` predicate is made
        - The `has_sturdy_face` object is expected to be an object with the following fields
            - {{ offset }}
            - `'direction'`{:.s}: A `Direction`{:.e}, the direction to check if a block is sturdy
                {% include enum_list.html summary='Reveal/hide list of allowed directions' values='up,down,east,west,north,south' %}
    - If the map contains a `'solid'`{:.s} field, a `minecraft:solid` predicate is made
        - The `solid` object is expected to be a map with the following field
            - {{ offset }}
    - If the map contains a `'no_fluid'`{:.s} field, a `minecraft:matching_fluids` predicate which only matches `minecraft:empty` is made
        - The `no_fluid` object is expected to be a map with the following field
            - {{ offset }}
    - If the map contains a `'inside_world'`{:.s} field, a `minecraft:inside_world_bounds` is made
        - The `inside_world` object is expected to be a map with the following field
            - {{ offset }}
    - If the map contains an `'unobstructed'`{:.s} field, a `minecraft:unobstructed` predicate is made
        - The `unobstructed` object is expected to be a map with the following field
            - {{ offset }}

Other values will emit an error
