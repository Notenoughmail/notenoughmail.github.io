---
title: No Op
anchor: no-op
type: no_op
wiki_link: https://minecraft.wiki/w/No_op?oldid=3283982
sort_pos: ___
cat:
    - worldjs
    - 1.21.1
    - feature
example:
    - ".withPlacement('kubejs:no_op', m => {})"
---

- `.withPlacement(id?: ResourceLocation, builder: Consumer<PlacedFeatureBuilder>)`{: .language-kube-21 #{{ page.anchor }}-with-placement }: Creates and modifies the placed feature which will place the configured feature.
    - `id?: ResourceLocation`{:.language-kube-21}: The id of the placed feature. Defaults to the same id as the configured feature if not provided. Namespace defaults to `kubejs` if not specified
    - `builder: Consumer<PlacedFeatureBuilder>`{:.language-kube-21}: Set the [placement](#placed-features) of the feature

{% comment %}

## placed features

{% endcomment %}
