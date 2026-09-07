---
title: Search
anchor: search
cat:
    - kubejs_tfc
    - 1.21.1
    - command
group: data
desc: Searching for the applicable data on an item/fluid/block/entity type
form: search <data_type> <value>
args:
    - '`<data_type>`[[1]]: The data type to retrieve the list from'
    - '`<value>`[[2]]: The registry id of the item/block/fluid/entity type that has a data entry in the data type. All objects with an associated data entry will be suggested'
exp: Prints a list of data entries which apply to a registry entry. Each entry can be clicked to [describe](#describe) it
---

Examples:

- `/kubejs_tfc search tfc:fluid_heat tfc:metal/copper`{: .language-command }
- `/kubejs_tfc search tfc:entity_damage_resistance minecraft:creeper`{: .language-command }
- `/kubejs_tfc search tfc:fertilizer tfc:powder/wood_ash`{: .language-command }
