---
title: Pointed Dripstone
anchor: pointed-dripstone
type: pointed_dripstone
wiki_link: https://minecraft.wiki/w/Dripstone_(feature)?oldid=3522490
sprite: BlockSprite
sort_pos: d
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.chanceOfTallerDripstone(chance: number)`{: .language-kube-21 #{{ page.anchor }}-chance-of-taller-dripstone }: The probability of a two tall dripstone generating
    - [[ unit ]]
    - Defaults to `0.2`{:.n}
- `.chanceOfDirectionalSpread(chance: number)`{: .language-kube-21 #{{ page.anchor }}-chance-of-directional-spread }: The probability a dripstone spreads in a horizontal direction
    - [[ unit ]]
    - Defaults to `0.7`{:.n}
- `.chanceOfSpreadRadius2(chance: number)`{: .language-kube-21 #{{ page.anchor }}-chance-of-spread-radius-2 }: The probability dripstone spreads horizontally two blocks
    - [[ unit ]]
    - Defaults to `0.5`{:.n}
- `.chanceOfSpreadRadius3(chance: number)`{: .language-kube-21 #{{ page.anchor }}-chance-of-spread-radius-3 }: The probability dripstone spreads horizontally a third block after the second block spread
    - [[ unit ]]
    - Defaults to `0.5`{:.n}
