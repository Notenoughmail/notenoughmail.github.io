---
title: Knapping
anchor: knapping
mod: tfc
group: k
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For knapping recipes, performed by right-clicking the input ingredient in the air and 'shaping' a 5 x 5 grid
example:
    - "'minecraft:obsidian',"
    - "'tfc:clay',"
    - '['
    - "    'X X',"
    - "    ' X ',"
    - "    'X X',"
    - ']'
sig:
    - 'result: ItemStack,'
    - 'knappingType: ResourceLocation,'
    - 'pattern: List<String>'
sig_add:
    - '.ingredient(ingredient: Ingredient)'
    - '.defaultOn(defaultOn?: boolean)'
---

- 1st argument: An item stack, the output of the recipe
- 2nd argument: A `ResourceLocation`, the id of a [knapping type]({% link kubejs_tfc/1.21.1/data.md %}#knapping-type), the knapping behavior definition
- 3rd argument: A list of strings, the knapping pattern. The list may have between 1 and 5 strings, all rows must have the same length, and each row may be between 1 and 5 characters long. In the pattern, spaces mean the square must be clicked off/deactivated

<span></span>

- `.ingredient(ingredient: Ingredient)`{: .language-kube-21 #{{ page.anchor }}-ingredient }: An item ingredient, specifies a specific sub-set of the knapping type's ingredient to use
- `.defaultOn(defaultOn?: boolean)`{: .language-kube-21 #{{ page.anchor }}-default-on }: Optionally accepts a boolean, if the values outside the defined pattern should be active or deactivated to match with non 5 x 5 patterns. Defaults to `false`{:.p}. Sets to `true`{:.p} if no value is passed to the function
