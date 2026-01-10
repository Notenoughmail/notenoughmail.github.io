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

- [{{ event.title }}](#{{ event.anchor }}) -- `{{ event.type | script_type }}`

{% endfor %}

{% for event in events %}

{: #{{ event.anchor }}}

## {{ event.title }}

**Listener**: `TFCEvents.{{ event.name }}(...)`{:.language-kube-21}

{% if event.target-type %}**Target Type**: `{{ event.target-type }}`{:.language-kube-21}{% endif %}

**Script Type**: `{{ event.type | script_type }}`

{{ event.clean }}

{: #{{ event.anchor }}-example }

### Example

```js-21
TFEvents.{{ event.name }}({% if event.target %}'{{ event.target }}', {% endif %}event => { {% for ex in event.example %}
    {{ ex }}{% endfor %}
})
```

{% endfor %}
