---
title: Rock Spike
anchor: rock-spike
group: _
name: rock_spike
type: tfc:rock_spike
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example: |-
    .models((type, m) => {
        if (type.base()) m.parent('minecraft:block/honey_block')
    })
    .anchor('anchor', anchor => {
        anchor.texture('tfc:block/alabaster/polished/red')
    })
---

Creates a new rock spike block

[[ base ]]

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.models(models: BiConsumer<SpikeModelType, ModelGenerator>)`{: .language-kube-21 #{{ page.anchor }}-models }: Set the model generation of the rock spike. Accepts a callback with two parameters, the second being a model generator and the first having the methods
    - `.base(): boolean`{:.language-kube-21}: If the model is for the base state
    - `.middle(): boolean`{:.language-kube-21}: If the model is for the middle state
    - `.tip(): boolean`{:.language-kube-21}: If the model is for the tip state
- `.anchor(id?: ResourceLocation, anchor: Consumer<RopeRockAnchorBlockBuilder>)`{: .language-kube-21 #{{ page.anchor }}-anchor }: Set the properties of the spike's rope anchor block. Accepts a consumer with the following methods:
    - [[ raw_props ]]
    - [[ def ]]
