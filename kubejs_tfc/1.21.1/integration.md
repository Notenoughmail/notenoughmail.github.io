---
layout: page
title: Mod Integration
permalink: /kubejs_tfc/1.21.1/integration/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Descriptions and links to integration with other, non-TFC, mods
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - integration
---

# Mod Integration

KubeJS TFC has some optional integrations for TFC addons and other mods. This page serves a directory for those mods and the integration KubeJS TFC has with each

{% assign mods = site.fragments | multi_where: 'cat', page.fragment-filter | clean_fragments | sort: 'name' %}

{% for mod in mods %}

- [{{ mod.title }}](#{{ mod.anchor }})

{% endfor %}

{% for mod in mods %}

{: #{{ mod.anchor }} }

## {{ mod.title }}

{{ mod.clean }}

{% endfor %}
