---
layout: page
title: Minecraft Mods
permalink: /mc/mods/
parent: Minecraft
has_children: true
has_toc: false
---

# Minecraft Mods

Documentation for my various mods

{% assign pages = site.pages | where: 'parent', 'Minecraft Mods' | sort: 'title' %}

{% for page in pages %}

{: #{{ page.title | slugify }} }

## [<img src="/assets/icon/mod/{{ page.icon }}.png" aria-hidden="true" class="inline"> {{ page.title }}]({{ page.permalink }})

{{ page.tagline }}

{% endfor %}
