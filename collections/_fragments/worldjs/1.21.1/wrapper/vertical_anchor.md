---
title: Vertical Anchor
anchor: vertical-anchor
cat:
    - worldjs
    - 1.21.1
    - wrapper
---

[Vertical anchors](https://minecraft.wiki/w/Custom_world_generation/vertical_anchor) specify a y-value for feature generation, often as part of [[ height_provider ]]s

In scripts, they can be defined as

- A single number: An `absolute` anchor at the given y-level
- A string:
    - If `'bottom'`{:.s}: An `above_bottom` anchor with a value of `0`{:.n}
    - If `'top'`{:.s}: A `below_top` anchor with a value of `0`{:.n}
    - If `'-'`{:.s} or `'zero'`{:.s}: An `absolute` anchor with a value of `0`{:.n}
- A map:
    - If the map contains a `'type'`{:.s} field, the map is parsed as if it were defined in json, using the specification linked above
    - If the map contains an `'absolute'`{:.s} field, an `absolute` anchor is created. The `absolute` object will be parsed as a number to use as the value of the anchor
    - If the map contains a `'above_bottom'`{:.s} field, a `above_bottom` anchor is created. The `above_bottom` object will be parsed as a number to use as the value of the anchor
    - if the map contains a `'below_top'`{:.s} field, a `below_top` anchor is created. The `below_top` object will be parsed as a number to use as the value of the anchor
- A `VerticalAnchor` object: itself

Other values will emit an error
