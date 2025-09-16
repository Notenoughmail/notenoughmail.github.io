---
layout: page
title: 1.20.1
permalink: /kubejs_tfc/1.20.1/
parent: KubeJS TFC
has_children: true
has_toc: false
---

# 1.20.1

{% assign pages = site.pages | where: "grand_parent", "KubeJS TFC" | where: "parent", "1.20.1" %}

{% for page in pages %}

## [{{ page.title }}]({{ page.url }})

{{ page.desc | render_liquid  }}

{% endfor %}
