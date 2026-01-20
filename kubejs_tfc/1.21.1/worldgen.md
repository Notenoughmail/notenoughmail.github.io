---
layout: page
title: Worldgen
permalink: /kubejs_tfc/1.21.1/worldgen/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation on how to create some of TFC's configured features
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - worldgen
---

# Worldgen

Worldgen features are primarily done through placed and configured features. KubeJS TFC adds the ability to make these through builders in the `worldgen/configured_feature` server registry event

{: .unstable #unmerged-pr-warning }
> This functionality relies on an as-yet [unmerged PR](https://github.com/KubeJS-Mods/KubeJS/pull/1085) to KubeJS to properly function. Until that PR is merged and a version with it is released nothing present on this page will work. As a result, everything on this page is liable to change without a full deprecation cycle

{% assign features = site.fragments | multi_where: 'cat', page.fragment-filter | clean_fragments | sort: 'anchor' %}

{% for feature in features %}

- [{{ feature.title }}](#{{ feature.anchor }}) -- `{{ feature.type }}`

{% endfor %}

{% for feature in features %}

{: #{{ feature.anchor }} }

## {{ feature.title }}

**Type**: `{{ feature.type }}`

{{ feature.clean }}

{% endfor %}
