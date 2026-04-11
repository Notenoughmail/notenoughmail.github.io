---
title: Alloy
anchor: alloy
mod: tfc
group: a
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For allying metals in a crucible
example:
    - "'minecraft:lava'"
    - '['
    - '    {'
    - "        fluid: 'minecraft:water',"
    - "        min: 0.2,"
    - "        max: 0.8"
    - '    },'
    - '    {'
    - "        fluid: 'minecraft:milk',"
    - "        min: 0.2,"
    - "        max: 0.8"
    - '    }'
    - ']'
sig:
    - 'result: Fluid,'
    - 'contents: List<AlloyRange>'
---

- 1st argument: The resultant fluid
- 2nd argument: A list of alloy ranges, which can be created as a map of parameters to values
    - `fluid: Fluid`{:.language-kube-21}: The component fluid
    - `min: number`{:.language-kube-21}: The minimum fraction, {% in_unit %}, of the total fluid that needs to be this fluid
    - `max: number`{:.language-kube-21}: The maximum fraction, {% in_unit %}, of the total fluid that may be this fluid
