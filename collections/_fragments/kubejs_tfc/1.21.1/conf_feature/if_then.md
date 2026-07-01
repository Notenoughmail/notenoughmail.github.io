---
title: If Then
anchor: if-then
type: if_then
wiki_link: https://terrafirmacraft.github.io/Documentation/1.21.x/worldgen/features/#if-then
sort_pos: i
cat:
    - kubejs_tfc
    - 1.21.1
    - conf_feature
example: |-
    // TODO
---

[[ base ]]

- `.features(ifFeature: Holder<PlacedFeature>, thenFeature: Holder<PlacedFeature>)`{: .language-kube-21 #{{ page.anchor }}-features }: The features to place
    - `ifFeature: Holder<PlacedFeature>`{:.language-kube-21}: The primary feature, will always try to place
        - [[ required ]]
    - `thenFeature: Holder<PlacedFeature>`{:.language-kube-21}: The secondary feature, which will only place if the `ifFeature`{:.v} places
        - [[ required ]]
