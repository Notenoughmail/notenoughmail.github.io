---
layout: page
title: 1.21.1
permalink: /kubejs_tfc/1.21.1/
parent: KubeJS TFC
has_children: true
has+toc: false
---

# 1.21.1

{% assign pages = site.pages | where: "grand_parent", "KubeJS TFC" | where: "parent", "1.21.1" %}

{% for page in pages %}

## [{{ page.title }}]({{ page.url }})

{{ page.desc | render_liquid }}

{% endfor %}
