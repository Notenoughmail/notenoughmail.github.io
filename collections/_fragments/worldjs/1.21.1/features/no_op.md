---
title: No Op
anchor: no-op
type: no_op
sort: ___
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - ".withPlacement('kubejs:no_op', m => {})"
---

Creates a [minecraft:no_op](https://minecraft.wiki/w/No_op) configured feature

- `.withPlacement(id?: ResourceLocation, builder: Consumer<PlacedFeatureBuilder>)`{: .language-kube-21 #{{ page.anchor }}-with-placement }: Creates and modifies the placed feature which will place the configured feature.
    - `id?: ResourceLocation`{:.language-kube-21}: The id of the placed feature. Defaults to the same as the configured feature. Namespace defaults to `kubejs` if not specified.
    - `builder: Consumer<PlacedFeatureBuilder>`{:.language-kube-21}: Set the [placement](#placed-features) of the feature

{% comment %}

## placed features

{% endcomment %}
