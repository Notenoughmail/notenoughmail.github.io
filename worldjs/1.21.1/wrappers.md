---
layout: page
title: Type Wrappers
permalink: /worldjs/1.21.1/wrappers/
parent: 1.21.1
grand_parent: WorldJS
has_children: false
fragment-filter:
    - worldjs
    - 1.21.1
    - wrapper
---

# Type Wrappers

{% map replacements %}
{% height_provider [height provider](#height-provider) %}
{% vertical_anchor [vertical anchor](#vertical-anchor) %}
{% weighted_value [weighted value](#weighted-value) %}
{% endmap %}

{% assign wrappers = site.fragments | multi_where: 'cat', page.fragment-filter | replace_in_fragments: replacements | clean_fragments | sort: 'title' %}

{% for wrapper in wrappers %}

- [{{ wrapper.title }}](#{{ wrapper.anchor }})

{% endfor %}

{% for wrapper in wrappers %}

{: #{{ wrapper.anchor }}}

## {{ wrapper.title }}

{{ wrapper.clean }}

{% endfor %}

{% comment %}

## height provider

## vertical anchor

## weighted value

{% endcomment %}
