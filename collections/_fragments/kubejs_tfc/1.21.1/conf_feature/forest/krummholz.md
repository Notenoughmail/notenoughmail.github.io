---
title: Krummholz
anchor: krummholz
type: krummholz
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/trees/#krummholz
sort_pos: f_k
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_features
example: |-
    // TODO
---

[[ base ]]

- `.krummholz(block: Block)`{: .language-kube-21 #{{ page.anchor }}-krummholz }: The block to place
    - **Must** have TFC's `tip` and `bottom` state properties
    - Defaults to `'tfc:plant/spruce_krummholz'`{:.s}
- `.height(height: intProvider)`{: .language-kube-21 #{{ page.anchor }}-height }: How tall the krummholz can be
    - Defaults to `2`{:.n}
- `.spawnsOnStone()`{: .language-kube-21 #{{ page.anchor }}-spawns-on-stone }: Allows the krummholz to generate on stone
- `.spawnsOnGravel()`{: .language-kube-21 #{{ page.anchor }}-spawns-on-gravel }: Allows the krummholz to generate on gravel
