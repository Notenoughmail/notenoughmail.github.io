---
layout: page
title: Type Wrappers
permalink: /worldjs/1.21.1/wrappers/
parent: 1.21.1
grand_parent: WorldJS
has_children: false
desc: The wrappers for Java types frequently encountered in and handled by WorldJS
---

# Type Wrappers

{% map replacements %}
{% height_provider [height provider](#height-provider) %}
{% vertical_anchor [vertical anchor](#vertical-anchor) %}
{% weighted_value [weighted value](#weighted-value) %}
{% endmap %}

{% assign wrappers = site | fragments_replace: replacements, 'worldjs', '1.21.1', 'wrapper' | sort: 'title' %}

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
