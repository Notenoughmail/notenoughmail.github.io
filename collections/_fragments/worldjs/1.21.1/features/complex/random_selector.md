---
title: Random Selector
anchor: random-selector
type: random_selector
wiki_link: https://minecraft.wiki/w/Random_selector?oldid=3227688
sprite: BlockSprite
icon: air
sort_pos: s_r
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    // TODO
---

[[ base ]]

- `.withFeature(feature: Holder$Reference<PlacedFeature>, chance: float)`{: .language-kube-21 #{{ page.anchor }}-with-feature }: Adds the weighted feature to the list of possible features
    - `feature: Holder$Reference<PlacedFeature>`{:.language-kube-21}: the id of the feature to place
    - `chance: float`{:.language-kube-21}: The chance, {% in_unit %}, the `feature`{:.v} is placed
    - **Note**: Feature chances are evaluated sequentially and the first to place will be the *only* feature to place
- `.defaultFeature(feature: Holder$Reference<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-default-feature }: The feature to place if all [chanced features](#{{ page.anchor }}-with-feature) fail to place
    - [[ required ]]
