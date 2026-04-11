---
title: Sealed Barrel
anchor: sealed-barrel
func: sealed_barrel
mod: tfc
group: barrel
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For performing fluid/item mixing in sealed barrels
example:
    - "Fluid.of('minecraft:milk', 100),"
    - '-1'
example_add:
    - '.inputItem(TFC.ingredient.notRotten())'
    - '.seal('
    - "    TFC.isp.copyInputStack().addTrait('kubejs:milk'),"
    - "    TFC.isp.copyInputStack.removeTrait('kubejs:milk')"
    - ')'
sig:
    - 'inputFluid: SizedFluidIngredient,'
    - 'duration: int'
sig_add:
    - '.outputItem(outputItem: ItemStackProvider)'
    - '.outputFluid(outputFluid: FluidStack)'
    - '.outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)'
    - '.inputItem(inputItem: SizedIngredient)'
    - '.sound(sound: Holder<SoundEvent>)'
    - '.onSeal(onSeal: ItemStackProvider)'
    - '.onUnseal(onUnseal: ItemStackProvider)'
    - '.seal(onSeal: ItemStackProvider, onUnseal: ItemStackProvider)'
---

- 1st argument: A sized fluid ingredient, the fluid input of the recipe
- 2nd argument: An integer number, the sealed duration of the recipe. May be `-1`{:.n} to have an indefinite seal time

<span></span>

- `.outputItem(outputItem: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-output-item }: Accepts an [[ isp ]], the optional item output of the recipe
- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-output_fluid }: Accepts a fluid stack, the optional fluid output of the recipe
- `.outputs(outputItem: ItemStackProvider, outputFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-outputs }: Accepts an [[ isp ]] and a fluid stack, the optional outputs of the recipe

- `.inputItem(inputItem: SizedIngredient)`{: .language-kube-21 #{{ page.anchor }}-input-item }: Accepts a sized item ingredient, the optional item input of the recipe
- `.sound(sound: Holder<SoundEvent>)`{: .language-kube-21 #{{ page.anchor }}-sound }: Accepts the id of a sound event[^1], the sound that plays when the recipe performs
- `.onSeal(onSeal: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-on-seal }: Accepts an [[ isp ]], the provider to apply to the stack when the barrel is sealed
- `.onUnseal(onUnseal: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-on-unseal }: Accepts an [[ isp ]], the provider to apply to the stack when the barrel is unsealed
- `.seal(onSeal: ItemStackProvider, onUnseal: ItemStackProvider)`{: .language-kube-21 #{{ page.anchor }}-seal }: Accepts a pair of [[ isp ]]s, the providers to apply to the stack when sealing and unsealing the barrel

{: .related #{{ page.anchor }}-alias-notice }
> The recipe method present here is an alias for the 'official' recipe type, `.tfc.barrel_sealed(...)`{:.language-kube-21}. Both may be used in place of each other as they have the same methods and semantics

[^1]: A list of available sound events can be gotten by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game
