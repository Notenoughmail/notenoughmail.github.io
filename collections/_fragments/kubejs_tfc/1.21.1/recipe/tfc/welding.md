---
title: Welding
anchor: welding
mod: tfc
group: w
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For welding items on an anvil
example:
    - "'minecraft:obsidian',"
    - "'minecraft:water_bucket',"
    - "'minecraft:lava_bucket'"
example_add:
    - ".tier(4)"
sig:
    - "result: ItemStackProvider,"
    - "firstInput: Ingredient,"
    - "secondInput: Ingredient"
sig_add:
    - ".tier(tier: int)"
    - ".bonusBehavior(bonus: BonusBehavior)"
---

- 1st argument: An [[ isp ]], the result of the recipe
- 2nd argument: An item ingredient, one of the items welded
- 3rd argument: An item ingredient, one of the items welded

<span></span>

- `.tier(tier: int)`{: .language-kube-21 #{{ page.anchor }}-tier }: Accepts a number and sets the minimum anvil tier required to perform the recipe, defaults to `0`{:.n}
- `.bonusBehavior(bonus: BonusBehavior)`{: .language-kube-21 #{{ page.anchor }}-bonus-behavior }: Sets the behavior for copying forging bonuses from the inputs. Accepts a `BonusBehavior`{:.e}, of which there are three
    - `copy_best`{:.e}: Copy the best forging bonus of the inputs
    - `copy_worst`{:.e}: Copy the worst forging bonus of the inputs
    - `ignore`{:.e}: Do not apply any bonus to the output, the default value
