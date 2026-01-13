---
title: Spreading Berry Bush
anchor: spreading-berry-bush
group: bush
type: tfc:spreading_berry_bush
name: spreading_berry_bush
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .maxHeight(5)
    - .cane(cane => {
    - "    cane.texture('minecraft:block/red_concrete_powder')"
    - '})'
---

Creates a new spreading berry bush block

Inherits the methods of the [stationary berry bush builder](#stationary-berry-bush)

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.cane(cane: Consumer<SpreadingCaneBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-cane }: Set the properties of the cane bush block. Accepts a consumer with the methods
    - `.model(lifecycle: Lifecycle, stage: int, modelGenerator: Consumer<ModelGenerator>)`{:.language-kube-21}: Set the model for a given lifecycle and growth stage
    - `.models(models: TriConsumer<Lifecycle, int, ModelGenerator>)`{:.language-kube-21}: Set the model generation for all lifecycle and growth stages via a callback with the params
        - `lifecycle: Lifecycle`{:.language-kube-21}: The lifecycle the model is for
        - `stage: int`{:.language-kube-21}: The growth stage the model is for, {% in_range 0,2 %}
        - `model: ModelGenerator`{:.language-kube-21}: The model generator for the lifecycle & stage
    - All those of the default block builder
- `.maxHeight(height: int)`{: .language-kube-21 #{{ page.anchor }}-max-height }: Set the max height the bush can grow to be, defaults to `3`{:.n}
