---
title: Mixing Bowl
anchor: firmalife-mixing-bowl
func: mixing_bowl
mod: firmalife
group: m
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For mixing items and fluids in a mixing bowl
example: |-
    'minecraft:deepslate'
example_add: |-
    .resultItem('5x minecraft:short_grass')
    .fluidIngredient(Fluid.of('minecraft:water', 1000))
sig: |-
    itemIngredients: List<Ingredient>
sig_add: |-
    .fluidIngredient(fluidIngredient: SizedFluidIngredient)
    .resultItem(resultItem: ItemStack)
    .resultFluid(resultFluid: FluidStack)
    .results(resultItem: ItemStack, resultFluid: FluidStack)
---

- 1st argument: A list of item ingredients, the item inputs

<span></span>

- `.fluidIngredient(fluidIngredient: SizedFluidIngredient)`{: .language-kube-21 #{{ page.anchor }}-fluid-ingredient }: Accepts a sized fluid ingredient, the optional fluid input of the recipe
- `.resultItem(resultItem: ItemStack)`{: .language-kube-21 #{{ page.anchor }}-result-item }: Accepts an item stack, the optional item output of the recipe
- `.resultFluid(resultFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-result-fluid }: Accepts a fluid stack, the optional fluid result of the recipe
- `.results(resultItem: ItemStack, resultFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-results }: Accepts an item stack and a fluid stack, the optional results of the recipe
