---
layout: page
title: Custom Items
permalink: /kubejs_tfc/1.21.1/items/
parent: 1.21.1
grand_parent: KubeJS TFC
desc: Custom item types
fragment-filter:
    - kubejs_tfc
    - 1.21.1
    - item
---

# Custom Items

KubeJS TFC allows for the create of some of TFC's item types

{% assign items = site.fragments | multi_where: 'cat', page.fragment-filter | clean_fragments | sort: 'anchor' %}

{% for item in items %}

- [{{ item.title }}](#{{ item.anchor }}) -- `{{ item.type }}`

{% endfor %}

<a id="prec-pros"></a>If *Precision Prospecting* {% include mr.html link='' %} {% include cf.html link='' %} is installed, the following item type is supported

- [Prospector](#prec-pros-prospector)

---

{% for item in items %}

{: #{{ item.anchor }} }

## {{ item.title }}

**Type**: `{{ item.type }}`

{{ item.clean }}

{: #{{ item.anchor }}-example }

### Example

```js-21
StartupEvents.registry('item', event => {
    event.create('{{ item | get_or_default: 'name', 'anchor' }}', '{{ item.type }}'){% for ex in item.example %}
        {{ ex }}{% endfor %}
})
```

{% endfor %}

---

{: #prec-pros-prospector }

## Precision Prospecting Prospector

**Type**: `precisionprospecting:prospector`

Creates a new prospector item

Inherits the methods of the [chisel item builder](#chisel)

{: #prec-pros-prospector-methods }

### Extra Methods

- `.builtinType(type: ProspectorType)`{: .language-kube-21 #prec-pros-prospector-builtin-type }: Set the radii, displacement, and prospect tag of the prospector based on a preset. Accepts `pros_hammer`{:.e}, `pros_drill`{:.e}, or `min_pros`{:.e}
- `.level(level: int)`{: .language-kube-21 #prec-pros-prospector-level }: Set the integer level of the prospector, determines the chance the prospector reports a false negative. The chance is calculated from the level as `0.3 - level * (0.3 / 5)`{:.language-kube-21} where `level` is clamped to the range {% range 0,5 %}
- `.prospectTag('tag: TagKey<Block>)`{: .language-kube-21 #prec-pros-prospector-prospect-tag }: Set the tag the prospector will scan for
- `.coolDown(c: int)`{: .language-kube-21 #prec-pros-prospector-cool-down }: Set the cool down of the prospector
- `.primaryRadius(radius: int)`{: .language-kube-21 #prec-pros-prospector-primary-radius }: Set the primary scanning radius of the prospector, defaults to `12`{:.n}
- `.primaryRadiusSupplier(radius: Supplier<int>)`{: .language-kube-21 #prec-pros-prospector-primary-radius-supplier }: Set the primary scanning radius of the prospector as a supplier, defaults to `() => 12`{:.language-kube-21}
- `.secondaryRadius(radius: int)`{: .language-kube-21 #prec-pros-prospector-secondary-radius }: Set the secondary scanning radius of the prospector, defaults to `12`{:.n}
- `.secondaryRadiusSupplier(radius: Supplier<int>)`{: .language-kube-21 #prec-pros-prospector-secondary-radius-supplier }: Set the secondary scanning radius of the prospector as a supplier, defaults to `() => 12`{:.language-kube-21}
- `.displacement(displacement: int)`{: .language-kube-21 #prec-pros-prospector-displacement }: Set the scanning displacement of the prospector, defaults to `0`{:.n}
- `.displacementSupplier(displacement: Supplier<int>)`{: .language-kube-21 #prec-pros-prospector-displacement-supplier }: Set the scanning displacement of the prospector as a supplier, defaults to `() => 0`{:.language-kube-21}

{: #prec-pros-prospector-example }

### Example

```js-21
StartupEvents.registry('item', event => {
    event.create('clay_sniffer', 'precisionprospecting:prospector')
        .level(5)
        .prospectTag('kubejs:prospectable_clay')
        .primaryRadius(20)
        .secondaryRadius(4)
})
```

{% comment %}

## prec pros prospector

## chisel

{% endcomment %}
