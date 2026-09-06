---
layout: page
title: Events
permalink: /kubejs_tfc/1.21.1/events/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation of KubeJS TFC's events
---

# Events

KubeJS TFC adds several JS events for use in scripts

{% assign events = site | fragments: 'kubejs_tfc', '1.21.1', 'event' | multi_sort: 'type', 'anchor'  %}

{% grid n=2 %}

{% for event in events %}

- [{{ event.title }}](#{{ event.anchor }}) -- `{{ event.type | script_type }}`

{% endfor %}

</div>

{% for event in events %}

{: #{{ event.anchor }}}

## {{ event.title }}

**Listener**: `TFCEvents.{{ event.name }}({% if event.target-type %}target: {{ event.target-type }},{% endif %}...)`{:.language-kube-21}

{% if event.target-type %}**Target Type**: `{{ event.target-type }}`{:.language-kube-21}{% endif %}

**Script Type**: `{{ event.type | script_type }}`

{{ event.clean }}

{: #{{ event.anchor }}-example }

### Example

```js-21
TFCEvents.{{ event.name }}({% if event.target %}'{{ event.target }}', {% endif %}event => {
    {{ event.example | with_indent: 4 }}
})
```

{% endfor %}
