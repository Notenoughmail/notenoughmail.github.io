---
title: Anvil
anchor: anvil
mod: tfc
group: a
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For working items on an anvil
example:
    - "'minecraft:iron_bars',"
    - "'minecraft:iron_nugget',"
    - '['
    - "    'hit_any',"
    - "    'upset_not_last'"
    - ']'
example_add:
    - '.tier(3)'
    - '.applyBonus()'
sig:
    - 'result: ItemStackProvider,'
    - 'ingredient: Ingredient,'
    - 'rules: List<ForgeRule>'
sig_add:
    - '.tier(tier: int)'
    - '.applyBonus(applyBonus?: boolean)'
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: An item ingredient, the recipe input
- 3rd argument: A list of one to three [`ForgeRule`{:.e}s](https://github.com/TerraFirmaCraft/TerraFirmaCraft/blob/1.21.x/src/main/java/net/dries007/tfc/common/component/forge/ForgeRule.java){:.preserve-color}, the last steps that must be taken.
    {% include enum_list.html summary='Reveal/hide list of valid rules' values='hit_any,hit_not_last,hit_last,hit_second_last,hit_third_last,draw_any,draw_last,draw_not_last,draw_second_last,draw_third_last,punch_any,punch_last,punch_not_last,punch_second_last,punch_third_last,bend_any,bend_last,bend_not_last,bend_second_last,bend_third_last,upset_any,upset_last,upset_not_last,upset_second_last,upset_third_last,shrink_any,shrink_last,shrink_not_last,shrink_second_last,shrink_third_last' %}

<span></span>

- `.tier(tier: int)`{: .language-kube-21 #{{ page.anchor }}-tier }: Accepts an integer number and sets the minimum anvil tier the recipe can be performed on, defaults to `0`{:.n}
- `.applyBonus(applyBonus?: boolean)`{: .language-kube-21 #{{ page.anchor }}-apply-bonus }: Accepts a boolean and sets if the recipe will apply a forging bonus. Default value is `false`{:.p}, calling with no parameters sets to `true`{;.p}
