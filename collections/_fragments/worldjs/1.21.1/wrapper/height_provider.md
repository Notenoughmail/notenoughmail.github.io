---
title: Height Provider
anchor: height-provider
cat:
    - worldjs
    - 1.21.1
    - wrapper
---

[Height providers](https://minecraft.wiki/w/Custom_world_generation/height_provider) specify a height (range) to select from when generating certain features

In scripts, they can be defined as

- A single number: A `minecraft:constant` height provider with an `absolute` [[ vertical_anchor ]] of the given y-level
- A map:
    - If the map contains a `'type'`{:.s} field, the map is parsed as if it were defined in json, using the specification linked above
    - If the map contains a `'uniform'`{:.s} field, a `minecraft:uniform` height provider will be created. The `uniform` object is expected to be a map with two fields
        - `'min'`{:.s}: A [[ vertical_anchor ]], the minimum height
        - `'max'`{:.s}: A [[ vertical_anchor ]], the maximum height
    - If the map contains a `'constant'`{:.s} field, a `minecraft:constant` height provider will be created. The `constant` object will be parsed as a [[ vertical anchor ]], the height
    - If the map contains a `'trapezoid'`{:.s} field, a `minecraft:trapezoid` height provider will be created. The `trapezoid` object is expected to be a map with the following fields
        - `'min'`{:.s}: A [[ vertical_anchor ]], the minimum height
        - `'max'`{:.s}: A [[ vertical_anchor ]], the maximum height
        - `'plateau'`{:.s}: An `int`{:.p}, the range in the middle of the trapezoid distribution that has a uniform distribution. Optional, defaults to `0`{:.n}
    - If the map contains a `'weighted'`{:.s} field, a `minecraft:weighted_list` height provider will be created. The `weighted` object is expected to a list of height provider [[ weighted_value ]]s
    - If the map contains a `'biased'`{:.s} field, a `minecraft:biased_to_bottom` height provider will be created. The `biased` object is expected to be a map with the following fields
        - `'min'`{:.s}: A [[ vertical_anchor ]], the minimum height
        - `'max'`{:.s}: A [[ vertical_anchor ]], the maximum height
        - `'inner'`{:.s}: An `int`{:.p}, the inner value. Optional, defaults to `1`{:.n}
        - `'extreme'`{:.s}: A `boolean`{.p}, if the height provider should instead be a `minecraft:very_biased_to_bottom` height provider. Optional, defaults to `false`{:.p}
- A list: A `minecraft:weighted_list` height provider. List values are expected to be height provider [[ weighted_value ]]s
- A `HeightProvider` object: itself
- A `VerticalAnchor` object: a `minecraft:constant` height provider at the given [[ vertical_anchor ]]

Other values will emit an error
