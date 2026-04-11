---
title: Pot
anchor: pot
mod: tfc
group: pot_
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For basic pot recipes
example:
    - "[ '#minecraft:flowers' ],"
    - "Fluid.water(1000),"
    - "50,"
    - "110"
example_add:
    - ".outputs('minecraft:bread', Fluid.of('minecraft:milk', 20))"
sig:
    - "ingredients: List<Ingredient>,"
    - "fluidIngredient: SizedFluidIngredient,"
    - "duration: int,"
    - "temperature: number"
sig_add:
    - ".fluidOutput(fluidOutput: FluidStack)"
    - ".itemOutput(itemOutput: List<ItemStackProvider>)"
    - ".outputs(itemOutput: List<ItemStackProvider?, fluidOutput: FluidStack)"
    - ".usesAllFluids(usesAllFluids: boolean)"
---

- 1st argument: A list of up to 5 item ingredients, the recipe inputs
- 2nd argument: A sized fluid ingredient, the fluid input of the recipe
- 3rd argument: A non-negative integer number, the number of ticks the pot must be boiling for
- 4th argument: A non-negative number, the temperature (°C) the pot must reach to be boiling

<span></span>

- `.fluidOutput(fluidOutput: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-fluid-output }: Accepts a fluid stack, the fluid result of the recipe
- `.itemOutput(itemOutput: List<ItemStackProvider>)`{: .language-kube-21 #{{ page.anchor }}-item-output }: Accepts a list of [[ isp ]]s, the item results of the recipe. The given list *must* be the same length as the `ingredients`{:.v} list
- `.outputs(itemOutput: List<ItemStackProvider>, fluidOutput: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-outputs }: Accepts a list of [[ isp ]]s and a fluid stack
- `.usesAllFluids(usesAllFluids: boolean)`{: .language-kube-21 #{{ page.anchor }}-uses-all-fluids }: Accepts a boolean, if the entirety of the fluid in the pot should be used. Defaults to `true`{:.p}
