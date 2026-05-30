---
layout: page
title: Worldgen
permalink: /kubejs_tfc/1.21.1/worldgen/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Documentation on how to create some of TFC's configured features
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - worldgen
---

# Worldgen

Worldgen features are primarily done through placed and configured features. KubeJS TFC adds the ability to make these through builders in the `worldgen/configured_feature` server registry event

{: .unstable #imminent-rework }
> While this functionality currently works (despite being undocumented) with the latest released version of KubeJS, it is being reworked to depend on [WorldJS]({% link worldjs/1.21.1/index.md %}). Said rework may introduce changes to functions and their behavior and as such usage of these features is done at your own risk

{% assign features = site.fragments | multi_where: 'cat', page.fragment-filter | clean_fragments | sort: 'anchor' %}

{% grid n=2 %}

{% for feature in features %}

- [{{ feature.title }}](#{{ feature.anchor }}) -- `{{ feature.type }}`

{% endfor %}

</div>

{% for feature in features %}

{: #{{ feature.anchor }} }

## {{ feature.title }}

**Type**: `{{ feature.type }}`

{{ feature.clean }}

{: #{{ feature.anchor }}-example }

### Example

```js-21
ServerEVents.registry('minecraft:configured_feature', event => {
    event.create('{{ feature | get_or_default: 'name', 'anchor' }}', '{{ feature.type }}')
        {{ feature.example | with_indent }}
})
```

{% endfor %}
