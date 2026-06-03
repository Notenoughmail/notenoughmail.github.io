---
title: Weighted Random Selector
anchor: weighted-random-selector
type: 'worldjs:weighted_random_selector'
name: random_select
sprite: BlockSprite
icon: air
sort_pos: s_r
name: 'kubejs:moonlit_mushrooms'
cat:
    - worldjs
    - 1.21.1
    - feature
example: |-
    .features([
        { weight: 3, value: 'kubejs:moonlit_brown_mushroom' },
        { weight: 2, value: 'kubejs:moonlit_red_mushroom' }
    ])
    .withPlacement(placement => {}) // See the vegetation patch example
    // Kindly provided by Liopyu
---

Creates a `worldjs:weighted_random_selector` configured feature

This works similarly to the [simple random selector](#simple-random-selector) feature type, but only accepts a list of features which can be individually weighted

[[ base ]]

- `.features(features: List<WeightedValue<Holder$Reference<PlacedFeature>>>)`{: .language-kube-21 #{{ page.anchor }}-features }: The features to place as [`WeightedValue`]({% link worldjs/1.21.1/wrappers.md %}#weighted-value)s
    - The list must not be empty
    - [[ required ]]

{% comment %}

## simple-random-selector

{% endcomment %}
