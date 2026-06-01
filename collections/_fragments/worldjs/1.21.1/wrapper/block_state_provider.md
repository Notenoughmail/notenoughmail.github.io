---
title: Block State Provider
anchor: block-state-provider
cat:
    - worldjs
    - 1.21.1
    - wrapper
---

[Block state providers](https://minecraft.wiki/w/Block_state_provider?oldid=3339436) specify a block(state) which may be randomized

In scripts, they can be defined as

- A `BlockStateProvider` object: itself
- A `Block` object: A `minecraft:simple_state_provider` providing the given block
- A `BlockState` object: A `minecraft:simple_state_provider` providing the given block state
- A list: A `minecraft:weighted_state_provider` provider
    - List values are expected to be block state provider [[ weighted_value ]]s
- A map:
    - If the map contains a `'type'`{:.s} field, the map is parsed as if it were defined in json, using the specification linked above
    - If the map contains a `'simple'`{:.s} or `'block'`{:.s} field, a `minecraft:simple_state_provider` provider will be made
        - The `simple`/`block` object is expected to be a block state or capable of being wrapped as a block state
    - If the map contains a `'rotate'`{:.s} field, a `minecraft:rotated_block_provider` will be created
        - The `rotate` object is expected to be a block or capable of being wrapped as a block
    - If the map contains a `'randomized_int'`{:.s} field, a `minecraft:randomized_int_state_provider` provider will be created
        - The `randomized_int` object is expected to be a map with the following fields
            - `'property'`{:.s}: A string, the name of the block property
            - `'values'`{:.s}: An `IntProvider`, the possible values of the block property
            - `'source'`{:.s}: A `BlockStateProvider`, the source state to apply the property value to
    - If the map contains a `'weighted'`{:.s} field, a `minecraft:weighted_state_provider` provider will be made
        - The `weighted` object is expected to be a list of block state provider [[ weighted_value ]]s

Other values will be attempted to be parsed as a `BlockState` and if successful, a `minecraft:simple_state_provider` will be made, else an error will be emitted
