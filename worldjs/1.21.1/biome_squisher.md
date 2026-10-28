---
layout: page
title: Biome Squisher
permalink: /worldjs/1.21.1/biome-squisher/
parent: 1.21.1
grand_parent: WorldJS
has_toc: false
has_children: false
desc: Creating Biome Squisher's injectors through scripts
---

# {{ page.title }}

[Biome Squisher](https://github.com/lukebemishprojects/BiomeSquisher#biome-squisher) {% include mr.html link='biomesquisher' %} {% include cf.html link='biomesquisher' %} is a small utility mod for injection biomes into existing (noise-based) dimensions. it does so by 'squishing' existing biomes out of the way in biome space and placing the new biome into the created hole[^1]

[^1]: A much more complete and in-depth explanation is available on [Biome Squisher's GitHub](https://github.com/lukebemishprojects/BiomeSquisher#biome-squisher)

WorldJS adds the ability to define Biome Squisher's injectors through scripts

{% map replacements %}
{% squisher %}squisher{% end_squisher %}
{% def_0 %}Defaults to `0`{:.n}{% end_def_0 %}
{% def_1 %}Defaults to `1`{:.n}{% end_def_1 %}
{% def_l %}Defaults to `-0.1`{:.language-kube-21}{% end_def_l %}
{% def_h %}Defaults to `0.1`{:.n}{% end_def_h %}
{% unit %}Must be {% in_unit %}{% end_unit %}
{% squish %}squisher{% end_squish %}
{% endmap %}

{% assign types = site | fragments_replace: replacements, 'worldjs', '1.21.1', 'biome_squisher' | sort: 'title' %}

{% for type in types %}

- [{{ type.title }}](#{{ type.anchor }})

{% endfor %}

{% for type in types %}

{: #{{ type.anchor }}}

## {{ type.title }}

**Registry Type**: `biomesquisher:{{ type | get_or_default: 'reg' , 'anchor' }}`

{{ type.clean }}

{: #{{ type.anchor }}-example }

### Example

```js-21
ServerEvents.registry('biomesquisher:{{ type | get_or_default: 'reg' , 'anchor' }}', event => {
    event.create('{{ type | get_or_default: 'name', 'reg', 'anchor' }}')
        {{ type.example | with_indent }}
})
```

{% endfor %}
