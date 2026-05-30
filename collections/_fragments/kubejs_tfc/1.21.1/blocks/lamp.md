---
title: Lamp
anchor: lamp
group: _
type: tfc:lamp
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example: |-
    .texture('particle', 'minecraft:block/chain')
    .texture('metal', 'tfc:block/metal/smooth/steel')
    .texture('chain', 'minecraft:block/chain')
    .models((type, m) => {
        if (type.hanging) m.parent('kubejs:block/hanging_lamp')
    })
    .lightLevel(7)
---

Creates a new lamp block

[[ base ]]

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.models(models: BiConsumer<LampModelType, ModelGenerator>)`{: .language-kube-21 #{{ page.anchor }}-models }: Set the model generation of the lamp. Accepts a callback with two parameters, the second being a model generator and the first having two fields
    - `.on: boolean`{:.language-kube-21}: If the model is for an lit state
    - `.hanging: boolean`{:.language-kube-21}: If the model is for a hanging state
- `.lightLevel(light: int)`{: .language-kube-21 #{{ page.anchor }}-light-level }: Set the light level, {% in_range 0,15 %}, of the lamp while lit
- [[ props ]]
