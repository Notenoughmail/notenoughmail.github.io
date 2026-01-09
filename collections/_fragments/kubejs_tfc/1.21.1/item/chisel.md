---
title: Chisel
anchor: chisel
type: tfc:chisel
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .texture('tfc:item/metal/chisel/copper')
---

Creates a new chisel item

Inherits the methods of the default item builder

{: #chisel-methods }

## Extra Methods

- `.tier(t: Tier)`{: .language-kube-21 #chisel-tier }: Set the tool tier of the chisel
- `.attackDamageBaseline(f: number)`{: .language-kube-21 #chisel-attack-damage-baseline }: Set the base attack damage of the chisel
- `.speedBaseline(f: number)`{: .language-kube-21 #chisel-speed-baseline }: Set the base attack speed of the chisel
- `.modifyTier(tier: Consumer<MutableToolTier>)`{: .language-kube-21 #chisel-modify-tier }: Modifies the tool tier of the chisel
- `.attackDamageBonus(f: number)`{: .language-kube-21 #chisel-attack-damage-bonus }: Set the attack damage bonus of the chisel's tool tier
- `.speed(f: number)`{: .language-kube-21 #chisel-speed }: Set the attack speed bonus of the chisel's tool tier
