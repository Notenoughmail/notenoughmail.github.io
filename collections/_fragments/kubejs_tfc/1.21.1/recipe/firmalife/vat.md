---
title: Vat
anchor: firmalife-vat
func: vat
mod: firmalife
group: v
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For cooking items and fluids in a vat
example: |-
    'minecraft:pink_wool',
    Fluid.of('minecraft:lava', 500),
    60,
    700
example_add: |-
    .outputItem('minecraft:dirt')
sig: |-
    inputItem: SizedIngredient,
    inputFluid: SizedFluidIngredient,
    length: int,
    temperature: number
sig_add: |-
    .outputItem(outputItem: ItemStackProvider)
    .jarOutput(jarOutput: ItemStack)
    .outputFluid(outputFluid: FluidStack)
    .outputTexture(outputTexture: ResourceLocation)
    .outputs(jarOutput?: ItemStack, outputItem: ItemStackProvider, outputFluid: FluidStack)
---

- 1st argument: A sized item ingredient, the recipe input
- 2nd argument: A sized fluid ingredient, the recipe fluid input
- 3rd argument: A positive integer number, the number of ticks the vat must be boiling for
- 4th argument: A non-negative number, the temperature (°C) the vat must reach to start boiling

<span></span>

- `.outputItem(outputItem: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-output-item }: Accepts an [[ isp ]], the optional item output of the recipe
- `.jarOutput(jarOutput: ItemStack)`{: .language-kube-21 #{{ page.anchor }}-jar-output }: Accepts an item stack, the optional jar output of the recipe
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-output-fluid }: Accepts a fluid stack, the optional fluid output of the recipe
- `.outputTexture(outputTexture: ResourceLocation)`{: .language-kube-21 #{{ page.anchor }}-output-texture }: Accepts the id of a texture, the optional texture to display when the jar output is present
- `.outputs(jarOutput?: ItemStack, outputItem: ItemStackProvider, outputFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-outputs }: Accepts optionally an item stack; an [[ isp ]]; and a fluid stack, the optional outputs of the recipe
