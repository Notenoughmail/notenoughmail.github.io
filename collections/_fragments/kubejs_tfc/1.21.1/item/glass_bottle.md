---
title: Glass Bottle
anchor: glass-bottle
type: tfc:glass_bottle
name: glass_bottle
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .breakChance(0.05)
    - .capacity(120)
    - .allowedFluids('kubejs:glass_safe')
---

Creates a new glass bottle item

Inherits the methods of the [jug item builder](#jug)

{: #glass-bottle-methods }

## Extra Methods

- `.breakChance(chance: number)`{: .language-kube-21 #glass-bottle-break-chance }: Set the chance, {% in_range 0,1 %}, the bottle will break each time it is drunk from. Defaults to `0.5`{:.n}
- `.breakChanceSupplier(chance: Supplier<number>)`{: .language-kube-21 #glass-bottle-break-chance-supplier }: Set the chance, {% in_unit %}, the bottle will break each time is drunk from via a supplier. Defaults to `() => 0.5`{:.language-kube-21}
