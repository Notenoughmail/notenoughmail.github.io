---
title: Sewing
anchor: sewing
mod: tfc
group: s
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For sewing items in a sewing table
example:
    - "'minecraft:cobblestone',"
    - "["
    - "    '## ### ##',"
    - "    '# #   # #',"
    - "    ' # ### # ',"
    - "    '# #   # #',"
    - "    '## ### ##'"
    - "],"
    - "["
    - "    ' BBWWBB ',"
    - "    'BBW  WBB',"
    - "    'W  BB  W',"
    - "    '  WBBW  '"
    - "]"
sig:
    - "result: ItemStack,"
    - "stitches: List<String>"
    - "squares: List<String>"
---

- 1st argument: An item stack, the result of the recipe
- 2nd argument: A list of strings, the stitch pattern in the sewing table. The list must have 5 values, each 9 characters long. A space character indicates no stitch at that position
- 3rd argument: A list of strings, the fabric square pattern in the sewing table. The list must have 4 values, each 8 characters long. Acceptable characters are ` `, `B`, and `W` for empty, burlap, and wool respectively
