---
title: Thin Spike
anchor: thin-spike
type: tfc:thin_spike
name: thin_spike
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .dripChance(0.2)
    - .dripTemperature(12)
    - .dripParticle('minecraft:falling_spore_blossom')
---

Creates a new thin spike block

Inherits the methods of default block builder

{: #thin-spike-methods }

## Extra Methods

- `.dripChance(chance: number)`{: .language-kube-21 #thin-spike-drip-chance }: Set the chance, {% in_unit %}, the block will drip per tick
- `.dripTemperature(temperature: number)`{: .language-kube-21 #thin-spike-drip-temperature }: Set the temperature (°C) above which the spike will produce drip particles
- `.dripParticle(particle: @Nullable Holder<ParticleType<?>>)`{: .language-kube-21 #thin-spike-drip-particle }: Set the drip particle options of the spike via the id of a particle type[^1] or `null`{:.p} to indicate the spike does not drip
- `.fullDripParticle(particle: Supplier<ParticleOptions>)`{: .language-kube-21 #thin-spike-full-drip-particle }: Set the drip particle options of the spike
- `.tipModel(model: ResourceLocation)`{: .language-kube-21 #thin-spike-tip-model }: Set the model to use for the tip state of the spike

[^1]: A full list of particle types can be obtained by running the command `/kubejs dump_registry minecraft:particle_type`{:.language-command} in-game. Though do note that not all of them provide a `ParticleOptions`
