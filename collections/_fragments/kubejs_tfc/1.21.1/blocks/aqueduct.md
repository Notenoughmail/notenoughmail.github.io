---
title: Aqueduct
anchor: aqueduct
group: _
type: tfc:aqueduct
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .allowedFluids([
    - "    'minecraft:water'"
    - "    'minecraft:lava'"
    - "    'kubejs:spring'"
    - "    'tfc:salt_water'"
    - "    'tfc:spring_water'"
    - '])'
---

Creates a new aqueduct block

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.models(models: BiConsumer<AqueductModelPart, ModelGenerator>)`{: .language-kube-21 #{{ page.anchor }}-models }: Set the model generation of the aqueduct. Accepts a callback with two parameters, the second being a model generator and the first having the methods
    - `.base(): boolean`{:.language-kube-21}: If the model part is the base part
    - `.north(): boolean`{:.language-kube-21}: If the model part is the north part
    - `.south(): boolean`{:.language-kube-21}: If the model part is the south part
    - `.east(): boolean`{:.language-kube-21}: If the model part is the east part
    - `.west(): boolean`{:.language-kube-21}: If the model part is the west part
- `.allowedFluids(fluids: ResourceLocation[])`{: .language-kube-21 #{{ page.anchor }}-allowed-fluids }: Set the fluids the aqueduct may contain
