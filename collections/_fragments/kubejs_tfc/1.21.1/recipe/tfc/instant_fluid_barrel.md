---
title: Instant Fluid Barrel
anchor: instant-fluid-barrel
func: instant_fluid_barrel
mod: tfc
group: barrel
cat:
    - kubejs_tfc
    - 1.21.1
    - recipe
tagline: For performing fluid/fluid mixing in barrels instantly
example:
    - "Fluid.of('minecraft:water', 20),"
    - "Fluid.of('minecraft:milk', 10)"
example_add:
    - ".outputFluid(Fluid.of('minecraft:lava', 50))"
sig:
    - 'primaryFluid: SizedFluidIngredient,'
    - 'addedFluid: SizedFluidIngredient'
sig_add:
    - '.outputFluid(outputFluid: FluidStack)'
    - '.sound(sound: Holder<SoundEvent>)'
---

- 1st argument: A sized fluid ingredient, the fluid in the barrel's tank
- 2nd argument: A sized fluid ingredient, the fluid added to the `priamryFluid`{:.v} by a fluid container item

<span></span>

- `.outputFluid(outputFluid: FluidStack)`{: .language-kube-21 #{{ page.anchor }}-output-fluid }: Accepts a fluid stack, the result of the recipe
- `.sound(sound: Holder<SoundEvent>)`{: .language-kube-21 #{{ page.anchor }}-sound }: Accepts the id of a sound event[^1], the sound that plays when the recipe performs

{: .related #{{ page.anchor }}-alias-notice }
> The recipe method presented here is an alias for the 'official' recipe type, `.tfc.barrel_instant_fluid(...)`{:.language-kube-21}. Both may be used in place of each other as they have the same methods and semantics

[^1]: A list of available sound events can be gotten by running the command `/kubejs dump_registry minecraft:sound_event`{:.language-command} in-game
