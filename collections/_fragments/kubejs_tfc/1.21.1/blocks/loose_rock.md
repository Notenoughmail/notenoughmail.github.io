---
title: Loose Rock
anchor: loose-rock
group: _
name: loose_rock
type: tfc:loose_rock
cat:
    - kubejs_tfc
    - 1.21.1
    - block
example:
    - .rockCategory('sedimentary')
    - .collision()
---

Creates a new loose rock block

Inherits the methods of the default block builder

{: #{{ page.anchor }}-methods }

## Extra Methods

- `.collision()`{: .language-kube-21 #{{ page.anchor }}-collision }: Makes the block have collision
- `.rockCategory(category: String)`{: .language-kube-21 #{{ page.anchor }}-rock-category }: Set the parent models used by the default model generator. Accepts `igneous_intrusive`, `igneous_extrusive`, `metamorphic`, or `sedimentary`
- `.models(models: BiConsumer<PebbleCount, ModelGenerator>)`{: .language-kube-21 #{{ page.anchor }}-models }: Set the model generation of the block. Accepts a callback with two parameters, the second being a model generator and the first being an object with a `.count: int`{:.language-kube-21} field, the number of pebbles that state represents
