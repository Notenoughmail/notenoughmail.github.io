---
title: Instant Barrel
anchor: instant-barrel
func: instant_barrel
mod: tfc
group: barrel
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For performing item/fluid mixing in barrels instantly
example:
    - "Fluid.sizedIngredientOf('minecraft:water', 50)"
example_add:
    - ".outputs('minecraft:dirt', Fluid.of('minecraft:milk', 1))"
sig:
    - 'inputFluid: SizedFluidIngredient'
sig_add:
    - '.outputItem(outputItem: ItemStackProvider)'
    - '.outputFluid(outputFluid: FluidStack)'
    - '.outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)'
    - '.inputItem(inputItem: SizedIngredient)'
    - '.sound(sound: Holder<SoundEvent>)'
---

- 1st argument: A sized fluid ingredient, the input fluid

<span></span>

- `.outputItem(outputItem: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-output-item }: Accepts an [[ isp ]], the optional item output of the recipe
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-output_fluid }: Accepts a fluid stack, the optional fluid output of the recipe
- `.outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-outputs }: Accepts an [[ isp ]] and a fluid stack, the optional outputs of the recipe

- `.inputItem(inputItem: SizedIngredient)`{: .language-kube-21 #{{ page.anchor }}-input-item }: Accepts a sized item ingredient, the optional item input of the recipe
- `.sound(sound: Holder<SoundEvent>)`{: .language-kube-21 #{{ page.anchor }}-sound }: Accepts the id of a sound event[^1], the sound that plays when the recipe performs

[^1]: A list of available sound events can be gotten by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game

{: .related #{{ page.anchor }}-alias-notice }
> The recipe method presented here is an alias for the 'official' recipe type, `.tfc.barrel_instant(...)`{:.language-kube-21}. Both may be used in place of the other as they have the same methods and semantics
