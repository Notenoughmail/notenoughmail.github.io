---
layout: page
title: Events
permalink: /kubejs_tfc/1.21.1/events/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation of KubeJS TFC's events
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - event
event-sort:
    - type
    - anchor
---

# Events

KubeJS TFC adds several JS events for use in scripts

{% assign events = site.fragments | multi_where: 'cat', page.fragment-filter | clean_fragments | multi_sort: page.event-sort  %}

{% for event in events %}

- [{{ event.title }}](#{{ event.anchor }}) -- `{% if event.type == 'common' %}client_scripts` & `server{% else %}{{ event.type }}{% endif %}_scripts`

{% endfor %}

{% for event in events %}

{: #{{ event.anchor }}}

## {{ event.title }}

{{ event.clean }}

{% endfor %}
