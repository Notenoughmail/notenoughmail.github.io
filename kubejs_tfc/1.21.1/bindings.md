---
layout: page
title: Bindings
permalink: /kubejs_tfc/1.21.1/bindings/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Fields and methods available under the `TFC` object in scripts
---

# Bindings

All non-event objects and utilities provided by KubeJS TFC are categorized into sub-bindings which are accessible from the `TFC` object as fields

{% assign pages = site.pages | where: "parent", "Bindings" | where: "grand_parent", "1.21.1" | sort: "title" %}

{% for page in pages %}

## [{{ page.title }}]({{ page.url }})

{{ page.desc | render_liquid }}

Accessed as `TFC.{{ page.field }}`

{% endfor %}
