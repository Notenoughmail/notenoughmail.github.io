---
layout: page
title: Type Explanations
permalink: /kubejs_tfc/1.21.1/type-explanations/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Explanations of certain Java types that may be encountered in various simple and complex situations
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

# Type Explanations

There are several Java types which can be encountered fairly frequently in the docs or are too complex to describe in-line along with other, perhaps more pertinent, information. Those are collected here

{% assign sections = site.fragments | multi_where: 'cat', page.fragment-filter | clean_fragments | sort: 's' %}

{% for section in sections %}

- [{{ section.title | render_liquid }}](#{{ section.anchor }}){% if section.preserve-color %}{: .preserve-color }{% endif %}

{% endfor %}

{% for section in sections %}

{: #{{ section.anchor }} }

## {{ section.title | render_liquid }}

{{ section.clean }}

{% endfor %}
