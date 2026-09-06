---
layout: page
title: Biome Modifiers
permalink: /worldjs/1.21.1/biome-modifiers/
parent: 1.21.1
grand_parent: WorldJS
desc: Biome modifier builder types
---

# Biome Modifiers

NeoForge adds the ability to add [biome modifiers](https://docs.neoforged.net/docs/1.21.1/worldgen/biomemodifier) which enables changing biome properties without completely overriding the whole biome definition. WorldJS adds the ability to create the NeoForge provided modifier types via KubeJS's `ServerEvents.registry('neoforge:biome_modifier', event => {...})`{:.language-kube-21} event

{% map replacements %}
{% biomes `.biomes(biomes: HolderSet<Biome>)`{: .language-kube-21 #[[ anchor ]]-biomes }: Set the biome(s) to be modified %}
{% endmap %}

{% assign types = site | fragments_replace: replacements, 'worldjs', '1.21.1', 'biome_mod' | multi_sort: 'pos', 'anchor' %}

{% grid n=3 %}

{% for type in types %}

- [{{ type.title }}](#{{ type.anchor }})

{% endfor %}

</div>

{% for type in types %}

{: #{{ type.anchor }} }

## {{ type.title }}

**Type**: `{{ type.type }}`

See the relevant page on the [NeoForge Docs](https://docs.neoforged.net/docs/1.21.1/worldgen/biomemodifier#{{ type.anchor }}) for a detailed explanation of what this modifier does

{{ type.clean }}

{: #{{ type.anchor }}-example }

### Example

```js-21
ServerEvents.registry('neoforge:biome_modifier', event => {
    event.create('{{ type | get_or_default: 'name', 'anchor' }}', '{{ type.type }}')
        {{ type.example | with_indent }}
})
```

{% endfor %}
