---
title: AFC Tapping
anchor: afc-tapping
func: tree_tapping
mod: afc
group: t
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For tapping trees for fluid
example:
    - "Fluid.of('minecraft:milk', 50),"
    - "'minecraft:oak_log'"
example_add:
    - ".requiresNaturalLog(false)"
    - ".tempRange(12, 60)"
sig:
    - "resultFluid: FluidStack,"
    - "inputBlock: BlockIngredient"
sig_add:
    - ".requiresNaturalLog(requiresNaturalLog: boolean)"
    - ".springOnly(springOnly?: boolean)"
    - ".mintemp(minimumTemperature: number)"
    - ".maxTemp(maximumTemperature: number)"
    - ".tempRange(minimumTemperature: number, maximumTemperature: number)"
---

- 1st argument: A fluid stack, the result of the recipe
- 2nd argument: A [[ bing ]], the block being tapped

<span></span>

- `.requiresNaturalLog(requiresNaturalLog: boolean)`{: .language-kube-21 #{{ page.anchor }}-requires-natural-log }: Accepts a boolean, if the block being tapped must have TFC's `branch_direction` block state and its value is not `none`{:.e}. Defaults to `true`{:.p}
- `.springOnly(springOnly?: boolean)`{: .language-kube-21 #{{ page.anchor }}-spring-only }: Accepts a boolean, if the recipe may only be completed in the spring. Defaults to `false`{:.p}. Sets to `true`{:.p} if no value is passed to the function
- `.minTemp(minimumTemperature: number)`{: .language-kube-21 #{{ page.anchor }}-min-temp }: Accepts a number, the minimum temperature (°C) the recipe can be performed in
- `.maxTemp(maximumTemperature: number)`{: .language-kube-21 #{{ page.anchor }}-max-temp }: Accepts a number, the maximum temperature (°C) the recipe can be performed in
- `.tempRange(minimumTemperature: number, maximumTemperature: number)`{: .language-kube-21 #{{ page.anchor }}-temp-range }: Accepts two numbers, the minimum and maximum temperature (°C) the recipe can be performed in
