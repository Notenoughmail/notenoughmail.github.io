---
title: Condition Source
anchor: condition-source
cat:
    - worldjs
    - 1.21.1
    - wrapper
---

[Condition sources](https://minecraft.wiki/w/Surface_rule?oldid=3066946#Surface_conditions) are used by `minecraft:condition` [rule sources](#rule-source) to decide if their sub-source should be used

In scripts, they can be defined as

- A string:
    - If `'above_preliminary_surface'`{:.s}: A `minecraft:above_preliminary_surface` condition source
    - If `'hole'`{:.s}: A `minecraft:hole` condition source
    - If `'temperature'`{:.s}: A `minecraft:temperature` condition source
    - If `'steep'`{:.s}: A `minecraft:steep` condition source
- A list: A `minecraft:biome` condition source
    - List elements are expected to be biome ids
- A map:
    - If the map contains a `'type'`{:.s} field, the map is parsed as if it were defined in json, using the specification linked above
    - If the map contains a `'biome'`{:.s} field, a `minecraft:biome` condition source will be created
        - The `biome` object is expected to be a list whose entries are biome ids
    - If the map contains a `'noise_threshold'`{:.s} field, a `minecraft:noise_threshold` condition source will be made
        - The `noise_threshold` object is expected to be a map with the following fields
            - `'noise'`{:.s}: The id of a [noise](https://minecraft.wiki/w/Noise?oldid=3290722)
            - `'min_threshold'`{:.s}: A `number`{:.p}, the minimum noise value where the condition passes
            - `'max_threshold'`{:.s}: A `number`{:.p}, the maximum noise value where the condition passes
                - Optional, defaults to `(2 - Math.power(2, -52)) * Math.power(2, 1023)`{:.language-kube-21}
    - If the map contains a `'vertical_gradient'`{:.s} field, a `minecraft:vertical_gradient` condition source will be created
        - The `vertical_gradient` object is expected to be a map with the following fields
            - `'random_name'`{:.s}: A string
            - `'true_at_and_below'`{:.s}: A [[ vertical_anchor ]], the condition will always pass at and below this height
            - `'false_at_and_above'`{:.s}: A [[ vertical_anchor ]], the condition will always pass at and above this height
    - If the map contains a `'y_above'`{:.s} field, a `minecraft:y_above` condition source will be created
        - The `y_above` object is expected to be a map with the following fields
            - `'add_stone_depth'`{:.s}: A `boolean`{:.p}, If the distance to the surface above should be added
                - Optional, defaults to `false`{:.p}
            - `'anchor'`{:.s}: A [[ vertical_anchor ]], the anchor to compare the height to
            - `'surface_depth_multiplier'`{:.s}: A `int`{:.p}, how much the comparison is affected by the surface depth
                - Must be {% in_range -20,20 %}
    - If the map contains a `'water'`{:.s} field, a `minecraft:water` condition source will be created
        - The `water` field is expected to be a map with the following fields
            - `'offset'`{:.s}: An `int`{:.p}, the value added to the water depth before comparison
            - `'surface_depth_multiplier'`{:.s}: An `int`{:.p}, how much the comparison is affected by the surface depth
                - Must be {% in_range -20,20 %}
            - `'add_stone_depth'`{:.s}: A `boolean`{:.p}, if the distance to the surface should be added to the offset
                - Optional, defaults to `false`{:.p}
    - If the map contains a `'temperature'`{:.s} field, a `minecraft:temperature` condition source will be created
    - If the map contains a `'steep'`{:.s} field, a `minecraft:steep` condition source will be created
    - If the map contains a `'not'`{:.s} field, a `minecraft:not` condition source will be created
        - The `not` field is expected to be a condition source, the condition source to invert
    - If the map contains a `'hole'`{:.s} field, a `minecraft:hole` condition source will be created
    - If the map contains a `'above_preliminary_surface'`{:.s} field, a `minecraft:above_preliminary_surface` condition surface will be created
    - If the map contains a `'stone_depth'`{:.s} field, a `minecraft:stone_depth` condition source will be created
        - The `stone_depth` object is expected to be a map with the following fields
            - `'offset'`{:.s}: An `int`{:.p}, the vertical offset
            - `'add_surface_depth'`{:.s}: A `boolean`{:.p}, if the surface depth should be added to the offset
                - Optional, defaults to `false`{:.p}
            - `'secondary_depth_range'`{:.s}: An `int`{:.p}, the mapped value of the secondary surface depth to add to the offset
            - `'surface_type'`{:.s}: A `CaveSurface`{:.e}, the surface type to compare to
                {% include enum_list.html summary='Reveal/hide valid cave surfaces' values='floor,ceiling' %}

Other values will emit an error
