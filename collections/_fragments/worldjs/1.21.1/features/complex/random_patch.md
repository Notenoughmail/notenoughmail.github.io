---
title: Random Patch
anchor: random-patch
type: random_patch
wiki_link: https://minecraft.wiki/w/Vegetation?oldid=3566374
sort_pos: r
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.tries(tires: int)`{: .language-kube-21 #{{ page.anchor }}-tries }: The number of attempts to generate
    - Defaults to `128`{:.n}
- `.xzSpread(spread: int)`{: .language-kube-21 #{{ page.anchor }}-x-z-spread }: The horizontal spread range
    - Must be non-negative
    - Defaults to `7`{:.n}
- `.ySpread(spread: int)`{: .language-kube-21 #{{ page.anchor }}-y-spread }: The vertical spread range
    - Must be non-negative
    - Defaults to `3`{:.n}
- `.feature(placedFeature: Holder$Reference<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-feature }: The placed feature to generate multiple of
    - [[ required ]]
