---
title: Soil Disc
anchor: soil-disc
type: soil_disc
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#soil-disc
sort_pos: s
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ base ]]

- `.replacementStates(state: Map<Block, BlockState>)`{: .language-kube-21 #{{ page.anchor }}-replacement-states }: A mapping defining the block replacements of the disc
    - [[ required ]]
- `.radius(min: int, max: int)`{: .language-kube-21 #{{ page.anchor }}-radius }: The minimum and maximum horizontal radius of the disc
    - [[ pos ]]
    - Defaults to `3`{:.n} and `5`{:.n}
- `.height(h: int)`{: .language-kube-21 #{{ page.anchor }}-height }: The height of the disc
    - Must be {% in_range 0,256 %}
    - Defaults to `2`{:.n}
- `.integrity(i: number)`{: .language-kube-21 #{{ page.anchor }}-integrity }: The portion of the disc's area that is replaced
    - [[ unit ]]
    - [[ def_1 ]]
