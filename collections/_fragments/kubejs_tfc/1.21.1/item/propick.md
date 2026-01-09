---
title: Prospector's Pick
anchor: propick
type: tfc:propick
cat:
    - kubejs_tfc
    - 1.21.1
    - item
example:
    - .level(4)
    - .texture('minecraft:block/sand')
---

Creates a new prospector's pick item

Inherits the methods of the [chisel item builder](#chisel)

{: #propick-methods }

## Extra Method

- `.level(level: int)`{: .language-kube-21 #propick-level }: Set the integer level of the pick, determines the chance the pick reports a false negative. The chance is calculated from the level as `0.3 - level * (0.3 / 5)`{:.language-kube-21} where `level` is clamped to the range {% range 0,5 %}
