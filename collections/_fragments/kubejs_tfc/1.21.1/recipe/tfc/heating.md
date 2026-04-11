---
title: Heating
anchor: heating
mod: tfc
group: h
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For heating items in firepits, crucibles, pit kilns, etc.
example:
    - "'minecraft:iron_axe',"
    - '1500'
example_add:
    - ".outputFluid(Fluid.of('tfc:metal/cast_iron', 100))"
    - ".useDurability()"
sig:
    - 'ingredient: Ingredient,'
    - 'temperature: number'
sig_add:
    - '.itemOutput(resultItem: ItemStackProvider)'
    - '.fluidOutput(resultFluid: FluidStack)'
    - '.outputs(resultItem: ItemStackProvider, resultFluid: FluidStack)'
    - '.resultItem(resultItem: ItemStackProvider)'
    - '.resultFluid(fluidResult: FluidStack)'
    - '.results(resultItem: ItemStackProvider, resultFluid: FluidStack)'
    - '.useDurability(useDurability?: boolean)'
---

- 1st argument: An item ingredient, the item being heated
- 2nd argument: A number, {% in_range 0,Infinity,) %}, the temperature (°C) the item needs to reach for the recipe to complete

<span></span>

- `.itemOutput(resultItem: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-item-output }: Accepts an [[ isp ]], the item result of heating
- `.fluidOutput(fluidResult: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-fluid-output }: Accepts a fluid stack, the fluid result of heating
- `.outputs(resultItem: ItemStackProvider, resultFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-outputs }: Accepts an [[ isp ]] and a fluid stack, the item and fluid results of the recipe
- `.resultItem(resultItem: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-result-item }: An alias of [`.itemOutput(...)`{:.language-kube-21}](#{{ page.anchor }}-item-output){:.preserve-color}
- `.resultFluid(resultFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-result-fluid }: An alias of [`.fluidOutput(...)`{:.language-kube-21}](#{{ page.anchor }}-fluid-output){:.preserve-color}
- `.results(resultItem: ItemStackProvider, resultFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-results }: An alias of [`.outputs(...)`{:.language-kube-21}](#{{ page.anchor }}-outputs){:.preserve-color}
- `.useDurability(useDurability?: boolean)`{: .language-kube-21 #{{ page.anchor }}-use-durability }: Accepts a boolean, if the recipe should scale the fluid output by the input's durability. Defaults to `false`{:.p} and calling with no args will set to `true`{:.p}

{: .notice #{{ page.anchor }}-heat-notice }
> In order for the recipe to work, the ingredient must have an [item heat]({% link kubejs_tfc/1.21.1/data.md %}#heat)
>
> If the recipe has a fluid result, the fluid must have a matching [fluid heat]({% link kubejs_tfc/1.21.1/data.md %}#fluid-heat) to work with crucibles
