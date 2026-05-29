---
title: Random Boolean Selector
anchor: random-boolean-selector
type: random_boolean_selector
wiki_link: https://minecraft.wiki/w/Random_boolean_selector?oldid=3157350
sprite: BlockSprite
icon: air
sort_pos: s_r
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - // TODO
---

[[ base ]]

- `.featureTrue(feature: Holder$Reference<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-feature-true }: The id of a feature to place on a random `true`{:.p} result
    - [[ required ]]
- `.featureFalse(feature: Holder$Reference<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-feature-false }: The if of the feature to place on a random `false`{:.p} result
    - [[ required ]]
